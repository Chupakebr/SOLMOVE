*&---------------------------------------------------------------------*
*& Report  ZMOVE
*&
*&---------------------------------------------------------------------*
*& Main report for moving document data from one solman to another
*&
*&---------------------------------------------------------------------*
report zmove.

types:
  begin of ts_obj_id_struct,
    obj_id type crmt_object_id_db,
  end of ts_obj_id_struct.

types:
  begin of ts_order_data,
    object_id	type crmt_object_id_db,
    guid      type crmt_object_guid,
  end of ts_order_data.

data:
  lt_obj_id         type table of ts_obj_id_struct with header line,
  lr_obj_id         type range of crmt_object_id_db,
  lt_orders_data    type table of ts_order_data,
  ls_order_data     type ts_order_data,
  lv_total_lines    type i,
  ls_doc_properties type zdoc_props_struct,
  lt_messages       type zprocess_log_tt,
  ls_message        type tdline,
  oref              type ref to cx_root.

select-options p_obj_id for lt_obj_id-obj_id no intervals default 8000000060.
parameters p_rfc    type rfcdwf default 'NONE'.
parameters p_ttype  type crmt_process_type_db default 'S1MJ'.
parameters p_update as checkbox default 'X'.
parameters p_test   as checkbox default 'X'.

start-of-selection.

  "Select documents to be transfered
  select business_transaction~object_id,
    business_transaction~guid
    from crmd_orderadm_h as business_transaction
    where business_transaction~object_id in @p_obj_id
    and  business_transaction~process_type = @p_ttype
    into table @lt_orders_data.

  lv_total_lines = lines( lt_orders_data ).

  if sy-subrc eq 0.

    loop at lt_orders_data into ls_order_data.
      clear: lt_messages.
      clear: ls_doc_properties.

      "get data to transfer

      call method zcl_solmove_helper=>get_doc_data
        exporting
          iv_guid               = ls_order_data-guid
        importing
          lt_doc_properties     = ls_doc_properties
        exceptions
          error_read_doc        = 1
          error_get_attachments = 2
          error_no_target_ttype = 3
          others                = 4.
      if sy-subrc <> 0.
        write: / 'Error reading document: '.
        write: ls_order_data-object_id.
        write: / 'Error id:'.
        write: sy-subrc.
      else.

        if p_update is not initial.
          ls_doc_properties-update = 'X'.
        endif.

        if p_test is initial.

          try.

              "call RFC to create documnet in target system
              call function 'Z_CREATE_DOC'
                destination p_rfc
                exporting
                  is_documentprops = ls_doc_properties
                importing
                  et_messages      = lt_messages.


              loop at lt_messages into ls_message.
                "processing results:
                write: / ls_message. "Processed Message
              endloop.

            catch cx_root into oref.
              write: 'Unhandled Error while creating document'.
          endtry.

        else.
          write: / 'Test read for document: '.
          write: ls_order_data-object_id.
          write: 'successful'.
        endif.
      endif.

      "indicate process status
      cl_progress_indicator=>progress_indicate(
          i_text               = 'Processed &1 % (&2 of &3 records)'
          i_processed          = sy-tabix
          i_total              = lv_total_lines
          i_output_immediately = abap_false ).

    endloop.

    write: / 'Total: '.
    write: lv_total_lines.
    write: ' documents was processed'.

  endif.

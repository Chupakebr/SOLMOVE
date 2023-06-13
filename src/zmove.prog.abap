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
  ls_messages       type tdline.

select-options p_obj_id for lt_obj_id-obj_id no intervals default 8000000060.
parameters p_rfc    type rfcdwf default 'NONE'.
parameters p_ttype  type crmt_process_type_db default 'S1MJ'.
parameters p_test as checkbox default 'X'.

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
      clear: ls_messages.
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

        if p_test is initial.

          "call RFC to create documnet in target system
          call function 'Z_CREATE_DOC'
            destination p_rfc
            exporting
              is_documentprops = ls_doc_properties
            importing
              et_messages      = ls_messages.

          "processing results:
          write: / ls_messages. "Processed Message

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

    "smud information
*    DATA ls_crm               TYPE v_change.
*    DATA lt_crm               TYPE TABLE OF v_change.
*    DATA occ_id               TYPE smud_guid22.
*    SELECT SINGLE * FROM v_change INTO ls_crm WHERE object_id = ls_order_data-object_id.

*    if ls_crm-sbom_id is not initial.
*      select single occ_id from smud_sbom into occ_id where sbom_id = ls_crm-sbom_id.
*      if occ_id is not initial.
*      endif.
*    endif.

    data ao_sbom_query        type ref to if_smud_sbom_query1.
    data as_crm         type crmd_orderadm_h.
    data app_id       type smud_crm_guid.
    data app_type     type smud_sbom_type.
    data ao_sbom_h_query      type ref to if_smud_sbom_h_query.

    select single * from crmd_orderadm_h into as_crm where object_id = ls_order_data-object_id.

    if as_crm-guid is not initial.
      app_id  = as_crm-guid.
      app_type = cl_smud_sbom_typedef=>cs_sbom_type-cd.
    endif.

    ao_sbom_query         = cl_smud_sbom_api=>new( )->new_query1( ).
    ao_sbom_h_query       = cl_smud_sbom_api=>new( )->new_sbom_h_query( ).
    data(lt_sbom_h) = ao_sbom_h_query->select_sbom_4_app_id(
        i_app_id     = app_id
        i_app_type   = app_type ).


    loop at lt_sbom_h into data(as_sbom_h).
      ao_sbom_query->select_occ_of_sbom(
          exporting
            iv_sbom_id  = as_sbom_h-sbom_id
          importing
            et_occ_id   = data(et_occ_id) ).
    endloop.
  endif.

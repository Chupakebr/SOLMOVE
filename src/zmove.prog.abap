*&---------------------------------------------------------------------*
*& Report  ZMOVE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report zmove.

types:
  begin of ts_obj_id_struct,
    obj_id type crmt_object_id_db,
  end of ts_obj_id_struct.

types:
  begin of ts_order_data,
    object_id	  type crmt_object_id_db,
    guid        type crmt_object_guid,
    description type crmt_process_description,
    created_at  type comt_created_at_usr,
    product_id  type comt_product_id,
    stat_schema type j_stsma,
  end of ts_order_data.

data:
  lt_obj_id         type table of ts_obj_id_struct with header line,
  lr_obj_id         type range of crmt_object_id_db,
  lt_orders_data    type table of ts_order_data,
  ls_order_data     type ts_order_data,
  lv_total_lines    type i,
  lt_doc_properties type zitsm_props_t,
  ls_doc_properties like line of lt_doc_properties,

  ls_log            type bal_s_log,
  lt_log_handle     type bal_t_logh,
  ls_log_handle     type balloghndl,
  lt_messages       type table of tdline,
  ls_messages       type tdline,
  ls_message        type bal_s_msg.

select-options p_obj_id for lt_obj_id-obj_id no intervals.
parameters p_rfc    type rfcdwf default 'NONE'.
"parameters p_type   type crmt_process_type_db.

start-of-selection.

  select business_transaction~object_id,
    business_transaction~guid,
    business_transaction~description,
    business_transaction~created_at,
    s_refobj~product_id,
    proc_h~user_stat_proc
    from crmd_orderadm_h as business_transaction
      left join crmd_link as bp_link_p on bp_link_p~guid_hi = business_transaction~guid and bp_link_p~objtype_set = '07'
      left join crmd_srv_osset as s_osset on s_osset~guid_set = bp_link_p~guid_set
      left join crmd_srv_refobj as s_refobj on s_refobj~guid_ref = s_osset~guid
      left join crmc_proc_type as proc_h on proc_h~process_type = business_transaction~process_type
      where "business_transaction~process_type eq @p_type "and
             business_transaction~object_id in @p_obj_id
      into table @lt_orders_data.

  lv_total_lines = lines( lt_orders_data ).

  if sy-subrc eq 0.

    ls_log-object = 'ZLOG'.
    ls_log-subobject  = 'EXT_FIELDS'.
    ls_log-aluser     = sy-uname.
    ls_log-alprog     = sy-repid.

    call function 'BAL_LOG_CREATE'
      exporting
        i_s_log                 = ls_log
      importing
        e_log_handle            = ls_log_handle
      exceptions
        log_header_inconsistent = 1
        others                  = 2.


    loop at lt_orders_data into ls_order_data.
      clear: lt_messages.
      clear: ls_message.

      "call RFC to create documnet in target system
      call function 'Z_DOC_CREATE'
        destination p_rfc
        exporting
          it_documentprops = lt_doc_properties
        importing
          et_messages      = lt_messages.

      "Log outputadd message to a log
      if lt_messages is not initial.
        loop at lt_messages into ls_messages.
          ls_message-msgty = 'E'.
          ls_message-msgv1 = ls_messages.
          ls_message-msgid = 'ITSM'.
          ls_message-msgno = '001'.
        endloop.
      else.
        ls_message-msgty = 'I'.
        concatenate 'Document' ls_order_data-object_id 'processed sucsessfuly' into ls_message-msgv1 separated by space.
        ls_message-msgid = 'ITSM'.
        ls_message-msgno = '001'.
      endif.

      call function 'BAL_LOG_MSG_ADD'
        exporting
          i_log_handle     = ls_log_handle
          i_s_msg          = ls_message
        exceptions
          log_not_found    = 1
          msg_inconsistent = 2
          log_is_full      = 3
          others           = 4.

      append ls_log_handle to lt_log_handle.

      "indicate process status
      cl_progress_indicator=>progress_indicate(
          i_text               = 'Processed &1 % (&2 of &3 records)'
          i_processed          = sy-tabix
          i_total              = lv_total_lines
          i_output_immediately = abap_false ).

    endloop.

    "display programm output
    call function 'BAL_DB_SAVE'
      exporting
        i_t_log_handle   = lt_log_handle
      exceptions
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        others           = 4.
    call function 'BAL_DSP_LOG_DISPLAY'
      exporting
        i_t_log_handle = lt_log_handle
      exceptions
        others         = 1.

  endif.

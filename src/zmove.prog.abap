*&---------------------------------------------------------------------*
*& Report  ZMOVE
*&
*&---------------------------------------------------------------------*
*& Main report for moving document data from one solman to another
*&
*&---------------------------------------------------------------------*
REPORT zmove LINE-SIZE 500.

TYPES:
  BEGIN OF ts_obj_id_struct,
    obj_id TYPE crmt_object_id_db,
  END OF ts_obj_id_struct.

TYPES:
  BEGIN OF ts_order_data,
    object_id	TYPE crmt_object_id_db,
    guid      TYPE crmt_object_guid,
  END OF ts_order_data.

TYPES:
  BEGIN OF ts_output,
    object_id	TYPE crmt_object_id_db,
    message   TYPE char100,
  END OF ts_output.

DATA:
  lt_obj_id         TYPE TABLE OF ts_obj_id_struct WITH HEADER LINE,
  lt_output         TYPE TABLE OF ts_output,
  ls_output         TYPE ts_output,
  lr_obj_id         TYPE RANGE OF crmt_object_id_db,
  lt_orders_data    TYPE TABLE OF ts_order_data,
  ls_order_data     TYPE ts_order_data,
  lv_total_lines    TYPE i,
  ls_doc_properties TYPE zdoc_props_struct,
  lt_messages       TYPE zprocess_log_tt,
  ls_message        TYPE tdline,
  oref              TYPE REF TO cx_root,
  lv_answer_odpc    TYPE char1.

SELECT-OPTIONS p_obj_id FOR lt_obj_id-obj_id NO INTERVALS. "DEFAULT 8000000060.
PARAMETERS p_rfc    TYPE rfcdwf DEFAULT 'NONE'.
PARAMETERS p_ttype  TYPE crmt_process_type_db DEFAULT 'S1MJ'.
PARAMETERS p_update AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_status AS CHECKBOX DEFAULT ''. "! if document in closed status no updates are posible.
PARAMETERS p_texts  AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_soldoc AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_attach AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_tr     AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_log    AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_test   AS CHECKBOX DEFAULT 'X'.

START-OF-SELECTION.

  "Select documents to be transfered
  SELECT business_transaction~object_id,
    business_transaction~guid
    FROM crmd_orderadm_h AS business_transaction
    WHERE business_transaction~object_id IN @p_obj_id
    AND  business_transaction~process_type = @p_ttype
    INTO TABLE @lt_orders_data.
  IF sy-subrc EQ 0.

    IF p_update IS INITIAL AND p_test IS INITIAL.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = text-001
          text_question         = text-002
          text_button_1         = text-003
          text_button_2         = text-004
          default_button        = '1'
          display_cancel_button = 'X'
        IMPORTING
          answer                = lv_answer_odpc
        EXCEPTIONS
          OTHERS                = 1.
      IF lv_answer_odpc = '2'.
        p_update = 'X'.
      ELSEIF  lv_answer_odpc = 'A'.
        EXIT.
      ENDIF.
    ENDIF.

    IF p_status IS NOT INITIAL AND p_test IS INITIAL.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = text-005
          text_question         = text-006
          text_button_1         = text-007
          text_button_2         = text-008
          default_button        = '1'
          display_cancel_button = 'X'
        IMPORTING
          answer                = lv_answer_odpc
        EXCEPTIONS
          OTHERS                = 1.
      IF lv_answer_odpc = '2'.
        p_status = ''.
      ELSEIF  lv_answer_odpc = 'A'.
        EXIT.
      ENDIF.
    ENDIF.

    lv_total_lines = lines( lt_orders_data ).

    LOOP AT lt_orders_data INTO ls_order_data.
      CLEAR: lt_messages.
      CLEAR: ls_doc_properties.
      CLEAR: ls_output.
      IF p_update = 'X'.
        ls_doc_properties-update = 'X'.
      ENDIF.

      ls_output-object_id = ls_order_data-object_id.

      "get data to transfer
      CALL METHOD zcl_solmove_helper=>get_doc_data
        EXPORTING
          iv_guid               = ls_order_data-guid
        IMPORTING
          lt_doc_properties     = ls_doc_properties
          ev_message            = lt_messages
        EXCEPTIONS
          error_read_doc        = 1
          error_get_attachments = 2
          error_no_target_ttype = 3
          error_no_id           = 4
          error_no_guid         = 5
          OTHERS                = 6.
      IF sy-subrc <> 0.
        CASE sy-subrc.
          WHEN 3.
            CONCATENATE 'Please mapp t-type:' p_ttype 'in table ZSOLMOVE_MAPPING' INTO ls_output-message SEPARATED BY space.
          WHEN 4 OR 6.
            ls_output-message = 'Please add external id/guid field for ext. system (table ZSOLMOVE_MAPPONG)'.
          WHEN OTHERS.
            ls_output-message = 'Error reading document.'.
        ENDCASE.
        APPEND ls_output TO lt_output.
      ELSE.
        LOOP AT lt_messages INTO ls_message.
          "processing results:
          ls_output-message = ls_message.
          APPEND ls_output TO lt_output.
        ENDLOOP.
        IF p_status IS INITIAL.
          CLEAR ls_doc_properties-status.
          CLEAR ls_doc_properties-stat_hist_table.
        ENDIF.
        IF p_texts IS INITIAL.
          CLEAR ls_doc_properties-text_all.
          CLEAR ls_doc_properties-text_gen.
        ENDIF.
        IF p_attach IS INITIAL.
          CLEAR ls_doc_properties-attach_list.
          CLEAR ls_doc_properties-url_list.
        ENDIF.
        IF p_soldoc IS INITIAL.
          CLEAR ls_doc_properties-occ_ids.
        ENDIF.
        IF p_log IS INITIAL.
          CLEAR ls_doc_properties-cdhdr.
          CLEAR ls_doc_properties-cdpos.
        ENDIF.
        IF p_tr IS NOT INITIAL.
          ls_doc_properties-tr_move = 'X'.
        ENDIF.
        IF p_test IS INITIAL.
          CLEAR lt_messages.
          TRY.
              "call RFC to create documnet in target system
              CALL FUNCTION 'Z_CREATE_DOC'
                DESTINATION p_rfc
                EXPORTING
                  is_documentprops = ls_doc_properties
                IMPORTING
                  et_messages      = lt_messages.

              LOOP AT lt_messages INTO ls_message.
                "processing results:
                ls_output-message = ls_message.
                APPEND ls_output TO lt_output.
              ENDLOOP.

            CATCH cx_root INTO oref.
              ls_output-message = 'Unhandled Error while creating document'.
              APPEND ls_output TO lt_output.
          ENDTRY.

        ELSE.
          ls_output-message = 'Test read OK! '.
          APPEND ls_output TO lt_output.
        ENDIF.
      ENDIF.

      "indicate process status
      cl_progress_indicator=>progress_indicate(
          i_text               = 'Processed &1 % (&2 of &3 records)'
          i_processed          = sy-tabix
          i_total              = lv_total_lines
          i_output_immediately = abap_false ).

    ENDLOOP.

    CLEAR ls_output.
    ls_output-object_id = lv_total_lines.
    ls_output-message = 'Documents processed'.
    APPEND ls_output TO lt_output.

    cl_salv_table=>factory(
      IMPORTING
        r_salv_table = DATA(lo_alv)
      CHANGING
        t_table      = lt_output
      ).


    DATA(lo_functions) = lo_alv->get_functions( ).
    lo_functions->set_all( ).

    lo_alv->get_layout( )->set_save_restriction(
        value = if_salv_c_layout=>restrict_none
    ).

    lo_alv->display( ).


  ENDIF.

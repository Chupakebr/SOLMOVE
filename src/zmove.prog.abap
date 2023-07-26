*&---------------------------------------------------------------------*
*& Report  ZMOVE
*&
*&---------------------------------------------------------------------*
*& Main report for moving document data from one solman to another
*&
*&---------------------------------------------------------------------*
REPORT zmove.

TYPES:
  BEGIN OF ts_obj_id_struct,
    obj_id TYPE crmt_object_id_db,
  END OF ts_obj_id_struct.

TYPES:
  BEGIN OF ts_order_data,
    object_id	TYPE crmt_object_id_db,
    guid      TYPE crmt_object_guid,
  END OF ts_order_data.

DATA:
  lt_obj_id         TYPE TABLE OF ts_obj_id_struct WITH HEADER LINE,
  lr_obj_id         TYPE RANGE OF crmt_object_id_db,
  lt_orders_data    TYPE TABLE OF ts_order_data,
  ls_order_data     TYPE ts_order_data,
  lv_total_lines    TYPE i,
  ls_doc_properties TYPE zdoc_props_struct,
  lt_messages       TYPE zprocess_log_tt,
  ls_message        TYPE tdline,
  oref              TYPE REF TO cx_root.

SELECT-OPTIONS p_obj_id FOR lt_obj_id-obj_id NO INTERVALS DEFAULT 8000000060.
PARAMETERS p_rfc    TYPE rfcdwf DEFAULT 'NONE'.
PARAMETERS p_ttype  TYPE crmt_process_type_db DEFAULT 'S1MJ'.
PARAMETERS p_update AS CHECKBOX DEFAULT 'X'.
PARAMETERS p_status AS CHECKBOX DEFAULT ''. "! if document in closed status no updates are posible.
PARAMETERS p_test   AS CHECKBOX DEFAULT 'X'.

START-OF-SELECTION.

  "Select documents to be transfered
  SELECT business_transaction~object_id,
    business_transaction~guid
    FROM crmd_orderadm_h AS business_transaction
    WHERE business_transaction~object_id IN @p_obj_id
    AND  business_transaction~process_type = @p_ttype
    INTO TABLE @lt_orders_data.

  lv_total_lines = lines( lt_orders_data ).

  IF sy-subrc EQ 0.

    LOOP AT lt_orders_data INTO ls_order_data.
      CLEAR: lt_messages.
      CLEAR: ls_doc_properties.

      "get data to transfer

      CALL METHOD zcl_solmove_helper=>get_doc_data
        EXPORTING
          iv_guid               = ls_order_data-guid
        IMPORTING
          lt_doc_properties     = ls_doc_properties
        EXCEPTIONS
          error_read_doc        = 1
          error_get_attachments = 2
          error_no_target_ttype = 3
          OTHERS                = 4.
      IF sy-subrc <> 0.
        WRITE: / 'Error reading document: '.
        WRITE: ls_order_data-object_id.
        WRITE: / 'Error id:'.
        WRITE: sy-subrc.
      ELSE.

        IF p_update IS NOT INITIAL.
          ls_doc_properties-update = 'X'.
        ENDIF.

        IF p_status IS INITIAL.
          CLEAR ls_doc_properties-status.
          CLEAR ls_doc_properties-stat_hist.
        ENDIF.

        IF p_test IS INITIAL.

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
                WRITE: / ls_message. "Processed Message
              ENDLOOP.

            CATCH cx_root INTO oref.
              WRITE: 'Unhandled Error while creating document'.
          ENDTRY.

        ELSE.
          WRITE: / 'Test read for document: '.
          WRITE: ls_order_data-object_id.
          WRITE: 'successful'.
        ENDIF.
      ENDIF.

      "indicate process status
      cl_progress_indicator=>progress_indicate(
          i_text               = 'Processed &1 % (&2 of &3 records)'
          i_processed          = sy-tabix
          i_total              = lv_total_lines
          i_output_immediately = abap_false ).

    ENDLOOP.

    WRITE: / 'Total: '.
    WRITE: lv_total_lines.
    WRITE: ' documents was processed'.

  ENDIF.

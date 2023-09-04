*&---------------------------------------------------------------------*
*& Report  ZMOVE_BP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zmove_bp LINE-SIZE 500.

TYPES:
  BEGIN OF ts_output,
    object_id	TYPE bu_partner,
    message   TYPE char100,
  END OF ts_output.

TABLES: but000, zsolmove_mapping.

DATA:
  lv_part_c      TYPE bu_partner,
  lv_part_t      TYPE bu_partner,
  lt_messages    TYPE zprocess_log_tt,
  ls_message     TYPE tdline,
  lt_output      TYPE TABLE OF ts_output,
  ls_output      TYPE ts_output,
  ls_bpdata      TYPE zbp_data,
  lv_oref        TYPE REF TO cx_root,
  lv_mapp        TYPE zsolmove_mapping,
  lv_person_id   TYPE personid,
  lv_total_lines TYPE i.


SELECT-OPTIONS p_obj_id FOR but000-partner NO INTERVALS DEFAULT 1.
PARAMETERS p_rfc    TYPE rfcdwf DEFAULT 'NONE'.
PARAMETERS p_test   AS CHECKBOX DEFAULT 'X'.

START-OF-SELECTION.

  SELECT partner, partner_guid, mapp~source FROM but000
    LEFT JOIN zsolmove_mapping AS mapp ON but000~partner = mapp~source AND mapp~type = 'BP'
    WHERE partner IN @p_obj_id AND
    mapp~source IS NULL
    INTO TABLE @DATA(lt_partners)
        UP TO 1 ROWS.

  lv_total_lines = lines( lt_partners ).

  LOOP AT lt_partners INTO DATA(lv_partner).
    lv_part_c = lv_partner.
    CLEAR ls_bpdata.
    CLEAR lv_mapp.

    ls_output-object_id = lv_partner.

    CALL FUNCTION 'BUPA_CENTRAL_GET_DETAIL'
      EXPORTING
        iv_partner            = lv_part_c
      IMPORTING
        es_data               = ls_bpdata-data
        es_data_person        = ls_bpdata-data_person
        es_data_organ         = ls_bpdata-data_organ
        es_data_group         = ls_bpdata-data_group
        es_data_info          = ls_bpdata-data_info
        ev_category           = ls_bpdata-category
        ev_group              = ls_bpdata-group
        ev_fullname_converted = ls_bpdata-fullname_converted
      TABLES
        et_adtel_addr_ind     = ls_bpdata-adtel_addr_ind
        et_adsmtp_addr_ind    = ls_bpdata-adsmtp_addr_ind.

    CALL FUNCTION 'BAPI_BUPA_ADDRESS_GETDETAIL'
      EXPORTING
        businesspartner = lv_part_c
      IMPORTING
        addressdata     = ls_bpdata-address.

    CALL FUNCTION 'BAPI_BUPA_ROLES_GET_2'
      EXPORTING
        businesspartner      = lv_part_c
*       VALIDDATE            = SY-DATLO
      TABLES
        businesspartnerroles = ls_bpdata-bproles
*       RETURN               =
      .

    "Step-3a: get central person

    CALL FUNCTION 'BP_CENTRALPERSON_GET'
      EXPORTING
*       IV_PERSON_ID        =
        iv_bu_partner_guid  = lv_partner-partner_guid
*       IV_EMPLOYEE_ID      =
*       IV_USERNAME         =
      IMPORTING
        ev_person_id        = lv_person_id
*       ev_bu_partner_guid  =
        ev_username         = ls_bpdata-user
*       ET_EMPLOYEE_ID      =
*       EV_NAME             =
*       ET_USERS            =
      EXCEPTIONS
        no_central_person   = 1
        no_business_partner = 2
        no_id               = 3
        OTHERS              = 4.

    IF p_test IS INITIAL.

      TRY.
          CALL FUNCTION 'Z_CREATE_BP'
            DESTINATION p_rfc
            EXPORTING
              iv_bp_data  = ls_bpdata
            IMPORTING
              ev_partner  = lv_part_t
              et_messages = lt_messages.

          LOOP AT lt_messages INTO ls_message.
            "processing results:
            ls_output-message = ls_message.
            APPEND ls_output TO lt_output.
          ENDLOOP.

          cl_progress_indicator=>progress_indicate(
          i_text               = 'Processed &1 % (&2 of &3 records)'
          i_processed          = sy-tabix
          i_total              = lv_total_lines
          i_output_immediately = abap_false ).



        CATCH cx_root INTO lv_oref.
          ls_output-message = 'Unhandled Error while creating document'.
          APPEND ls_output TO lt_output.
      ENDTRY.
      IF lv_part_t IS NOT INITIAL.
        lv_mapp-type = 'BP'.
        lv_mapp-source = lv_part_c.
        lv_mapp-target = lv_part_t.
        MODIFY zsolmove_mapping FROM lv_mapp.
        CONCATENATE lv_part_t 'mapping added' INTO ls_output-message SEPARATED BY space.
        APPEND ls_output TO lt_output.
      ENDIF.

    ELSE.
      ls_output-message = 'Test read OK! '.
      APPEND ls_output TO lt_output.
    ENDIF.

  ENDLOOP.

  CLEAR ls_output.
  ls_output-object_id = lv_total_lines.
  ls_output-message = 'BP processed'.
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

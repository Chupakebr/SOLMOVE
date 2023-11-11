class ZCL_SOLMOVE_HELPER definition
  public
  final
  create public .

public section.

  class-methods ASSIGN_TR
    importing
      !IT_TRORDERS type /TMWFLOW/TRORDHC_T
    exporting
      !EV_MESSAGE type TDLINE .
  class-methods GET_BP_MAPPING
    importing
      !IV_PARTNER type CRMT_PARTNER_NUMBER
    exporting
      !EV_PARTNER type CRMT_PARTNER_NUMBER .
  class-methods SET_CATEGORIES
    importing
      !IT_CATEGORIES type CRMT_SUBJECT_WRK
    changing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API .
  class-methods GET_APPROVAL
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !ET_APPROVAL type CRMT_APPROVAL_WRK
      !ET_APPROVAL_DB type ZAPPROVAL_DB .
  class-methods GET_SLA
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_APPOINTMENT type CRMT_APPOINTMENT_WRKT
      !ET_SLA_DB type ZSLA_SRCL_TT
      !ET_SLA_DB_2 type ZSLA_SCAPPTSEG_TT .
  class-methods GET_TEST_DATA
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !ET_APPROVAL type CRMT_APPROVAL_WRK
      !ET_APPROVAL_DB type ZAPPROVAL_DB .
  class-methods SET_SLA
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !ET_APPOINTMENT type CRMT_APPOINTMENT_WRKT .
  class-methods SET_SLA_DB
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !ET_SLA_DB type ZSLA_SRCL_TT
      !ET_SLA_DB_2 type ZSLA_SCAPPTSEG_TT .
  class-methods SET_APPROVAL
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !ET_APPROVAL type CRMT_APPROVAL_WRK .
  class-methods SET_APPROVAL_DB
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !ET_APPROVAL_DB type ZAPPROVAL_DB .
  class-methods GET_SOLDOC
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_SMUDS type ZSMUD_TT .
  class-methods GET_CONTEXT
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !ET_CONTEXT type ZCONTEXT .
  class-methods GET_DOCFLOW
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_DOCS type CRMT_DOC_FLOW_WRKT .
  class-methods GET_TEXTS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_TEXT_ALL type COMT_TEXT_TEXTDATA_T
      !ET_TEXTDATA_GEN type CRMT_TEXT_GEN_EXT_TAB .
  class-methods SET_CONTEXT
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !ET_CONTEXT type ZCONTEXT
      !IV_DOC_GUID type ZCUSTOM_FIELDS
      !IV_CYCLE type CRMT_OBJECT_ID_DB .
  class-methods SET_DOCFLOW
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !IV_DOC_GUID type ZCUSTOM_FIELDS
      !LT_DOCS type CRMT_DOC_FLOW_WRKT
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_MESSAGE type TDLINE .
  class-methods SET_TEXTS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_TEXT_PROC type COMT_TEXT_DET_PROCEDURE
      !IT_TEXTDATA type COMT_TEXT_TEXTDATA_T
      !IT_TEXTDATA_GEN type CRMT_TEXT_GEN_EXT_TAB
    exporting
      !EV_MESSAGE type TDLINE .
  class-methods CREATE_BP
    importing
      !IV_BP_DATA type ZBP_DATA
    exporting
      !EV_MESSAGE type ZPROCESS_LOG_TT
      !EV_PARTNER type BU_PARTNER .
  class-methods FIND_DOC
    importing
      !IV_DOC_ID type ZCUSTOM_FIELDS optional
      !IV_DOC_GUID type ZCUSTOM_FIELDS optional
      !IV_TYPE type CRMT_PROCESS_TYPE optional
    exporting
      !EV_GUID type CRMT_OBJECT_GUID
    exceptions
      ERROR_MAPPING .
  class-methods GET_DOC_DATA
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !LT_DOC_PROPERTIES type ZDOC_PROPS_STRUCT
      !EV_MESSAGE type ZPROCESS_LOG_TT
    exceptions
      ERROR_READ_DOC
      ERROR_GET_ATTACHMENTS
      ERROR_NO_TARGET_TTYPE
      ERROR_CYCLE_NOT_MAPPED
      ERROR_IBASE_NOT_MAPPED
      ERROR_NO_ID
      ERROR_NO_GUID .
  class-methods CREATE_DOC
    importing
      !IV_DOCUMENTPROPS type ZDOC_PROPS_STRUCT
    exporting
      !EV_MESSAGE type ZPROCESS_LOG_TT .
  class-methods GET_STATUS
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_STATUS type ZSTATUS_TT
      !EV_STATUS_H type ZSTATUS_TT_HISTORY
      !EV_STATUS_DB type ZSTATUS_DB_TT .
  class-methods GET_TR
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_TRANSPORTS type ZTRANSPORTS_TT .
  class-methods SET_TR_DB
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_TRANSPORTS type ZTRANSPORTS_TT
      !IV_CHANGE_ID type CRMT_OBJECT_ID
      !IV_TR_MOVE type BOOLEAN default ''
    exceptions
      ERROR_TR_ALREADY_REGISTERED
      ERROR_TR_NOT_ADDED
      ERROR_TR_NOT_CHANGED_IN_MNGED .
  class-methods GET_LOG
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_CDPOS type ZCDPOS_TT
      !EV_MESSAGE type ZPROCESS_LOG_TT
      !ET_CDHDR type ZCDHDR_TT .
  class-methods SET_LOG_DB
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !IT_CDPOS type ZCDPOS_TT
      !IT_CDHDR type ZCDHDR_TT
    exporting
      !EV_MESSAGE type ZPROCESS_LOG_TT .
  class-methods GET_PARTNERS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !LT_PARTNER type COMT_PARTNER_COMT
      !EV_MESSAGE type ZPROCESS_LOG_TT
    exceptions
      ERROR_NOT_MAPPED .
  class-methods SET_PARTNERS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !LT_PARTNER type COMT_PARTNER_COMT
    exporting
      !EV_MESSAGE type TDLINE
    exceptions
      ERROR_NOT_MAPPED .
  class-methods GET_WEBUI_FIELDS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !EV_CUSTOM_FIELDS type ZCUSTOM_FIELDS_TT .
  class-methods SET_WEBUI_FIELDS
    importing
      !EV_CUSTOM_FIELDS type ZCUSTOM_FIELDS_TT
    changing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exceptions
      ERROR_CUSTOMER_HEADER .
  class-methods SET_IBASE
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_IBASE type COMT_PRODUCT_ID
    changing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API .
  class-methods GET_IBASE
    importing
      !IV_IBASE type COMT_PRODUCT_ID
    exporting
      !EV_IBASE type COMT_PRODUCT_ID
    exceptions
      ERROR_NOT_MAPPED .
  class-methods GET_CYCLE
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_CYCLE type CRMT_OBJECT_ID_DB
    exceptions
      ERROR_NOT_MAPPED .
  class-methods SET_CYCLE
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_TYPE type CRMT_PROCESS_TYPE
      !IV_CYCLE type CRMT_OBJECT_ID_DB
      !IV_IBASE type COMT_PRODUCT_ID .
  class-methods SET_ATTACHMENTS
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_OBJECT_TYPE type SIBFTYPEID
      !IV_ATTACH_LIST type ZATTACHMENT_TT
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !IT_URL_LIST type ZATTACHMENT_TT
    exporting
      !EV_MESSAGE type TDLINE .
  class-methods SET_SOLDOC
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IT_OCC_IDS type ZSMUD_TT
    changing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API .
  class-methods SET_STATUS_DB
    importing
      !IV_STATUS_HIST type ZSTATUS_TT_HISTORY
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_STATUS_DB type ZSTATUS_DB_TT .
  class-methods SET_STATUS
    importing
      !IV_STATUS type ZSTATUS_TT
    changing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API .
  class-methods GET_TYPE
    importing
      !IV_TYPE type CRMT_PROCESS_TYPE
    exporting
      !EV_TYPE type CRMT_PROCESS_TYPE
    exceptions
      ERROR_NOT_MAPPED .
  class-methods GET_ATTACHMENTS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_URL_LIST type ZATTACHMENT_TT
      !ET_ATTACHMENTS type ZATTACHMENT_TT .
  class-methods SET_CREATION_INFO_DB
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_DOC_PROPERTIES type ZDOC_PROPS_STRUCT .
  class-methods GET_CATEGORIES
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !RT_RESULT type CRMT_SUBJECT_WRK .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SOLMOVE_HELPER IMPLEMENTATION.


  METHOD assign_tr.

    DATA: lv_message      TYPE string,
          lv_action_id    TYPE /tmwflow/action_id,
          lv_rfc_dest     TYPE rfcdest,
          lv_trkorr       TYPE trkorr,
          lv_error        TYPE flag,
          ls_old_switches TYPE /tmwflow/trorder_proj_switches,
          ls_trorder      TYPE /tmwflow/trordhc_s,
          ls_logic_system TYPE  /tmwflow/logical_system,
          lt_trordhc      TYPE  /tmwflow/trordhc_t.

* Get RFC destination

    LOOP AT it_trorders INTO ls_trorder.
      IF ls_trorder-status = /tmwflow/cl_constants=>con_exp_stat_modifiable.

        /tmwflow/cl_system=>create_instance(
          EXPORTING
            iv_tech_sys_name = ls_trorder-sys_name
            iv_tech_sys_type = ls_trorder-sys_type
            iv_client        = ls_trorder-sys_client
          RECEIVING
            ro_system        = DATA(lo_system)
          EXCEPTIONS
            system_not_found = 1
            OTHERS           = 2 ).

        IF sy-subrc = 0.
          lv_rfc_dest = lo_system->get_rfc_dest_tmw( ).
        ENDIF.


*--------------------------------------------------------------------*
* Open CTS status switch
        IF ls_trorder-sys_type = 'ABAP'  AND ls_trorder-cts_id IS NOT INITIAL.
          CLEAR ls_logic_system.
          MOVE-CORRESPONDING ls_trorder TO ls_logic_system.

          CALL FUNCTION '/TMWFLOW/TU_OPEN_PROJ_SWITCHES'
            EXPORTING
              is_logic_system = ls_logic_system
              iv_cts_id       = ls_trorder-cts_id
              iv_create_req   = abap_true
            IMPORTING
              es_old_switches = ls_old_switches
            EXCEPTIONS
              internal_error  = 1
              OTHERS          = 2.
          IF sy-subrc <> 0.
            "Set status and message
            ev_message = 'Error open CTS switches in managed system'.
          ENDIF.
        ENDIF.


**--------------------------------------------------------------------------
* Assign requests
        CLEAR lt_trordhc.
        APPEND ls_trorder TO lt_trordhc.
        CALL FUNCTION '/TMWFLOW/REGISTER_TR_TO_TL'
          EXPORTING
            id_tasklist            = ls_trorder-tasklist
            id_originator          = ls_trorder-originator
            id_originator_id       = ls_trorder-originator_id
            id_originator_key      = ls_trorder-originator_key
            id_smi_project         = ls_trorder-smi_project
            is_logic_system        = ls_logic_system
            it_trordhc             = lt_trordhc
          EXCEPTIONS
            all_tr_assigned        = 1
            no_tr_assigned         = 2
            tasklist_not_specified = 3
            update_failed          = 4
            rfc_error              = 5
            OTHERS                 = 6.
        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              MESSAGE i326(/tmwflow/tasklist) WITH ls_trorder-tasklist
                 INTO ev_message.
            WHEN 2.
              MESSAGE e327(/tmwflow/tasklist) WITH ls_trorder-tasklist
                 INTO ev_message.
            WHEN OTHERS.
              ev_message = 'Error changing cts_id'.
          ENDCASE.
        ENDIF.

        IF ls_trorder-cts_id IS NOT INITIAL.
          lo_system->set_cts_status_switches(
            EXPORTING
              iv_cts_id         = ls_trorder-cts_id
              iv_create_req_ok  = ls_old_switches-create_req_ok
              iv_release_req_ok = ls_old_switches-release_req_ok
              iv_import_req_ok  = ls_old_switches-import_req_ok
            EXCEPTIONS
              status_not_set    = 1
              OTHERS            = 2 ).
          IF sy-subrc <> 0.
            ev_message = 'Error close CTS switches in managed system'.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD create_bp.
    DATA: lt_messages       TYPE bapiret2_t,
          ls_return_bp      TYPE bapiret2,
          lv_message        TYPE tdline,
          lv_partner_guid   TYPE bu_partner_guid,
          ls_bpdata         TYPE zbp_data,
          lv_bp_role_bup001 TYPE bapibus1006_bproles,
          lv_partner_guid_t TYPE bu_partner_guid,
          ls_bp3            TYPE bapibus1006_bp_addr,
          lt_bp3            TYPE TABLE OF bapibus1006_bp_addr,
          lv_user           TYPE bapibname,
          ls_return         TYPE bapiret2,
          rv_user_exists    TYPE boolean.
    DATA ls_bus000 TYPE  bus000.
    DATA lv_person_id TYPE personid.

    rv_user_exists = abap_false.

    IF iv_bp_data-user IS NOT INITIAL.

      CALL FUNCTION 'BAPI_USER_EXISTENCE_CHECK'
        EXPORTING
          username = iv_bp_data-user
        IMPORTING
          return   = ls_return.
      IF ls_return-number EQ 124.
        rv_user_exists = abap_false.
      ELSEIF ls_return-number EQ 088.
        rv_user_exists = abap_true.
      ENDIF.

      "check if bp exists by user
      IF rv_user_exists = 'X'.
        lv_user = iv_bp_data-user.
        CALL FUNCTION 'COM_BPUS_BUPA_FOR_USER_GET'
          EXPORTING
*           IS_ALIAS              =
            is_username           = lv_user
          IMPORTING
            ev_businesspartner    = ev_partner
          EXCEPTIONS
            no_central_person     = 1
            no_business_partner   = 2
            no_id                 = 3
            no_user               = 4
            no_alias              = 5
            alias_and_user_differ = 6
            internal_error        = 7
            OTHERS                = 8.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

        IF ev_partner IS NOT INITIAL.
          CONCATENATE  'BP:' ev_partner 'found for user' iv_bp_data-user INTO lv_message SEPARATED BY space.
          APPEND lv_message TO ev_message.
        ENDIF.
      ENDIF.
    ENDIF.

    IF ev_partner IS INITIAL.
      "check if bp exists by mail.
      LOOP AT iv_bp_data-adsmtp_addr_ind INTO DATA(ls_mails).

        CALL FUNCTION 'BAPI_BUPA_SEARCH'
          EXPORTING
            email        = ls_mails-e_mail
          TABLES
            searchresult = lt_bp3
            return       = lt_messages.


        READ TABLE lt_bp3 INTO ls_bp3 INDEX 1.
        ev_partner = ls_bp3-partner.
        EXIT.
      ENDLOOP.

      IF ev_partner IS NOT INITIAL.
        CONCATENATE  'BP:' ev_partner 'found for mail' ls_mails-e_mail INTO lv_message SEPARATED BY space.
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.


    IF rv_user_exists = '' AND iv_bp_data-user IS NOT INITIAL.
      CONCATENATE  'User:' iv_bp_data-user 'does not exist. BP can not be created.' INTO lv_message SEPARATED BY space.
      APPEND lv_message TO ev_message.
    ELSE.
      IF ev_partner IS INITIAL AND iv_bp_data-create = 'X'.
        "if bp is not found create new one
        CLEAR ls_return_bp.
        CALL FUNCTION 'BUPA_CREATE_FROM_DATA'
          EXPORTING
            iv_category     = iv_bp_data-category
            iv_group        = iv_bp_data-group
            is_data         = iv_bp_data-data
            is_data_person  = iv_bp_data-data_person
            is_data_organ   = iv_bp_data-data_organ
            is_data_group   = iv_bp_data-data_group
            is_address      = iv_bp_data-address
            iv_accept_error = 'X'
          IMPORTING
            ev_partner      = ev_partner
            ev_partner_guid = lv_partner_guid
          TABLES
            it_adtel        = iv_bp_data-adtel_addr_ind
            it_adsmtp       = iv_bp_data-adsmtp_addr_ind
            et_return       = lt_messages.

        READ TABLE lt_messages INDEX 1 INTO ls_return_bp.
        IF sy-subrc = 0.
          lv_message = ls_return_bp.
          APPEND lv_message TO ev_message.
          CONCATENATE  'Creation of bp:' ev_partner 'failed' INTO lv_message SEPARATED BY space.
          APPEND lv_message TO ev_message.
          CLEAR ev_partner.
          RETURN.
        ENDIF.

        IF ev_partner IS NOT INITIAL AND rv_user_exists = abap_true.
          LOOP AT ls_bpdata-bproles INTO lv_bp_role_bup001.
            "add roles to BP (we need Emploee role to add user)
            CALL FUNCTION 'BAPI_BUPA_ROLE_ADD_2'
              EXPORTING
                businesspartner             = ev_partner
                differentiationtypevalue    = lv_bp_role_bup001-difftypevalue
                businesspartnerrolecategory = lv_bp_role_bup001-partnerrolecategory
                businesspartnerrole         = lv_bp_role_bup001-partnerrole
                validfromdate               = lv_bp_role_bup001-valid_from
                validuntildate              = lv_bp_role_bup001-valid_to
              TABLES
                return                      = lt_messages.

            READ TABLE lt_messages INDEX 1 INTO ls_return_bp.
            IF sy-subrc = 0.
              lv_message = ls_return_bp.
              APPEND lv_message TO ev_message.
              lv_message =  'Creation of role failed'.
              APPEND lv_message TO ev_message.
            ENDIF.
          ENDLOOP.

          "create central person (need this to add user)
          ls_bus000-partner = ev_partner.

          CALL FUNCTION 'BP_BUPA_CREATECENTRALPERSON'
            EXPORTING
              iv_bu_partner_guid      = lv_partner_guid
              iv_no_commit            = 'X'
              is_bus000               = ls_bus000
            IMPORTING
              ev_person_id            = lv_person_id
            EXCEPTIONS
              buffer_mode_not_allowed = 1
              OTHERS                  = 2.

          IF sy-subrc <> 0.
*
          ENDIF.

          "Step-4: finally set central persons name - user
          CALL FUNCTION 'BP_CENTRALPERSON_ASSIGN_USER'
            EXPORTING
              iv_person_id     = lv_person_id
              iv_user_id       = iv_bp_data-user
              iv_no_commit     = 'X' "done in next step
            EXCEPTIONS
              no_authorization = 1
              invalid_data     = 2
              no_application   = 3
              OTHERS           = 4.

          IF sy-subrc <> 0.
            lv_message =  'Asingment of user failed'.
            APPEND lv_message TO ev_message.
          ENDIF.
        ENDIF.
        CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
          EXPORTING
            wait = abap_true.
      ELSE.
        lv_message =  'Bp will be createdd during creation run'.
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD create_doc.

    INCLUDE: crm_mode_con. "Include with standard CRM constants

    DATA: lo_cd         TYPE REF TO cl_ags_crm_1o_api, "CRM Document object instance to create and maintain CRM Document through standard API
          lv_log_handle TYPE balloghndl,
          ls_orderadm_h TYPE crmt_orderadm_h_wrk,
          lt_orderadm_h TYPE crmt_orderadm_h_wrkt,
          ls_customer_h TYPE crmt_customer_h_com,
          lt_status_com TYPE crmt_status_comt,
          lv_message    TYPE tdline,
          lv_error      TYPE char2,
          lv_id         TYPE crmt_object_id_db, "new document id.
          lv_guid_c     TYPE char30,
          lv_skip       TYPE boolean.

    lv_skip = ''.

    "check if document already created?
    CALL METHOD zcl_solmove_helper=>find_doc
      EXPORTING
        iv_doc_id     = iv_documentprops-object_id
        iv_type       = iv_documentprops-type
      IMPORTING
        ev_guid       = DATA(lv_guig)
      EXCEPTIONS
        error_mapping = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      lv_message = 'Error: Could not find created doc (check mapping).'.
      APPEND lv_message TO ev_message.
    ELSEIF lv_guig IS NOT INITIAL.
      lv_guid_c = lv_guig.
      SELECT SINGLE object_id FROM crmd_orderadm_h WHERE guid = @lv_guig INTO @lv_id.
      CONCATENATE 'OK Document found, updating:' lv_id lv_guid_c INTO lv_message SEPARATED BY space.
      APPEND lv_message TO ev_message.
    ENDIF.


    IF lv_guig IS NOT INITIAL.
      "document found, update it.
      cl_ags_crm_1o_api=>get_instance(
        EXPORTING
        iv_header_guid                = lv_guig
        iv_process_mode               = cl_ags_crm_1o_api=>ac_mode-change  " Processing Mode of Transaction
      IMPORTING
        eo_instance                   = lo_cd
      EXCEPTIONS
        invalid_parameter_combination = 1
        error_occurred                = 2
        OTHERS                        = 3 ).
      IF sy-subrc <> 0.
        lv_message = 'Error: Could not initialise cl_ags_crm_1o_api.'.
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.

    "Create document
    IF lo_cd IS NOT BOUND AND iv_documentprops-update IS INITIAL.
      cl_ags_crm_1o_api=>get_instance(
      EXPORTING
        iv_process_mode = gc_mode-create " Processing Mode of Transaction
        iv_process_type = iv_documentprops-type
      IMPORTING
        eo_instance = lo_cd
        ).
      IF sy-subrc <> 0.
        lv_message = 'Error: Could not ceate new doc.'.
      ELSE.
        lv_guid_c = lo_cd->get_guid( ).
        CONCATENATE 'OK: New document created:' lv_guid_c INTO lv_message SEPARATED BY space.
      ENDIF.
      APPEND lv_message TO ev_message.
    ENDIF.

    IF lo_cd IS NOT BOUND.
      lv_message = 'Error: Could not initialize document. Process stoped.'.
      APPEND lv_message TO ev_message.
      EXIT.
    ENDIF.
    "get guid of the created document
    lo_cd->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h
       EXCEPTIONS
                document_not_found   = 1
                error_occurred       = 2
                document_locked      = 3
                no_change_authority  = 4
                no_display_authority = 5
                no_change_allowed    = 6
                OTHERS               = 7 ).
    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 3.
          lv_message = 'Error: updating doc: document locked.'.
        WHEN 6.
          CONCATENATE 'OK: Document:' lv_id 'closed, could not be updated. Going to DB update.' INTO lv_message SEPARATED BY space.
        WHEN OTHERS.
          lv_error = sy-subrc.
          CONCATENATE 'Error: updating doc:' lv_id ':' lv_error INTO lv_message SEPARATED BY space.
      ENDCASE.
      APPEND lv_message TO ev_message.
      lv_skip = 'X'.
    ENDIF.
    IF lv_skip = ''.
      "set description
      lo_cd->set_short_text( EXPORTING iv_short_text = iv_documentprops-description ).
      IF sy-subrc <> 0.
        lv_message = 'Error: setting description.'.
        APPEND lv_message TO ev_message.
      ENDIF.

      "set priority
      IF iv_documentprops-priority IS NOT INITIAL.
        lo_cd->set_priority( EXPORTING iv_priority = iv_documentprops-priority ).
      ENDIF.
      IF sy-subrc <> 0.
        lv_message = 'Error: setting priority.'.
        APPEND lv_message TO ev_message.
      ENDIF.

      "set category
      IF iv_documentprops-category IS NOT INITIAL.
        lo_cd->set_category( EXPORTING iv_category = iv_documentprops-category ).
        IF sy-subrc <> 0.
          lv_message = 'Error: setting category.'.
          APPEND lv_message TO ev_message.
        ENDIF.
      ENDIF.

      IF iv_documentprops-categories IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_categories
          EXPORTING
            it_categories = iv_documentprops-categories
          CHANGING
            iv_1o_api     = lo_cd.
      ENDIF.

      "set soldoc data
      IF iv_documentprops-occ_ids IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_soldoc
          EXPORTING
            iv_guid    = ls_orderadm_h-guid
            it_occ_ids = iv_documentprops-occ_ids
          CHANGING
            iv_1o_api  = lo_cd.
      ENDIF.

      " add attachments
      IF iv_documentprops-attach_list IS NOT INITIAL OR iv_documentprops-url_list IS NOT INITIAL.
        CLEAR lv_message.
        "convert t-type
        DATA: lv_t_type TYPE sibftypeid.
        lv_t_type = ls_orderadm_h-object_type.

        CALL METHOD zcl_solmove_helper=>set_attachments
          EXPORTING
            iv_1o_api      = lo_cd
            iv_guid        = ls_orderadm_h-guid
            iv_object_type = lv_t_type
            iv_attach_list = iv_documentprops-attach_list
            it_url_list    = iv_documentprops-url_list
          IMPORTING
            ev_message     = lv_message.
        IF lv_message IS NOT INITIAL.
          APPEND lv_message TO ev_message.
        ENDIF.
      ENDIF.

      "add ibase
      IF iv_documentprops-ibase IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_ibase
          EXPORTING
            iv_guid   = ls_orderadm_h-guid
            iv_ibase  = iv_documentprops-ibase
          CHANGING
            iv_1o_api = lo_cd.
      ENDIF.

      "add cycle
      IF iv_documentprops-cycle IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_cycle
          EXPORTING
            iv_guid  = ls_orderadm_h-guid
            iv_type  = ls_orderadm_h-process_type
            iv_ibase = iv_documentprops-ibase
            iv_cycle = iv_documentprops-cycle.

        "add doc context
        CALL METHOD zcl_solmove_helper=>set_context
          EXPORTING
            iv_guid     = ls_orderadm_h-guid
            et_context  = iv_documentprops-context
            iv_doc_guid = iv_documentprops-object_guid
            iv_cycle    = iv_documentprops-cycle.

        "set transports
        IF iv_documentprops-transports IS NOT INITIAL.
          CALL METHOD zcl_solmove_helper=>set_tr_db
            EXPORTING
              iv_guid                       = ls_orderadm_h-guid
              iv_transports                 = iv_documentprops-transports
              iv_change_id                  = ls_orderadm_h-object_id
              iv_tr_move                    = iv_documentprops-tr_move
            EXCEPTIONS
              error_tr_already_registered   = 1
              error_tr_not_added            = 2
              error_tr_not_changed_in_mnged = 3
              OTHERS                        = 4.
          IF sy-subrc <> 0.
            CASE sy-subrc.
              WHEN 1.
                lv_message = 'Error: Transports already mapped in target system'.
                APPEND lv_message TO ev_message.
              WHEN 3.
                lv_message = 'Error: Transports not updated in mnged system'.
                APPEND lv_message TO ev_message.
              WHEN OTHERS.
                lv_message = 'Error: could not add transports to the created doc'.
                APPEND lv_message TO ev_message.
            ENDCASE.
          ENDIF.
        ENDIF.
      ENDIF.

      "add webui fields
      IF iv_documentprops-custom_fields IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_webui_fields
          EXPORTING
            ev_custom_fields      = iv_documentprops-custom_fields
          CHANGING
            iv_1o_api             = lo_cd
          EXCEPTIONS
            error_customer_header = 1
            OTHERS                = 2.
        IF sy-subrc <> 0.
          lv_message = 'Error: Could not set document webui fields.'.
          APPEND lv_message TO ev_message.
        ENDIF.
      ENDIF.

      "set partners. This call is enough. Additional fields will be picked inside method set_partners
      IF iv_documentprops-partners IS NOT INITIAL.

        CALL METHOD zcl_solmove_helper=>set_partners
          EXPORTING
            iv_1o_api  = lo_cd
            lt_partner = iv_documentprops-partners
          IMPORTING
            ev_message = lv_message.
        IF lv_message IS NOT INITIAL.
          APPEND lv_message TO ev_message.
        ENDIF..
      ENDIF.

      "add document links
      IF iv_documentprops-doc_flow IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_docflow
          EXPORTING
            iv_1o_api   = lo_cd
            iv_doc_guid = iv_documentprops-object_guid
            lt_docs     = iv_documentprops-doc_flow
            iv_guid     = ls_orderadm_h-guid
          IMPORTING
            ev_message  = lv_message.
        IF lv_message IS NOT INITIAL.
          APPEND lv_message TO ev_message.
        ENDIF.
      ENDIF.

      "set texts
      IF iv_documentprops-text_all IS NOT INITIAL.
        CLEAR lv_message.
        CALL METHOD zcl_solmove_helper=>set_texts
          EXPORTING
            iv_guid         = ls_orderadm_h-guid
            iv_text_proc    = lo_cd->av_text_proc
            it_textdata     = iv_documentprops-text_all
            it_textdata_gen = iv_documentprops-text_gen
            iv_1o_api       = lo_cd
          IMPORTING
            ev_message      = lv_message.
        IF sy-subrc <> 0.
          lv_message = 'Error: Could not set texts'.
          APPEND lv_message TO ev_message.
        ELSEIF lv_message IS NOT INITIAL.
          APPEND lv_message TO ev_message.
        ENDIF.
      ENDIF.

      "set approval procedure
      IF iv_documentprops-approval IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_approval
          EXPORTING
            iv_guid     = ls_orderadm_h-guid
            et_approval = iv_documentprops-approval.
      ENDIF.

      "set SLA
      IF iv_documentprops-appointment_t IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_sla
          EXPORTING
            iv_1o_api      = lo_cd
            et_appointment = iv_documentprops-appointment_t.
      ENDIF.

      "set status will be done on DB level only
      " !status set should be the last action to allow other changes for closed document!
*      IF iv_documentprops-status IS NOT INITIAL.
*        CALL METHOD zcl_solmove_helper=>set_status
*          EXPORTING
*            iv_status = iv_documentprops-status
*          CHANGING
*            iv_1o_api = lo_cd.
*      ENDIF.
      " !status set should be the last action to allow other changes for closed document!

*    record document and return solution manager id and solution manager guid
      lo_cd->save( CHANGING cv_log_handle = lv_log_handle ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_message.
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.

    "once document created perform update on DB level (methods ending on _DB)
    "update creation information
    CALL METHOD zcl_solmove_helper=>set_creation_info_db
      EXPORTING
        iv_guid           = lo_cd->get_guid( )
        iv_doc_properties = iv_documentprops.
    "update approval history on db level
    IF iv_documentprops-approval_db IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>set_approval_db
        EXPORTING
          iv_guid        = lo_cd->get_guid( )
          et_approval_db = iv_documentprops-approval_db.
    ENDIF.
    "update SLA
    IF iv_documentprops-sla IS NOT INITIAL OR iv_documentprops-sla_db IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>set_sla_db
        EXPORTING
          iv_guid     = lo_cd->get_guid( )
          et_sla_db   = iv_documentprops-sla
          et_sla_db_2 = iv_documentprops-sla_db.
    ENDIF.
    "update logs
    IF iv_documentprops-cdhdr IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>set_log_db
        EXPORTING
          iv_1o_api = lo_cd
          it_cdhdr  = iv_documentprops-cdhdr
          it_cdpos  = iv_documentprops-cdpos
*      IMPORTING
*         ev_message =
        .
    ENDIF.
    "update status and status change history on DB level.
    IF iv_documentprops-stat_hist_table IS NOT INITIAL OR iv_documentprops-status_db IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>set_status_db
        EXPORTING
          iv_status_hist = iv_documentprops-stat_hist_table
          iv_status_db   = iv_documentprops-status_db
          iv_guid        = lo_cd->get_guid( ).
    ENDIF.
    COMMIT WORK.

*    Check if document can be read?
    lo_cd->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h
        EXCEPTIONS
    document_not_found   = 1
    error_occurred       = 2
    document_locked      = 3
    no_change_authority  = 4
    no_display_authority = 5
    no_change_allowed    = 6
    OTHERS               = 7
        ).
    IF sy-subrc <> 0.
      CASE sy-subrc.
        WHEN 6.
          lv_message = 'OK: Document closed. No changes possible any more.' .
        WHEN OTHERS.
          lv_error = sy-subrc.
          CONCATENATE 'Error: Document:' ls_orderadm_h-object_id lv_error 'can`t be opened after update.' INTO lv_message SEPARATED BY space.
      ENDCASE.
      APPEND lv_message TO ev_message.
    ENDIF.

    CONCATENATE 'OK: Document:' ls_orderadm_h-object_id 'processed in target.' INTO lv_message SEPARATED BY space.
    APPEND lv_message TO ev_message.

  ENDMETHOD.


  METHOD find_doc.
    DATA: cond_syntax TYPE string,
          fldname     TYPE fieldname,
          oref        TYPE REF TO cx_root,
          text        TYPE string.

    IF iv_doc_id IS NOT INITIAL.
      fldname = iv_doc_id-target_field.
      CONCATENATE fldname '=' iv_doc_id-value INTO cond_syntax SEPARATED BY space.

      TRY.
          IF iv_doc_id-target_table = 'CUSTOMER_H'.
            SELECT SINGLE o~guid FROM crmd_customer_h AS c
              LEFT JOIN crmd_orderadm_h AS o ON c~guid = o~guid AND o~process_type = @iv_type
              WHERE (cond_syntax) INTO @ev_guid.
          ENDIF.
        CATCH cx_root INTO oref.
          text = oref->get_text( ).
      ENDTRY.
      IF NOT text IS INITIAL.
        MESSAGE text TYPE 'E'
        RAISING error_mapping.
      ENDIF.
    ENDIF.

    IF iv_doc_guid IS NOT INITIAL AND ev_guid IS INITIAL.
      fldname = iv_doc_guid-target_field.
      CONCATENATE fldname ' = ''' iv_doc_guid-value '''' INTO cond_syntax.
      TRY.
          IF iv_doc_guid-target_table = 'CUSTOMER_H'.
            SELECT SINGLE c~guid FROM crmd_customer_h AS c
              WHERE (cond_syntax) INTO @ev_guid.
          ENDIF.
        CATCH cx_root INTO oref.
          text = oref->get_text( ).
      ENDTRY.
      IF NOT text IS INITIAL.
        MESSAGE text TYPE 'E'
        RAISING error_mapping.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_approval.
    DATA: ls_approval_s_wrk TYPE crmt_approval_s_wrk,
          lv_new_bp         TYPE crmt_aprv_partner_number,
          lv_old_bp         TYPE crmt_aprv_partner_number,
          lv_zer            TYPE i.

    "Input check
    IF iv_guid IS INITIAL.
      RETURN.
    ENDIF.

    "Read the approval of the source document
    CALL FUNCTION 'CRM_APPROVAL_READ_OB'
      EXPORTING
        iv_ref_guid          = iv_guid
        iv_ref_kind          = 'A'
      IMPORTING
        es_approval_wrk      = et_approval
      EXCEPTIONS
        entry_does_not_exist = 1
        parameter_error      = 2
        OTHERS               = 3.

    IF sy-subrc <> 0.
      "no approval procedure or error - copy not possible
      RETURN.
    ENDIF.

    IF  et_approval-approval_steps_wrk IS NOT INITIAL.
      LOOP AT et_approval-approval_steps_wrk INTO ls_approval_s_wrk.
        CLEAR lv_new_bp.
        CALL METHOD zcl_solmove_helper=>get_bp_mapping
          EXPORTING
            iv_partner = ls_approval_s_wrk-partner_no
          IMPORTING
            ev_partner = lv_new_bp.

        "add leading zeros
        IF lv_new_bp IS NOT INITIAL.
          lv_zer = strlen( lv_new_bp ).
          DO 10 - lv_zer TIMES.
            CONCATENATE '0' lv_new_bp INTO lv_new_bp.
          ENDDO.
          ls_approval_s_wrk-partner_no = lv_new_bp.
          MODIFY et_approval-approval_steps_wrk FROM ls_approval_s_wrk.
        ENDIF.
      ENDLOOP.
    ENDIF.

    SELECT * FROM crmd_approval_s WHERE parent_guid = @et_approval-guid INTO @DATA(ls_approval_db).
      "change bp mapping
      CLEAR lv_new_bp.
      "parent_no
      IF  ls_approval_db-partner_no IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>get_bp_mapping
          EXPORTING
            iv_partner = ls_approval_db-partner_no
          IMPORTING
            ev_partner = lv_new_bp.
        IF lv_new_bp IS NOT INITIAL.
          "add leading zeros
          IF lv_new_bp IS NOT INITIAL.
            lv_zer = strlen( lv_new_bp ).
            DO 10 - lv_zer TIMES.
              CONCATENATE '0' lv_new_bp INTO lv_new_bp.
            ENDDO.
          ENDIF.
          ls_approval_db-partner_no = lv_new_bp.
        ENDIF.
      ENDIF.

      CLEAR lv_new_bp.
      "processed_by
      IF  ls_approval_db-processed_by IS NOT INITIAL.
        lv_old_bp = ls_approval_db-processed_by.
        CALL METHOD zcl_solmove_helper=>get_bp_mapping
          EXPORTING
            iv_partner = lv_old_bp
          IMPORTING
            ev_partner = lv_new_bp.
        IF lv_new_bp IS NOT INITIAL.
          "add leading zeros
          IF lv_new_bp IS NOT INITIAL.
            lv_zer = strlen( lv_new_bp ).
            DO 10 - lv_zer TIMES.
              CONCATENATE '0' lv_new_bp INTO lv_new_bp.
            ENDDO.
          ENDIF.
          ls_approval_db-processed_by = lv_new_bp.
        ENDIF.
      ENDIF.

      APPEND ls_approval_db TO et_approval_db.
    ENDSELECT.

  ENDMETHOD.


  METHOD get_attachments.

    DATA: ls_phio                TYPE skwf_io,
          lt_file_access_info    TYPE sdokfilacis,
          lt_file_content_ascii  TYPE sdokcntascs,
          lt_file_content_binary TYPE sdokcntbins,
          ls_attachments         TYPE zattachment,
          lt_attachment_list     TYPE ags_t_crm_attachment,
          lt_url_list            TYPE ags_t_crm_attachment.


    iv_1o_api->get_attachment_list( IMPORTING et_attach_list = lt_attachment_list
      et_url_list = lt_url_list ).

*     get attachments
    IF lt_attachment_list IS NOT INITIAL.

      LOOP AT lt_attachment_list INTO DATA(ls_attachment_list).

        CLEAR: ls_phio, lt_file_access_info, lt_file_content_ascii, lt_file_content_binary, ls_attachments.

        ls_phio-objtype = 'P'.
        ls_phio-class = 'CRM_P_ORD'.
        ls_phio-objid = ls_attachment_list-docid.

        CALL METHOD cl_crm_documents=>get_with_table
          EXPORTING
            phio                = ls_phio
            raw_mode            = abap_true
          IMPORTING
            file_access_info    = lt_file_access_info
            file_content_ascii  = lt_file_content_ascii
            file_content_binary = lt_file_content_binary
            error               = DATA(lt_errors)
            bad_ios             = DATA(lt_bad_files).

        ls_attachments-phio = ls_phio.
        ls_attachments-file_access_info = lt_file_access_info.
        ls_attachments-file_content_ascii = lt_file_content_ascii.
        ls_attachments-file_content_binary = lt_file_content_binary.
        ls_attachments-description = ls_attachment_list-description.
        ls_attachments-extension = ls_attachment_list-extension.
        ls_attachments-file_name = ls_attachment_list-file_name.
        APPEND ls_attachments TO et_attachments.
      ENDLOOP.

    ENDIF.
    IF lt_url_list IS NOT INITIAL.
      LOOP AT lt_url_list INTO DATA(ls_url_list).

        CLEAR: ls_phio, lt_file_access_info, lt_file_content_ascii, lt_file_content_binary, ls_attachments.

        ls_phio-objtype = 'P'.
        ls_phio-class = 'CRM_P_URL'.
        ls_phio-objid = ls_url_list-objid.

        CALL METHOD cl_crm_documents=>get_with_url
          EXPORTING
            phio     = ls_phio
            "loio     =
            url_type = crmkw_url-standard
          IMPORTING
            error    = DATA(lv_error)
            url      = ls_attachments-url
          EXCEPTIONS
            no_io    = 1
            OTHERS   = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        ls_attachments-description = ls_url_list-description.
        ls_attachments-extension = ls_url_list-extension.
        ls_attachments-file_name = ls_url_list-file_name.
        APPEND ls_attachments TO et_url_list.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_bp_mapping.
    DATA: lv_target_partner_no TYPE zsolmove_target,
          lv_partner_no_con    TYPE crmt_partner_number,
          lv_zer, lv_part   TYPE i,
          lv_part_conv         TYPE crmt_partner_number.

    IF  iv_partner CO '1234567890 '. " process only numeric partners
      IF iv_partner(1) ='0'. "remove leading zeros
        lv_part = iv_partner.
        lv_partner_no_con = lv_part.
        CONDENSE lv_partner_no_con.
      ELSE.
        lv_partner_no_con = iv_partner.
      ENDIF.

      CHECK lv_partner_no_con IS NOT INITIAL.

      SELECT SINGLE target FROM zsolmove_mapping WHERE source EQ @lv_partner_no_con INTO @lv_target_partner_no.

      IF lv_target_partner_no IS INITIAL.
        "try to convert bp to 10 digets with leading zeros
        lv_part_conv = lv_partner_no_con.
        lv_zer = strlen( lv_part_conv ).
        DO 10 - lv_zer TIMES.
          CONCATENATE '0' lv_part_conv INTO lv_part_conv.
        ENDDO.
        SELECT SINGLE target FROM zsolmove_mapping WHERE source EQ @lv_part_conv INTO @lv_target_partner_no.
        IF lv_target_partner_no IS NOT INITIAL.
          lv_part = lv_target_partner_no. "now remove leading zeros.
          ev_partner = lv_part.
          CONDENSE ev_partner.
        ENDIF.
      ELSE.
        ev_partner = lv_target_partner_no.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_categories.

    DATA: lv_cat    TYPE crmt_subject_wrk.

    CALL METHOD iv_1o_api->get_subject
      IMPORTING
        es_subject = rt_result.
*       et_subject =
*  EXCEPTIONS
*       document_not_found   = 1
*       error_occurred       = 2
*       document_locked      = 3
*       no_change_authority  = 4
*       no_display_authority = 5
*       no_change_allowed    = 6
*       others     = 7
    .
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.


  METHOD get_context.

    SELECT cont~*
    FROM tsocm_cr_context AS cont
    WHERE guid = @iv_guid
      AND created_guid <> @iv_guid "cycles link CR
      AND item_guid <> @iv_guid "cycles link REQ
    INTO @DATA(lt_context).

      "change ibase
      IF lt_context-product_id IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>get_ibase
          EXPORTING
            iv_ibase = lt_context-product_id
          IMPORTING
            ev_ibase = DATA(lv_new_ibase).
        IF lv_new_ibase IS NOT INITIAL.
          lt_context-product_id = lv_new_ibase.
        ENDIF.
      ENDIF.

      "change transaction type
      CALL METHOD zcl_solmove_helper=>get_type
        EXPORTING
          iv_type = lt_context-process_type
        IMPORTING
          ev_type = lt_context-process_type.

      APPEND lt_context TO et_context.

    ENDSELECT.

  ENDMETHOD.


  METHOD get_cycle.
    DATA lv_source TYPE zsolmove_source.

    SELECT SINGLE release_crm_id INTO @ev_cycle
      FROM tsocm_cr_context AS cont
      LEFT JOIN aic_release_cycl AS cycl ON cont~project_id = cycl~smi_project
    WHERE ( created_guid = @iv_guid AND release_crm_id IS NOT NULL ) " CR.
      OR ( item_guid = @iv_guid AND release_crm_id IS NOT NULL ). " Requierements.

    lv_source = ev_cycle.
    IF lv_source IS NOT INITIAL.
      SELECT SINGLE target INTO @DATA(lv_target) FROM zsolmove_mapping
        WHERE source = @lv_source AND type = 'CYCLE'.

      IF lv_target IS NOT INITIAL.
        ev_cycle = lv_target.
*      ELSE.
*        MESSAGE 'Cycle not mapped' TYPE 'E' RAISING error_not_mapped.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_docflow.
    DATA: ls_doc       TYPE crmt_doc_flow_wrk,
          lt_docs      TYPE crmt_doc_flow_wrkt,
          lv_cycl_guid TYPE crmt_object_guid,
          lv_guid      TYPE crmt_object_guid,
          lv_cycle     TYPE crmt_object_id_db,
          lv_cycle_n   TYPE crmt_object_id_db
          .

    CALL METHOD iv_1o_api->get_doc_flow
      IMPORTING
        et_doc_flow          = lt_docs
      EXCEPTIONS
        document_not_found   = 1
        error_occurred       = 2
        document_locked      = 3
        no_change_authority  = 4
        no_display_authority = 5
        no_change_allowed    = 6
        OTHERS               = 7.
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

    lv_guid = iv_1o_api->get_guid( ).

    "we need to modify link to cycle to save it
    SELECT SINGLE release_crm_id INTO @lv_cycle
      FROM tsocm_cr_context AS cont
      LEFT JOIN aic_release_cycl AS cycl ON cont~project_id = cycl~smi_project
      WHERE ( created_guid = @lv_guid AND release_crm_id IS NOT NULL ) " CR.
      OR ( item_guid = @lv_guid AND release_crm_id IS NOT NULL ). " Requierements.

    SELECT SINGLE guid FROM crmd_orderadm_h WHERE object_id = @lv_cycle
      INTO @lv_cycl_guid.

    CALL METHOD zcl_solmove_helper=>get_cycle
      EXPORTING
        iv_guid          = lv_guid
      IMPORTING
        ev_cycle         = lv_cycle_n
      EXCEPTIONS
        error_not_mapped = 1
        OTHERS           = 2.

    IF sy-subrc <> 0.
*       Implement suitable error handling here
    ENDIF.


    LOOP AT lt_docs INTO ls_doc.
      IF ls_doc-objkey_b = lv_guid AND ls_doc-objkey_a = lv_cycl_guid.
        IF lv_cycle_n IS NOT INITIAL.
          ls_doc-objkey_a = lv_cycle_n.
        ELSE.
          CONTINUE.
        ENDIF.
      ELSEIF ls_doc-objkey_b = lv_guid.
        "we trying to mapp only ls_doc-objkey_b so if obj_b is document itself, we skip this
        CONTINUE.
      ENDIF.
      APPEND ls_doc TO et_docs.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_doc_data.

    DATA: lo_api_object       TYPE REF TO cl_ags_crm_1o_api,
          ls_orderadm_h       TYPE crmt_orderadm_h_wrk,
          lv_type             TYPE crmt_process_type,
          ls_occ_ids          TYPE LINE OF smud_t_guid22,
          lt_occ_ids          TYPE smud_t_guid22,
          ls_status           TYPE crmt_status_wrkt,
          lt_smud_occurrences TYPE cl_ags_crm_1o_api=>tt_smud_occurrence,
          lt_partner_wrkt     TYPE crmt_partner_external_wrkt,
          lt_partner          TYPE comt_partner_comt,
          lv_message          TYPE tdline,
          lt_messages         TYPE zprocess_log_tt.

    "Get document instance
    CALL METHOD cl_ags_crm_1o_api=>get_instance
      EXPORTING
        iv_language                   = sy-langu
        iv_header_guid                = iv_guid
        iv_process_mode               = cl_ags_crm_1o_api=>ac_mode-display
      IMPORTING
        eo_instance                   = lo_api_object
      EXCEPTIONS
        invalid_parameter_combination = 1
        error_occurred                = 2
        OTHERS                        = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
        RAISING error_read_doc.
    ENDIF.

    "get header data
    lo_api_object->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h ).

    "mapping to the target t-type
    CALL METHOD zcl_solmove_helper=>get_type
      EXPORTING
        iv_type = ls_orderadm_h-process_type
      IMPORTING
        ev_type = lt_doc_properties-type.

    lv_type = ls_orderadm_h-process_type.

    IF lt_doc_properties-type IS INITIAL.
      MESSAGE text-001 TYPE 'E'
      RAISING error_no_target_ttype.
    ENDIF.

    "get Header data
    lt_doc_properties-description = ls_orderadm_h-description.
    lt_doc_properties-posting_date = ls_orderadm_h-posting_date.
    lt_doc_properties-created_at = ls_orderadm_h-created_at.
    lt_doc_properties-created_by = ls_orderadm_h-created_by.
    lt_doc_properties-changed_at = ls_orderadm_h-changed_at.
    lt_doc_properties-changed_by = ls_orderadm_h-changed_by.
    lo_api_object->get_priority( IMPORTING ev_priority = lt_doc_properties-priority ).
    lo_api_object->get_category( IMPORTING ev_category = lt_doc_properties-category ).

    "save document id, will be only used for updating priviesly created doc
    lt_doc_properties-object_id-value = ls_orderadm_h-object_id.
    SELECT SINGLE sub_type, target FROM zsolmove_mapping WHERE type = 'ID'
      INTO (@lt_doc_properties-object_id-target_table, @lt_doc_properties-object_id-target_field).
    IF sy-subrc = 4.
      MESSAGE text-001 TYPE 'E'
      RAISING error_no_id.
    ENDIF.

    "save document guid, just for history
    lt_doc_properties-object_guid-value = ls_orderadm_h-guid.
    SELECT SINGLE sub_type, target FROM zsolmove_mapping WHERE type = 'GUID'
      INTO (@lt_doc_properties-object_guid-target_table, @lt_doc_properties-object_guid-target_field).
    IF sy-subrc = 4.
      MESSAGE text-001 TYPE 'E'
      RAISING error_no_guid.
    ENDIF.

    "get all statuses of the document
    CALL METHOD zcl_solmove_helper=>get_status
      EXPORTING
        iv_guid      = iv_guid
      IMPORTING
        ev_status    = lt_doc_properties-status
        ev_status_h  = lt_doc_properties-stat_hist_table
        ev_status_db = lt_doc_properties-status_db.

    "get texts
    CALL METHOD zcl_solmove_helper=>get_texts
      EXPORTING
        iv_1o_api       = lo_api_object
      IMPORTING
        et_text_all     = lt_doc_properties-text_all
        et_textdata_gen = lt_doc_properties-text_gen.

    " get attachments
    CALL METHOD zcl_solmove_helper=>get_attachments
      EXPORTING
        iv_1o_api      = lo_api_object
      IMPORTING
        et_attachments = lt_doc_properties-attach_list
        et_url_list    = lt_doc_properties-url_list.

    "get i-base
    lo_api_object->get_ibase( IMPORTING es_refobj = DATA(lv_refobj) ) .
    IF lv_refobj IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>get_ibase
        EXPORTING
          iv_ibase = lv_refobj-product_id
        IMPORTING
          ev_ibase = lt_doc_properties-ibase.
      IF sy-subrc <> 0.
        CONCATENATE 'No mapping for iBase:' lv_refobj-product_id INTO lv_message SEPARATED BY space.
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.

    " get change cycle
    CALL METHOD zcl_solmove_helper=>get_cycle
      EXPORTING
        iv_guid  = iv_guid
      IMPORTING
        ev_cycle = lt_doc_properties-cycle.
    IF sy-subrc <> 0.
      CONCATENATE 'Error mapping Cycle!' '' INTO lv_message SEPARATED BY space.
      APPEND lv_message TO ev_message.
    ENDIF.

    "get transports
    IF lt_doc_properties-cycle IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>get_tr
        EXPORTING
          iv_guid       = iv_guid
        IMPORTING
          ev_transports = lt_doc_properties-transports.
    ENDIF.

    " get custom fields for WEB UI
    CALL METHOD zcl_solmove_helper=>get_webui_fields
      EXPORTING
        iv_1o_api        = lo_api_object
      IMPORTING
        ev_custom_fields = lt_doc_properties-custom_fields.

    "get business partners
    CALL METHOD zcl_solmove_helper=>get_partners
      EXPORTING
        iv_1o_api  = lo_api_object
      IMPORTING
        lt_partner = lt_doc_properties-partners
        ev_message = lt_messages.

    LOOP AT lt_messages INTO lv_message.
      APPEND lv_message TO ev_message.
    ENDLOOP.

    "get multi level categories
    CALL METHOD zcl_solmove_helper=>get_categories
      EXPORTING
        iv_1o_api = lo_api_object
      IMPORTING
        rt_result = lt_doc_properties-categories.

    "get context
    CALL METHOD zcl_solmove_helper=>get_context
      EXPORTING
        iv_guid    = iv_guid
      IMPORTING
        et_context = lt_doc_properties-context.

    "get docflow
    CALL METHOD zcl_solmove_helper=>get_docflow
      EXPORTING
        iv_1o_api = lo_api_object
      IMPORTING
        et_docs   = lt_doc_properties-doc_flow.

    "get SolDoc data
    CALL METHOD zcl_solmove_helper=>get_soldoc
      EXPORTING
        iv_1o_api = lo_api_object
      IMPORTING
        et_smuds  = lt_doc_properties-occ_ids.

    "get approval procedure
    CALL METHOD zcl_solmove_helper=>get_approval
      EXPORTING
        iv_guid        = iv_guid
      IMPORTING
        et_approval    = lt_doc_properties-approval
        et_approval_db = lt_doc_properties-approval_db.

    "get SLA
    CALL METHOD zcl_solmove_helper=>get_sla
      EXPORTING
        iv_guid        = iv_guid
        iv_1o_api      = lo_api_object
      IMPORTING
        et_sla_db      = lt_doc_properties-sla
        et_sla_db_2    = lt_doc_properties-sla_db
        et_appointment = lt_doc_properties-appointment_t.

    CALL METHOD zcl_solmove_helper=>get_log
      EXPORTING
        iv_1o_api = lo_api_object
      IMPORTING
        et_cdhdr  = lt_doc_properties-cdhdr
        et_cdpos  = lt_doc_properties-cdpos
*       ev_message =
      .


  ENDMETHOD.


  METHOD get_ibase.
    DATA lv_source_ibase TYPE zsolmove_source.
    lv_source_ibase = iv_ibase.
    SELECT SINGLE target INTO @DATA(lv_ibase) FROM zsolmove_mapping
      WHERE source = @lv_source_ibase
      AND type = 'IBASE'.
    IF lv_ibase IS NOT INITIAL.
      ev_ibase = lv_ibase.
*    ELSE.
*      MESSAGE 'iBase not mapped' type 'E' RAISING error_not_mapped.
    ENDIF.
  ENDMETHOD.


  METHOD get_log.
    DATA: lv_guid        TYPE crmt_object_guid,
          ls_cdpos       TYPE cdpos,
          lv_cdpos_key_n TYPE cdtabkey,
          lv_key_len     TYPE i,
          lv_guig_str    TYPE char32.

    lv_guid = iv_1o_api->get_guid( ).

    SELECT * FROM cdhdr WHERE objectid = @lv_guid INTO TABLE @et_cdhdr.

    LOOP AT et_cdhdr INTO DATA(ls_cdhdr).
      SELECT * FROM cdpos WHERE changenr = @ls_cdhdr-changenr INTO @ls_cdpos.
        CLEAR lv_cdpos_key_n.
        CASE ls_cdpos-tabname.
          WHEN 'CRMA_PARTNER'.
            DATA: ls_partner     TYPE crma_partner,
                  lv_guid22      TYPE sysuuid-c22,
                  lv_guid16      TYPE sysuuid_x,
                  lv_partner_fct TYPE crmt_partner_fct.
            "3 mandant
            "22 Character GUID (Converted) for a CRM Object
            "8 Partner Function
            "32 Partner Number
            lv_guid22 = ls_cdpos-tabkey+3(22).
            lv_partner_fct = ls_cdpos-tabkey+25(8).
            lv_guid16  = ls_cdpos-tabkey+33(32).
            SELECT SINGLE partner FROM but000 WHERE partner_guid = @lv_guid16 INTO @DATA(lv_part_old).
            DATA: lv_part_old_c TYPE crmt_partner_number.
            lv_part_old_c = lv_part_old.
            CALL METHOD zcl_solmove_helper=>get_bp_mapping
              EXPORTING
                iv_partner = lv_part_old_c
              IMPORTING
                ev_partner = DATA(lv_part_new).
            IF lv_part_new IS NOT INITIAL.
              CONCATENATE lv_part_new lv_partner_fct INTO lv_cdpos_key_n SEPARATED BY '@'.
            ENDIF.
          WHEN 'CRMA_APPROVAL_S'.
            DATA: lv_app_s_guid TYPE crmt_object_guid.
            lv_app_s_guid = ls_cdpos-tabkey+3.
            SELECT SINGLE step_no FROM crmd_approval_s WHERE guid = @lv_app_s_guid INTO @DATA(lv_app_s_no).
            IF lv_app_s_no IS NOT INITIAL.
              CONCATENATE '@' lv_app_s_no INTO lv_cdpos_key_n.
            ENDIF.
        ENDCASE.
        IF lv_cdpos_key_n IS NOT INITIAL.
          ls_cdpos-tabkey = lv_cdpos_key_n.
        ENDIF.
        APPEND ls_cdpos TO et_cdpos.
      ENDSELECT.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_partners.

    DATA: lt_partner_wrkt   TYPE crmt_partner_external_wrkt,
          ls_partner        TYPE comt_partner_com,
          lv_part_conv      TYPE crmt_partner_number,
          target_partner_no TYPE zsolmove_target,
          lv_message        TYPE tdline.

    CALL METHOD iv_1o_api->get_partners
      IMPORTING
        et_partner           = lt_partner_wrkt
      EXCEPTIONS
        document_not_found   = 1
        error_occurred       = 2
        document_locked      = 3
        no_change_authority  = 4
        no_display_authority = 5
        no_change_allowed    = 6
        OTHERS               = 7.

    IF lt_partner_wrkt IS NOT INITIAL.
      LOOP AT lt_partner_wrkt INTO DATA(ls_partner_wrk).

        CALL METHOD zcl_solmove_helper=>get_bp_mapping
          EXPORTING
            iv_partner = ls_partner_wrk-ref_partner_no
          IMPORTING
            ev_partner = lv_part_conv.

        IF lv_part_conv IS NOT INITIAL.
          ls_partner-partner_no     = lv_part_conv.
          ls_partner-partner_fct    = ls_partner_wrk-partner_fct.
          ls_partner-no_type        = ls_partner_wrk-no_type.
          ls_partner-display_type   = ls_partner_wrk-display_type.
          INSERT ls_partner INTO TABLE lt_partner.
        ELSE.
          CONCATENATE 'BP:' ls_partner_wrk-ref_partner_no 'not mapped.' INTO lv_message SEPARATED BY space.
          APPEND lv_message to ev_message.
        ENDIF.

        CLEAR ls_partner.
        CLEAR target_partner_no.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD get_sla.
    "  DB DATA: .
    SELECT * FROM crmd_srcl_h
      WHERE guid = @iv_guid
      INTO TABLE @et_sla_db.

    SELECT SINGLE * FROM crmd_orderadm_i
      WHERE header = @iv_guid
      INTO @DATA(ls_sla_items).

    SELECT  s~appt_guid,
            'ITEM' AS appl_guid,
            s~tst_from,
            s~zone_from,
            s~tst_to,
            s~zone_to,
            s~appt_type,
            s~txt_pub_id,
            s~entry_by,
            s~entry_tst,
            s~change_by,
            s~change_tst
      FROM crmd_link
      LEFT JOIN scapptseg AS s ON s~appl_guid = crmd_link~guid_set
      WHERE guid_hi = @ls_sla_items-guid
      AND objtype_set = 30
      UNION ALL
      SELECT s~appt_guid,
            'DOC' AS appl_guid,
            s~tst_from,
            s~zone_from,
            s~tst_to,
            s~zone_to,
            s~appt_type,
            s~txt_pub_id,
            s~entry_by,
            s~entry_tst,
            s~change_by,
            s~change_tst
      FROM crmd_link
      LEFT JOIN scapptseg AS s ON s~appl_guid = crmd_link~guid_set
      WHERE guid_hi = @iv_guid
      AND objtype_set = 30
      INTO TABLE @data(lt_sla_db_2).

      move-corresponding lt_sla_db_2 to et_sla_db_2.

    " Appointments data
    CALL METHOD iv_1o_api->get_appointments
      IMPORTING
        et_appointment       = et_appointment
      EXCEPTIONS
        document_not_found   = 1
        error_occurred       = 2
        document_locked      = 3
        no_change_authority  = 4
        no_display_authority = 5
        no_change_allowed    = 6
        OTHERS               = 7.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDMETHOD.


  METHOD get_soldoc.
    DATA: lv_smud             TYPE zsmud_occurrence,
          lt_smud_occurrences TYPE cl_ags_crm_1o_api=>tt_smud_occurrence.

    "get occ_ids
    iv_1o_api->get_smud_occurrences(
      IMPORTING
        et_smud_occurrences = lt_smud_occurrences ).

    IF lt_smud_occurrences IS NOT INITIAL.
      LOOP AT lt_smud_occurrences INTO DATA(ls_smud_ids).
        CLEAR lv_smud.

        lv_smud-occ_id = ls_smud_ids-occ_id.

        SELECT SINGLE target
          FROM zsolmove_mapping
          WHERE source = @ls_smud_ids-root_occ
          INTO @DATA(lv_root_occ).

        IF lv_root_occ IS NOT INITIAL.
          lv_smud-root_occ = lv_root_occ.
        ENDIF.

        lv_smud-scope_id = ls_smud_ids-scope_id.

        APPEND lv_smud TO et_smuds.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_status.
    DATA lv_stat   TYPE crm_j_status.

    "active status
    SELECT stat FROM crm_jest INTO TABLE @ev_status "system status
    WHERE inact = '' AND objnr = @iv_guid.

    "status change history
    SELECT * FROM crm_jcds WHERE objnr = @iv_guid
      INTO TABLE @ev_status_h.

    "just move all status...
    SELECT * FROM crm_jest INTO TABLE @ev_status_db
    WHERE objnr = @iv_guid.

  ENDMETHOD.


  METHOD get_test_data.
    DATA lt_context     TYPE TABLE OF ssocm_i_context.
    DATA ls_twb         TYPE aic_s_twb_cont_display.
    DATA lv_object_name TYPE crmt_ext_obj_name.

    INCLUDE: crm_events_con,  crm_object_kinds_con.

* Buffer new entries from DB
    CALL FUNCTION 'GET_CRM_CONTEXT_DB_VIEW'
      EXPORTING
        im_crm_object_guid = iv_guid
      TABLES
        ch_socm_db_view    = lt_context.

* Add entries to new document
    LOOP AT lt_context INTO DATA(ls_context).

      IF ls_context-context_type = cl_ai_crm_utility=>c_cont_type_testplan OR " Test Plan
         ls_context-context_type = cl_ai_crm_utility=>c_cont_type_testpack.   " Test Package

*        "GUID of Test Mgmt AB entry
*        TRY.
*            ls_twb-twb_node_guid = cl_system_uuid=>create_uuid_x16_static( ).
*          CATCH cx_uuid_error.
*        ENDTRY.
*
*        " Context Type - Test Plan or Test Package
*        ls_twb-context_type = ls_context-context_type.
*
*        " External ID - contain Test Plan id or both (Test Plan and Package)
*        IF ls_context-context_type = cl_ai_crm_utility=>c_cont_type_testplan.
*          ls_twb-tpln_id = ls_context-external_id.
*        ELSEIF ls_context-context_type = cl_ai_crm_utility=>c_cont_type_testpack.
*          SPLIT ls_context-external_id AT '#' INTO ls_twb-tpck_id ls_twb-tpln_id.
*        ENDIF.
*
*        " GUID of new CRM Document
*        ls_twb-crm_document_guid = is_target-guid.
*
*        " Text of Test Object
*        ls_twb-twb_node_text  = ls_context-text.
*
*        "Create Test Mgmt AB entry in backend API buffer for new document
*        DATA(lv_success) = cl_aic_twb_cont_backend_api=>create( ls_twb ).
*
*        IF lv_success = abap_false.
*          EXIT. " if no data could be created, do not save anything!
*        ENDIF.
*
*        CLEAR ls_twb.

      ENDIF.

    ENDLOOP.

** Save entries only if successful maintained in buffer
*    IF lv_success = abap_true.
** Publish change to trigger SAVE EC FuBa when SAVE event is raised
*      lv_object_name = cl_ai_crm_cm_twb_cont_run_btil=>c_relation_twb_context. "'BTAICTWBContext'.
*      TRANSLATE lv_object_name TO UPPER CASE.
*      CALL FUNCTION 'CRM_EVENT_PUBLISH_OW'
*        EXPORTING
*          iv_obj_name = lv_object_name   "iv_objname is case sensitive, must be identical with entry in CRMV_OBJ_FUNC
*          iv_guid_hi  = is_target-guid
*          iv_kind_hi  = gc_object_kind-orderadm_h    "'A'
*          iv_event    = gc_event-after_change.
*    ENDIF.

  ENDMETHOD.


  METHOD get_texts.

    DATA: lo_api_object TYPE REF TO cl_ags_crm_1o_api,
          lt_text_gen   TYPE crmt_text_gen_ext_tab.


    iv_1o_api->get_texts(
      IMPORTING
            et_text_all = et_text_all
            et_text_gen = et_textdata_gen ).

  ENDMETHOD.


  METHOD get_tr.
* Read transport requests from /tmwflow/trord_n
    DATA: lt_transports TYPE /TMWFLOW/TRORDHC_T,
          ls_transport  TYPE /tmwflow/trordhc_s,
          ls_tr_trans   TYPE ztr_data_st.

    /tmwflow/cl_transport_util=>get_chng_doc_transp_req(
        EXPORTING
          iv_header_guid = iv_guid
        IMPORTING
          et_transp_req_new  = lt_transports  ).

    IF lt_transports IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT lt_transports INTO ls_transport.
      CLEAR ls_tr_trans.
      MOVE-CORRESPONDING ls_transport TO ls_tr_trans.
      APPEND ls_tr_trans TO ev_transports.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_type.
    DATA lv_source_type TYPE zsolmove_source.
    lv_source_type = iv_type.
    SELECT SINGLE target INTO @DATA(lv_type) FROM zsolmove_mapping
      WHERE source = @lv_source_type
      AND type = 'TYPE'.
    IF lv_type IS NOT INITIAL.
      ev_type = lv_type.
*    ELSE.
*      MESSAGE 'Doc. type not mapped' TYPE 'E' RAISING error_not_mapped.
    ENDIF.

  ENDMETHOD.


  METHOD get_webui_fields.

    DATA: ls_customer_h  TYPE crmt_customer_h_wrk.
    DATA: ls_orderadm_h  TYPE crmt_orderadm_h_wrk.
    DATA: ls_custom_line TYPE zcustom_fields.
    DATA: lv_source       TYPE zsolmove_source.
    DATA: lv_sub_type    TYPE zsolmove_param.
    DATA: fldname        TYPE fieldname.

    FIELD-SYMBOLS: <fld> TYPE any.

    "get header data
    iv_1o_api->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h ).

    " get customer header
    iv_1o_api->get_customer_h( IMPORTING es_customer_h = ls_customer_h ).

    "save customer_h fields that was mapped
    SELECT source, target FROM zsolmove_mapping WHERE type = 'FILD' AND sub_type = 'CUSTOMER_H'
      INTO (@lv_source, @ls_custom_line-target_field).
      ls_custom_line-target_table = 'CUSTOMER_H'.
      CONCATENATE 'ls_customer_h-' lv_source INTO fldname.
      ASSIGN (fldname) TO <fld>.
      ls_custom_line-value = <fld>.
      IF ls_custom_line-value IS NOT INITIAL.
        APPEND ls_custom_line TO ev_custom_fields.
      ENDIF.
    ENDSELECT.
    "add other custom tables if requiered....

    "get additional data (old document id) to custom fields in target system
    SELECT sub_type, target FROM zsolmove_mapping WHERE type = 'ID'
      INTO (@lv_sub_type, @ls_custom_line-target_field).

      IF lv_sub_type = 'CUSTOMER_H'.
        ls_custom_line-target_table = 'CUSTOMER_H'.
        ls_custom_line-value = ls_orderadm_h-object_id.
        "add other custom tables if requiered....
      ENDIF.

      IF ls_custom_line-value IS NOT INITIAL.
        APPEND ls_custom_line TO ev_custom_fields.
      ENDIF.
    ENDSELECT.

    "get additional data (old document guid) to custom fields in target system
    SELECT sub_type, target FROM zsolmove_mapping WHERE type = 'GUID'
      INTO (@lv_sub_type, @ls_custom_line-target_field).

      IF lv_sub_type = 'CUSTOMER_H'.
        ls_custom_line-target_table = 'CUSTOMER_H'.
        ls_custom_line-value = ls_orderadm_h-guid.
      ENDIF.

      IF ls_custom_line-value IS NOT INITIAL.
        APPEND ls_custom_line TO ev_custom_fields.
      ENDIF.
    ENDSELECT.


  ENDMETHOD.


  METHOD set_approval.
    DATA: ls_approval_wrk_old TYPE crmt_approval_wrk,
          ls_approval_wrk_new TYPE crmt_approval_wrk,
          ls_approval_com     TYPE crmt_approval_com,
          ls_input_field_name TYPE crmt_input_field_names,
          ls_input_field      TYPE crmt_input_field,
          lt_input_fields     TYPE crmt_input_field_tab,
          ls_approval_s_wrk   TYPE crmt_approval_s_wrk,
          lt_approval_s_com   TYPE crmt_approval_s_comt,
          ls_approval_s_com   TYPE crmt_approval_s_com,
          lv_guid(32)         TYPE c,
          lv_memory_id(50)    TYPE c,
          ls_approval         TYPE crmd_approval_s,
          lt_approval_t       TYPE TABLE OF crmd_approval_s.

    INCLUDE crm_approval_con.
    INCLUDE crm_object_names_con.

** Maintain Approval Procedure only if Approval Procedure is available
    CHECK et_approval IS NOT INITIAL.
*get mapped approval if exist
    "Read the approval of the source document
    CALL FUNCTION 'CRM_APPROVAL_READ_OB'
      EXPORTING
        iv_ref_guid          = iv_guid
        iv_ref_kind          = 'A'
      IMPORTING
        es_approval_wrk      = ls_approval_wrk_old
      EXCEPTIONS
        entry_does_not_exist = 1
        parameter_error      = 2
        OTHERS               = 3.

    IF sy-subrc <> 0.
      "no approval procedure or error - copy not possible
      RETURN.
    ENDIF.

    IF ls_approval_wrk_old IS INITIAL.

* maintain approval procedure first because without approval no steps can be created
      ls_approval_com-ref_guid = iv_guid.
      ls_approval_com-ref_kind = 'A'.
      ls_approval_com-aprv_procedure = et_approval-aprv_procedure.

** Set flag to allow edit steps at the beginning (will be disabled once status in "Approved")
      ls_approval_com-change_allowed = abap_true.

** Fill input fields
      ls_input_field-ref_guid = iv_guid.
      ls_input_field-ref_kind = 'A'.
      CALL METHOD cl_crm_approval_utility=>build_logical_key
        EXPORTING
          iv_guid        = iv_guid
          iv_object      = gc_logical_object-approval
        RECEIVING
          rv_logical_key = ls_input_field-logical_key.

      ls_input_field-objectname = gc_object_name-approval.

      ls_input_field_name-fieldname = 'APRV_PROCEDURE'.     "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'CHANGE_ALLOWED'.     "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.

      INSERT ls_input_field INTO TABLE lt_input_fields.

      CALL FUNCTION 'CRM_APPROVAL_MAINTAIN_OW'
        EXPORTING
          is_approval_com = ls_approval_com
        CHANGING
          ct_input_fields = lt_input_fields
        EXCEPTIONS
          error_occurred  = 1
          OTHERS          = 2.

      CHECK sy-subrc EQ 0.

** now maintain approval steps
      "Read the approval procedure to get SET_GUID of Approval
      CALL FUNCTION 'CRM_APPROVAL_READ_OB'
        EXPORTING
          iv_ref_guid          = iv_guid
          iv_ref_kind          = 'A'
        IMPORTING
          es_approval_wrk      = ls_approval_wrk_new
        EXCEPTIONS
          entry_does_not_exist = 1
          parameter_error      = 2
          OTHERS               = 3.

* copy steps from old to new document
      LOOP AT et_approval-approval_steps_wrk INTO ls_approval_s_wrk.
        MOVE-CORRESPONDING  ls_approval_s_wrk TO ls_approval_s_com.
        ls_approval_s_com-ref_guid       = iv_guid.
        ls_approval_s_com-parent_guid    = ls_approval_wrk_new-guid.
        APPEND ls_approval_s_com TO lt_approval_s_com.
      ENDLOOP.
** Fill input fields for approval steps
      CLEAR: lt_input_fields, ls_input_field.

      ls_input_field-ref_guid = iv_guid.
      ls_input_field-ref_kind = 'A'.
      CALL METHOD cl_crm_approval_utility=>build_logical_key
        EXPORTING
          iv_guid        = iv_guid
          iv_object      = gc_logical_object-approval_s
        RECEIVING
          rv_logical_key = ls_input_field-logical_key.

      ls_input_field-objectname = gc_object_name-approval.

      ls_input_field_name-fieldname = 'APRV_STATUS_PF'.     "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'PARTNER_FCT'.        "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'PARTNER_NO'.         "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'STEP_ID'.            "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'STEP_SEQUENCE'.      "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'STEP_TYPE'.          "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'EXECUTION_STATUS'.   "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'APRV_ACT'.           "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'PROCESSED_BY'.       "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'IS_RELEVANT'.        "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.


      INSERT ls_input_field INTO TABLE lt_input_fields.

      CALL FUNCTION 'CRM_APPROVAL_S_MAINTAIN_M_OW'
        EXPORTING
          iv_parent_guid    = ls_approval_wrk_new-guid
          it_approval_s_com = lt_approval_s_com
          iv_ref_guid       = iv_guid
          iv_ref_kind       = 'A'
        CHANGING
          ct_input_fields   = lt_input_fields
        EXCEPTIONS
          error_occurred    = 1
          OTHERS            = 2.

      CHECK sy-subrc EQ 0.

* fill memory, Memory will be checked in FM AIC_APPROVAL_S_DETERMINE_EC
* to avoid to overwrite the approval by standard determination
      lv_guid = iv_guid.
      CONCATENATE lv_guid '/' gc_object_name-approval INTO lv_memory_id.
      EXPORT approval = abap_true TO MEMORY ID lv_memory_id.

    ELSE.
      " first allow change to approval proc.
      IF ls_approval_wrk_old-change_allowed <> abap_true.
        MOVE-CORRESPONDING ls_approval_wrk_old TO ls_approval_com.
        ls_approval_com-change_allowed = abap_true.

        ls_input_field-ref_guid   = ls_approval_com-ref_guid.
        ls_input_field-ref_kind   = ls_approval_com-ref_kind.
        ls_input_field-objectname = gc_object_name-approval.
        CALL METHOD cl_crm_approval_utility=>build_logical_key
          EXPORTING
            iv_guid        = iv_guid
            iv_handle      = ls_approval_com-ref_handle
            iv_object      = gc_logical_object-approval
          RECEIVING
            rv_logical_key = ls_input_field-logical_key.

        ls_input_field_name-fieldname = 'CHANGE_ALLOWED'.   "#EC NOTEXT
        INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
        INSERT ls_input_field INTO TABLE lt_input_fields.

        CALL FUNCTION 'CRM_APPROVAL_MAINTAIN_OW'
          EXPORTING
            is_approval_com = ls_approval_com
          CHANGING
            ct_input_fields = lt_input_fields
          EXCEPTIONS
            error_occurred  = 1
            OTHERS          = 2.
        CHECK sy-subrc EQ 0.

      ENDIF.

      "approval procedure was created before. Just change the steps.
      LOOP AT et_approval-approval_steps_wrk INTO ls_approval_s_wrk.
        CLEAR ls_approval.
        MOVE-CORRESPONDING  ls_approval_s_wrk TO ls_approval_s_com.
        ls_approval_s_com-ref_guid       = iv_guid.
        ls_approval_s_com-parent_guid    = ls_approval_wrk_old-guid. "!
        APPEND ls_approval_s_com TO lt_approval_s_com.
      ENDLOOP.
** Fill input fields for approval steps
      CLEAR: lt_input_fields, ls_input_field.

      ls_input_field-ref_guid = iv_guid.
      ls_input_field-ref_kind = 'A'.
      CALL METHOD cl_crm_approval_utility=>build_logical_key
        EXPORTING
          iv_guid        = iv_guid
          iv_object      = gc_logical_object-approval_s
        RECEIVING
          rv_logical_key = ls_input_field-logical_key.

      ls_input_field-objectname = gc_object_name-approval.

      ls_input_field_name-fieldname = 'APRV_STATUS_PF'.     "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'PARTNER_FCT'.        "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'PARTNER_NO'.         "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'STEP_ID'.            "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'STEP_SEQUENCE'.      "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'STEP_TYPE'.          "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'EXECUTION_STATUS'.   "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'APRV_ACT'.           "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'PROCESSED_BY'.       "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.
      ls_input_field_name-fieldname = 'IS_RELEVANT'.        "#EC NOTEXT
      INSERT ls_input_field_name INTO TABLE ls_input_field-field_names.

      INSERT ls_input_field INTO TABLE lt_input_fields.

      CALL FUNCTION 'CRM_APPROVAL_S_MAINTAIN_M_OW'
        EXPORTING
          iv_parent_guid    = ls_approval_wrk_old-guid
          it_approval_s_com = lt_approval_s_com
          iv_ref_guid       = iv_guid
          iv_ref_kind       = 'A'
        CHANGING
          ct_input_fields   = lt_input_fields
        EXCEPTIONS
          error_occurred    = 1
          OTHERS            = 2.

      CHECK sy-subrc EQ 0.

    ENDIF.

  ENDMETHOD.


  METHOD set_approval_db.
    DATA: ls_approval_wrk TYPE crmt_approval_wrk,
          ls_approval     TYPE crmd_approval_s,
          ls_approval_n   TYPE crmd_approval_s,
          lt_approval_t   TYPE TABLE OF crmd_approval_s.

    "Read the approval of the source document
    CALL FUNCTION 'CRM_APPROVAL_READ_OB'
      EXPORTING
        iv_ref_guid          = iv_guid
        iv_ref_kind          = 'A'
      IMPORTING
        es_approval_wrk      = ls_approval_wrk
      EXCEPTIONS
        entry_does_not_exist = 1
        parameter_error      = 2
        OTHERS               = 3.

** Maintain Approval Procedure only if Approval Procedure is available
    CHECK et_approval_db IS NOT INITIAL AND ls_approval_wrk IS NOT INITIAL.
    LOOP AT et_approval_db INTO ls_approval.
      ls_approval-parent_guid       = ls_approval_wrk-guid.
      SELECT SINGLE guid FROM crmd_approval_s
        WHERE parent_guid = @ls_approval_wrk-guid AND
        step_no = @ls_approval-step_no
        INTO @ls_approval-guid.
      APPEND ls_approval TO lt_approval_t.
    ENDLOOP.

    "modify CRMD_APPROVAL_S table
    MODIFY crmd_approval_s FROM TABLE lt_approval_t .
  ENDMETHOD.


  METHOD set_attachments.

    DATA: ls_attachment       TYPE  zattachment,
          ls_bo               TYPE  sibflporb,
          lt_file_err         TYPE  skwf_error,
          ls_loio             TYPE  skwf_io,
          ls_phio             TYPE  skwf_io,
          lt_attachment_props TYPE  sdokproptys,
          ls_attachment_props LIKE  LINE OF lt_attachment_props,
          lt_attachment_list  TYPE ags_t_crm_attachment,
          lt_url_list         TYPE ags_t_crm_attachment,
          lt_url              TYPE sdokcntascs,
          wa_url              TYPE sdokcntasc.

    "first check if there are attachments (can be enhanced)
    iv_1o_api->get_attachment_list( IMPORTING
      et_attach_list = lt_attachment_list
      et_url_list    = lt_url_list ).
    IF lt_attachment_list IS INITIAL .
      IF iv_attach_list IS NOT INITIAL.

        ls_bo-instid = iv_guid.
        ls_bo-typeid = iv_object_type.
        ls_bo-catid = 'BO'.

        LOOP AT iv_attach_list INTO ls_attachment.

          CLEAR: lt_file_err, lt_attachment_props, ls_attachment_props.
          IF lines( ls_attachment-file_access_info ) > 0.

            ls_attachment_props-name = 'FILE_NAME'.
            ls_attachment_props-value = ls_attachment-file_name.
            APPEND ls_attachment_props TO lt_attachment_props.

            ls_attachment_props-name = 'TECHN_FILE_NAME'.
            ls_attachment_props-value = ls_attachment-file_access_info[ 1 ]-file_name.
            APPEND ls_attachment_props TO lt_attachment_props.

            ls_attachment_props-name = 'DESCRIPTION'.
            ls_attachment_props-value = ls_attachment-description.
            APPEND ls_attachment_props TO lt_attachment_props.

            ls_attachment_props-name = 'EXTENSION'.
            ls_attachment_props-value = ls_attachment-extension.
            APPEND ls_attachment_props TO lt_attachment_props.

            ls_attachment_props-name = 'KW_RELATIVE_URL'.
            ls_attachment_props-value = ls_attachment-file_name.
            APPEND ls_attachment_props TO lt_attachment_props.

            ls_attachment_props-name = 'LANGUAGE'.
            ls_attachment_props-value = sy-langu.
            APPEND ls_attachment_props TO lt_attachment_props.


            CALL METHOD cl_crm_documents=>create_with_table
              EXPORTING
                business_object     = ls_bo
                properties          = lt_attachment_props
                file_access_info    = ls_attachment-file_access_info
                file_content_binary = ls_attachment-file_content_binary
*               file_content_ascii  = ls_attachment-file_content_ascii
              IMPORTING
                loio                = ls_loio
                phio                = ls_phio
                error               = lt_file_err.

            IF lt_file_err IS NOT INITIAL.
              CONCATENATE 'Attachment creation failed,' lt_file_err-no lt_file_err-v1 INTO ev_message SEPARATED BY space.
              CONTINUE.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ELSE.
      ev_message = 'Attachment exist. Skipping attachments.'.
    ENDIF.

    IF lt_url_list IS INITIAL.
      IF it_url_list IS NOT INITIAL.

        ls_bo-instid = iv_guid.
        ls_bo-typeid = iv_object_type.
        ls_bo-catid = 'BO'.

        LOOP AT it_url_list INTO ls_attachment.

          wa_url-line = ls_attachment-url.
          APPEND wa_url TO lt_url.

          CLEAR: lt_file_err, lt_attachment_props, ls_attachment_props.

          ls_attachment_props-name = 'FILE_NAME'.
          ls_attachment_props-value = ls_attachment-file_name.
          APPEND ls_attachment_props TO lt_attachment_props.

          ls_attachment_props-name = 'EXTENSION'.
          ls_attachment_props-value = ls_attachment-extension.
          APPEND ls_attachment_props TO lt_attachment_props.


          ls_attachment_props-name = 'DESCRIPTION'.
          ls_attachment_props-value = ls_attachment-description.
          APPEND ls_attachment_props TO lt_attachment_props.

          ls_attachment_props-name = 'KW_RELATIVE_URL'.
          ls_attachment_props-value = ls_attachment-file_name.
          APPEND ls_attachment_props TO lt_attachment_props.

          ls_attachment_props-name = 'LANGUAGE'.
          ls_attachment_props-value = sy-langu.
          APPEND ls_attachment_props TO lt_attachment_props.

          CALL METHOD cl_crm_documents=>create_url
            EXPORTING
              url             = lt_url
              properties      = lt_attachment_props
              business_object = ls_bo
            IMPORTING
              loio            = ls_loio
              phio            = ls_phio
              error           = lt_file_err.
          .

          IF lt_file_err IS NOT INITIAL.
            CONCATENATE 'Attachment URL creation failed,' lt_file_err-no lt_file_err-v1 INTO ev_message SEPARATED BY space.
            CONTINUE.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ELSE.
      ev_message = 'Attachment URL exist. Skipping URL attachments.'.
    ENDIF.

  ENDMETHOD.


  METHOD set_categories.
    DATA lv_cat TYPE crmt_subject_com.
    MOVE-CORRESPONDING it_categories TO lv_cat.

    lv_cat-ref_guid = iv_1o_api->get_guid( ).

    CALL METHOD iv_1o_api->get_subject
      IMPORTING
        es_subject = DATA(lv_subj)
*      EXCEPTIONS
*       document_not_found   = 1
*       error_occurred       = 2
*       document_locked      = 3
*       no_change_authority  = 4
*       no_display_authority = 5
*       no_change_allowed    = 6
*       others     = 7
      .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.


    CALL METHOD iv_1o_api->set_subject
      EXPORTING
        is_subject = lv_cat
*      CHANGING
*       cv_log_handle     =
*      EXCEPTIONS
*       error_occurred    = 1
*       document_locked   = 2
*       no_change_allowed = 3
*       no_authority      = 4
*       others     = 5
      .
    IF sy-subrc <> 0.
*     Implement suitable error handling here
    ENDIF.

  ENDMETHOD.


  METHOD set_context.

    DATA: ls_cr_context         TYPE tsocm_cr_context,
          lt_cr_context         TYPE TABLE OF tsocm_cr_context,
          lv_doc_guid           TYPE zcustom_fields,
          lv_found_guid         TYPE crmt_object_guid,
          lv_search_comp_detail TYPE ibap_comp1,
          lv_found_comp_detail  TYPE ibap_dat1.

    lv_doc_guid = iv_doc_guid.

    "Get values for cycle
    SELECT SINGLE * FROM aic_release_cycl INTO @DATA(lv_rel)
    WHERE release_crm_id = @iv_cycle.

    SELECT SINGLE * FROM tsocm_cr_context INTO @DATA(lv_cyc_context)
    WHERE guid = @lv_rel-release_crm_guid.

    LOOP AT et_context INTO ls_cr_context.
      CLEAR lv_found_guid.

      "fill in context with new entetys data.
      ls_cr_context-guid = iv_guid. "new document guig

      "find mapping for target guid
      lv_doc_guid-value = ls_cr_context-created_guid.
      CALL METHOD zcl_solmove_helper=>find_doc
        EXPORTING
          iv_doc_guid   = lv_doc_guid
        IMPORTING
          ev_guid       = lv_found_guid
        EXCEPTIONS
          error_mapping = 1
          OTHERS        = 2.
      IF sy-subrc <> 0.
*       Implement suitable error handling here.
      ENDIF.

      IF lv_found_guid IS NOT INITIAL.
        ls_cr_context-created_guid = lv_found_guid.

        IF ls_cr_context-slan_id IS NOT INITIAL.
          "set solution id and branch id from the mapped cycle.
          ls_cr_context-slan_id = lv_cyc_context-slan_id.
          ls_cr_context-sbra_id = lv_cyc_context-sbra_id.
        ENDIF.

        IF ls_cr_context-project_id IS NOT INITIAL.
          "set new cycle information
          ls_cr_context-project_id  = lv_rel-smi_project.
          ls_cr_context-solution_id = iv_cycle.
        ENDIF.
        " set correct iBase info
        IF ls_cr_context-product_id IS NOT INITIAL.
          SELECT SINGLE product_guid INTO @DATA(lv_p_guid16)
            FROM comm_product
            WHERE product_id = @ls_cr_context-product_id.
          lv_search_comp_detail-object_guid = lv_p_guid16.

          CALL FUNCTION 'CRM_IBASE_COMP_FIND'
            EXPORTING
              i_comp_det        = lv_search_comp_detail
            IMPORTING
              e_comp            = lv_found_comp_detail
            EXCEPTIONS
              not_found         = 1
              several_instances = 2
              OTHERS            = 3.
          IF sy-subrc <> 0.
            CONTINUE.  "with next entry
          ENDIF.
          ls_cr_context-ibase = lv_found_comp_detail-ibase.
          ls_cr_context-ibase_instance = lv_found_comp_detail-instance.
        ENDIF.
      ENDIF.
      APPEND ls_cr_context TO lt_cr_context.
    ENDLOOP.
    IF lt_cr_context IS NOT INITIAL.
      SET UPDATE TASK LOCAL.
      MODIFY tsocm_cr_context FROM TABLE lt_cr_context.
      IF sy-subrc = 0.
        COMMIT WORK.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD SET_CREATION_INFO_DB.

*   update creating information
    DATA(lv_posting_date) = iv_doc_properties-posting_date.
    DATA(lv_created_at) = iv_doc_properties-created_at.
    DATA(lv_created_by) = iv_doc_properties-created_by.
    DATA(lv_changed_at) = iv_doc_properties-changed_at.
    DATA(lv_changed_by) = iv_doc_properties-changed_by.

    UPDATE crmd_orderadm_h
        SET posting_date = @lv_posting_date,
        created_at = @lv_created_at,
        created_by = @lv_created_by,
        changed_at = @lv_changed_at,
        changed_by = @lv_changed_by
      WHERE guid EQ @iv_guid.

  ENDMETHOD.


  method set_cycle.

    data: ls_cr_context_to type tsocm_cr_context.

    "Get values for cycle
    select single * from aic_release_cycl into @data(lv_rel)
    where release_crm_id = @iv_cycle.

    select single * from tsocm_cr_context into @data(lv_context)
    where guid = @lv_rel-release_crm_guid.


    "Set values for cycle
    ls_cr_context_to-guid = iv_guid.
    ls_cr_context_to-item_guid = iv_guid.
    ls_cr_context_to-client = sy-mandt.
    ls_cr_context_to-process_type = iv_type.
    ls_cr_context_to-ibase = 0.
    ls_cr_context_to-ibase_instance = 0.
    ls_cr_context_to-created_on = 0.
    ls_cr_context_to-created_guid = iv_guid.
    ls_cr_context_to-project_id = lv_rel-smi_project.
    ls_cr_context_to-solution_id = iv_cycle.
    ls_cr_context_to-slan_id = lv_context-slan_id.
    ls_cr_context_to-sbra_id = lv_rel-branch_id.
    ls_cr_context_to-product_id = iv_ibase.

    "modify tsocm_cr_context from ls_cr_context_to.
    cl_ai_crm_cm_cr_cont_run_btil=>update_cr_context( ls_cr_context_to ).

  endmethod.


  METHOD set_docflow.
    DATA: lv_doc        TYPE crmt_doc_flow_wrk,
          lv_doc_fl     TYPE crmt_doc_flow_comt,
          lv_doc_fl_e   TYPE crmt_doc_flow_extd,
          lv_doc_l      TYPE crmt_doc_flow_com,
          lv_log_handle TYPE balloghndl,
          lv_doc_guid   TYPE zcustom_fields,
          lv_cycl_guid  TYPE crmt_object_guid,
          lv_found_guid TYPE crmt_object_guid.

    lv_doc_guid = iv_doc_guid.

    LOOP AT lt_docs INTO lv_doc.
      CLEAR  lv_found_guid.

      "build link
      MOVE-CORRESPONDING lv_doc TO lv_doc_fl_e.
      "link to cycle
      IF strlen( lv_doc_fl_e-objkey_a ) = 10.
        SELECT SINGLE guid FROM crmd_orderadm_h WHERE object_id = @lv_doc_fl_e-objkey_a
        INTO @lv_cycl_guid.
        IF lv_cycl_guid IS NOT INITIAL.
          lv_doc_fl_e-objkey_a = lv_cycl_guid.
          lv_doc_fl_e-objkey_b = iv_guid. " guid of the doc
          APPEND lv_doc_fl_e TO lv_doc_l-doc_link.
        ENDIF.
      ELSE.
        lv_doc_guid-value = lv_doc_fl_e-objkey_b.

        CALL METHOD zcl_solmove_helper=>find_doc
          EXPORTING
*           iv_doc_id     =
            iv_doc_guid   = lv_doc_guid
*           iv_type       =
          IMPORTING
            ev_guid       = lv_found_guid
          EXCEPTIONS
            error_mapping = 1
            OTHERS        = 2.
        IF sy-subrc <> 0.
          CONCATENATE 'DOCFLOW skiped: GUID field:' lv_doc_guid-target_table lv_doc_guid-target_field 'missing in target.' INTO  ev_message SEPARATED BY space.
          RETURN.
        ENDIF.
        IF  lv_found_guid IS NOT INITIAL.
          lv_doc_fl_e-objkey_a = iv_guid.
          lv_doc_fl_e-objkey_b = lv_found_guid. " guid of the doc
          APPEND lv_doc_fl_e TO lv_doc_l-doc_link.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lv_doc_l-doc_link IS NOT INITIAL.
      lv_doc_l-ref_guid = iv_guid.
      lv_doc_l-ref_kind = 'A'.
      APPEND lv_doc_l TO lv_doc_fl.

      CALL METHOD iv_1o_api->set_doc_flow
        CHANGING
          ct_doc_flow       = lv_doc_fl
          cv_log_handle     = lv_log_handle
        EXCEPTIONS
          error_occurred    = 1
          document_locked   = 2
          no_change_allowed = 3
          no_authority      = 4
          OTHERS            = 5.

      IF sy-subrc <> 0.
        CONCATENATE 'DOCFLOW error:' '' INTO  ev_message SEPARATED BY space.
        RETURN.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  method set_ibase.

    data: z_ibase               type ib_ibase,
          z_product_id          type comt_product_id,
          is_refobj             type crmt_refobj_com,
          cv_log_handle         type balloghndl,
          lv_product_id         type string,
          lv_search_comp_detail type ibap_comp1,
          lv_found_comp_detail  type ibap_dat1,
          lv_comp_detail        type ibap_comp2.


    select product_guid into @data(lv_p_guid16) from comm_product where product_id = @iv_ibase.

      lv_search_comp_detail-object_guid = lv_p_guid16.

      call function 'CRM_IBASE_COMP_FIND'
        exporting
          i_comp_det        = lv_search_comp_detail
*         I_DATE            =
*         I_TIME            =
*         IV_INCLUDE_VOID   =
        importing
          e_comp            = lv_found_comp_detail
        exceptions
          not_found         = 1
          several_instances = 2
          others            = 3.
      if sy-subrc <> 0.
        continue.  "with next entry
      endif.

*      call function 'CRM_IBASE_COMP_GET_DETAIL'
*        exporting
*          i_comp        = lv_found_comp_detail
**         I_DATE        =
**         I_TIME        =
**         IV_DO_AUTH_CHECK       =
*        importing
*          e_comp_det    = lv_comp_detail
**       TABLES
**         ET_STATUS     =
*        exceptions
*          not_specified = 1
*          doesnt_exist  = 2
*          no_authority  = 3
*          others        = 4.
*      if sy-subrc <> 0.
*        continue.  "with next entry
*      endif.
    endselect.

    is_refobj-ref_guid    = iv_guid.
    is_refobj-product_id  = iv_ibase.
    is_refobj-ib_instance = lv_found_comp_detail-ibase.
    is_refobj-ib_ibase    = lv_found_comp_detail-instance.

    call method iv_1o_api->set_refobj
      exporting
        is_refobj         = is_refobj
      changing
        cv_log_handle     = cv_log_handle
      exceptions
        document_locked   = 1
        error_occurred    = 2
        no_authority      = 3
        no_change_allowed = 4
        others            = 5.
    if sy-subrc <> 0.
      "cs_cd-error_code = ''.
      "cs_cd-error_text = ''.
      "exit.
    endif.


  endmethod.


  METHOD set_log_db.
    DATA: lv_guid        TYPE crmt_object_guid,
          lt_cdhdr       TYPE TABLE OF cdhdr,
          lt_cdpos       TYPE TABLE OF cdpos,
          pv_aendnr      TYPE cdchangenr,
          returncode     TYPE inri-returncode,
          ls_cdpos       TYPE cdpos,
          lv_cdpos_key_n TYPE cdtabkey,
          lv_key_len     TYPE i,
          lv_guig_str    TYPE char32.

    lv_guid = iv_1o_api->get_guid( ).

    LOOP AT it_cdhdr INTO DATA(ls_cdhdr).
      ls_cdhdr-objectid = lv_guid.
      "see FG SCD_SM sub rutines.
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = '01'
          object                  = 'AENDBELEG'
        IMPORTING
          number                  = pv_aendnr
          returncode              = returncode
        EXCEPTIONS
          interval_not_found      = 1
          number_range_not_intern = 2
          object_not_found        = 3
          quantity_is_0           = 0
          quantity_is_not_1       = 0
          interval_overflow       = 0
          buffer_overflow         = 4
          OTHERS                  = 4.

      LOOP AT it_cdpos INTO ls_cdpos WHERE changenr = ls_cdhdr-changenr.
        CLEAR lv_cdpos_key_n.
        ls_cdpos-changenr = pv_aendnr.
        ls_cdpos-objectid = lv_guid.
        lv_key_len = strlen( ls_cdpos-tabkey ).
        lv_guig_str = lv_guid.
        CASE ls_cdpos-tabname.
          WHEN 'CRMA_CUSTOMER_H' OR 'CRMA_ACTIVITY_H'
            OR 'CRMA_SERVICE_H'  OR 'CRMA_ORDERADM_H'
            OR 'CRMA_SRV_REQ_H'  OR 'CRMA_PRICING'
            OR 'CRMA_BILLING'    OR 'CRMA_SALES'.
            IF ls_cdpos-tabkey IS NOT INITIAL.
              CONCATENATE sy-mandt lv_guig_str INTO lv_cdpos_key_n.
            ENDIF.
          WHEN 'CRMA_DATES'.
            CONCATENATE sy-mandt lv_guig_str ls_cdpos-tabkey+35 INTO lv_cdpos_key_n.
          WHEN 'CRMA_PARTNER'.
            DATA: ls_partner     TYPE crma_partner,
                  lv_guid22      TYPE sysuuid-c22,
                  lv_guid16      TYPE sysuuid_x,
                  lv_partner_fct TYPE crmt_partner_fct,
                  lv_bp          TYPE bu_partner.

            SEARCH ls_cdpos-tabkey FOR '@'.
            IF sy-subrc = 0 AND sy-fdpos > 0.
              lv_bp = ls_cdpos-tabkey(sy-fdpos).
              lv_key_len = sy-fdpos + 1.
              lv_partner_fct = ls_cdpos-tabkey+lv_key_len.
              CALL FUNCTION 'BBP_BUPA_GET_NUMBER'
                EXPORTING
                  partner           = lv_bp
                IMPORTING
                  ev_partner_guid   = lv_guid16
                EXCEPTIONS
                  partner_not_valid = 1
                  guid_not_valid    = 2
                  no_input          = 3
                  OTHERS            = 4.

              IF lv_guid16  IS NOT INITIAL.
                CALL FUNCTION 'GUID_CONVERT'
                  EXPORTING
                    iv_guid_x16            = lv_guid16
                  IMPORTING
                    ev_guid_c22            = lv_guid22
                  EXCEPTIONS
                    no_unicode_support_yet = 1
                    parameters_error       = 2
                    OTHERS                 = 3.
                IF sy-subrc <> 0.
                ENDIF.
                "3 mandant
                "22 Character GUID (Converted) for a CRM Object
                "8 Partner Function
                "32 Partner Number
                lv_guig_str = lv_guid16.
                CONCATENATE sy-mandt lv_guid22 lv_partner_fct lv_guig_str INTO lv_cdpos_key_n.
              ENDIF.
            ENDIF.
          WHEN 'CRMA_TEXT'.
            CONCATENATE sy-mandt ls_cdpos-tabkey+3(10) lv_guig_str INTO lv_cdpos_key_n.
          WHEN 'CRMA_SERVICE_OS'.
            CONCATENATE sy-mandt lv_guig_str ls_cdpos-tabkey+35 INTO lv_cdpos_key_n.
          WHEN 'CRMA_ORDERADM_I'.
            "CRMD_ORDERADM_I checklist data
            "since not migrated mapping 1 to 1
            SELECT SINGLE guid FROM crmd_orderadm_i
              WHERE header = @lv_guid INTO @DATA(lv_oitem_guid).
            IF lv_oitem_guid IS NOT INITIAL.
              lv_guig_str = lv_oitem_guid.
              CONCATENATE sy-mandt lv_guig_str INTO lv_cdpos_key_n.
            ENDIF.
          WHEN 'CRMA_SERVICE_I'.
            "todo lt_orderadm_i
            "since not migrated mapping 1 to 1
            SELECT SINGLE guid FROM crmd_orderadm_i
              WHERE header = @lv_guid
              AND object_type = 'BUS2000140' "to check
              INTO @DATA(lv_sitem_guid).
            IF lv_sitem_guid IS NOT INITIAL.
              lv_guig_str = lv_sitem_guid.
              CONCATENATE sy-mandt lv_guig_str INTO lv_cdpos_key_n.
            ENDIF.
          WHEN 'CRMA_APPROVAL_S'.
            DATA: lv_app_s_no TYPE crmt_step_no.
            SEARCH ls_cdpos-tabkey FOR '@'.
            IF sy-subrc = 0 AND sy-fdpos = 0.
              lv_app_s_no = ls_cdpos-tabkey+1.

              SELECT SINGLE app_s~guid FROM
                crmd_orderadm_h AS doc
                LEFT JOIN crmd_link AS link
                ON doc~guid = link~guid_hi AND objtype_set = '50'
                LEFT JOIN crmd_approval_s AS app_s
                ON app_s~parent_guid = link~guid_set
                WHERE doc~guid = @lv_guid AND app_s~step_no = @lv_app_s_no
                INTO @DATA(lv_app_s_guid).
              IF lv_app_s_guid IS NOT INITIAL.
                lv_guig_str = lv_app_s_guid.
                CONCATENATE sy-mandt lv_guig_str INTO lv_cdpos_key_n.
              ENDIF.
            ENDIF.
          WHEN 'CRMA_PRODUCT_I'.
            "not used, not moved
        ENDCASE.
        IF lv_cdpos_key_n IS NOT INITIAL.
          ls_cdpos-tabkey = lv_cdpos_key_n.
        ENDIF.
        SELECT SINGLE * FROM cdpos
          WHERE tabkey = @ls_cdpos-tabkey
          AND objectid = @ls_cdpos-objectid
          AND objectclas =  @ls_cdpos-objectclas
          AND tabname = @ls_cdpos-tabname
          AND fname = @ls_cdpos-fname
          AND text_case = @ls_cdpos-text_case
          AND unit_old = @ls_cdpos-unit_old
          AND unit_new = @ls_cdpos-unit_new
          AND cuky_old = @ls_cdpos-cuky_old
          AND cuky_new = @ls_cdpos-cuky_new
          AND value_new = @ls_cdpos-value_new
          AND value_old = @ls_cdpos-value_old
          AND _dataaging = @ls_cdpos-_dataaging
          INTO @DATA(ls_tmp).
        IF sy-subrc <> 0.
          APPEND ls_cdpos TO lt_cdpos.
        ENDIF.
      ENDLOOP.
      ls_cdhdr-changenr = pv_aendnr.
      IF lt_cdpos IS NOT INITIAL.
        APPEND ls_cdhdr TO lt_cdhdr.
      ENDIF.
    ENDLOOP.

    IF lt_cdhdr IS NOT INITIAL.
      MODIFY cdhdr FROM TABLE lt_cdhdr.
    ENDIF.
    IF lt_cdpos IS NOT INITIAL.
      MODIFY cdpos FROM TABLE lt_cdpos.
    ENDIF.

  ENDMETHOD.


  METHOD set_partners.
    LOOP AT lt_partner INTO DATA(ls_part).
      "remove current bp
      CALL FUNCTION 'SOCM_CRM_PA_DELETE_PARTNER'
        EXPORTING
          iv_guid_crm    = iv_1o_api->get_guid( )
          iv_save_mode   = ' '
          iv_partner_fct = ls_part-partner_fct.
    ENDLOOP.
    iv_1o_api->set_partners( EXPORTING it_partner = lt_partner ).

  ENDMETHOD.


  METHOD set_sla.
    DATA: lt_appointment TYPE crmt_appointment_comt,
          ls_work        TYPE crmt_appointment_wrk,
          ls_appointment TYPE crmt_appointment_com,
          lv_record_guid TYPE guid_16.

    LOOP AT et_appointment INTO ls_work.
      MOVE-CORRESPONDING ls_work TO ls_appointment.
      ls_appointment-ref_guid = iv_1o_api->get_guid( ).
      INSERT ls_appointment INTO TABLE lt_appointment.
    ENDLOOP.
    CALL METHOD iv_1o_api->set_appointments
      EXPORTING
        it_appointment    = lt_appointment
*        CHANGING
*       cv_log_handle     =
      EXCEPTIONS
        error_occurred    = 1
        document_locked   = 2
        no_change_allowed = 3
        no_authority      = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
*       Implement suitable error handling here
    ENDIF.

  ENDMETHOD.


  METHOD set_sla_db.
    DATA: lt_sla         TYPE TABLE OF crmd_srcl_h,
          ls_sla         TYPE crmd_srcl_h,
          lv_record_guid TYPE guid_16,
          lt_scapp       TYPE TABLE OF scapptseg,
          ls_scapp       TYPE scapptseg.

    LOOP AT et_sla_db INTO ls_sla.
      ls_sla-guid = iv_guid.
      CALL FUNCTION 'GUID_CREATE'
        IMPORTING
          ev_guid_16 = lv_record_guid.
      ls_sla-record  = lv_record_guid.
      APPEND ls_sla TO lt_sla.
    ENDLOOP.
    IF lt_sla IS NOT INITIAL.
      MODIFY crmd_srcl_h FROM TABLE lt_sla.
    ENDIF.

    SELECT SINGLE * FROM crmd_orderadm_i
    WHERE header = @iv_guid
    INTO @DATA(ls_sla_items).

    SELECT SINGLE guid_set
    FROM crmd_link
    WHERE guid_hi = @ls_sla_items-guid
    INTO @DATA(lv_item_guid).

    SELECT SINGLE guid_set
    FROM crmd_link
    WHERE guid_hi = @iv_guid
    INTO @DATA(lv_doc_guid).

    LOOP AT et_sla_db_2 INTO DATA(lv_sla_db_2).
      CLEAR ls_scapp.
      MOVE-CORRESPONDING lv_sla_db_2 TO ls_scapp.
      IF lv_sla_db_2-appl_guid = 'DOC'.
        ls_scapp-appl_guid = lv_doc_guid.
      ELSE.
        ls_scapp-appl_guid = lv_item_guid.
      ENDIF.
      IF ls_scapp-appl_guid IS NOT INITIAL.
        SELECT SINGLE * FROM scapptseg
          WHERE appl_guid = @ls_scapp-appl_guid
          AND appt_type = @ls_scapp-appt_type
          INTO @DATA(ls_scapptseg_t).
        IF sy-subrc = 0.
          ls_scapp-appt_guid = ls_scapptseg_t-appt_guid.
          ls_scapp-txt_pub_id = ls_scapptseg_t-txt_pub_id.
        ELSE.
          "see report RSSC_DEMO_CL_APPOINTMENT_APPL
          CALL FUNCTION 'GUID_CREATE'
            IMPORTING
              ev_guid_16 = ls_scapp-appt_guid.
        ENDIF.
        APPEND ls_scapp TO lt_scapp.
      ENDIF.
    ENDLOOP.

    IF lt_scapp IS NOT INITIAL.
      MODIFY scapptseg FROM TABLE lt_scapp.
    ENDIF.

  ENDMETHOD.


  METHOD set_soldoc.
    DATA:
      lv_smud_context     TYPE        smud_context_occ,
      ls_parameters       TYPE        ags_mk_s_param,
      lt_parameters       TYPE        ags_mk_tt_param,
      lv_smud_occurrences TYPE        zsmud_occurrence,
      lv_line             TYPE        i.

    LOOP AT it_occ_ids INTO lv_smud_occurrences.

      CLEAR: lv_smud_context, lt_parameters.
      CONCATENATE lv_smud_occurrences-occ_id lv_smud_occurrences-root_occ lv_smud_occurrences-scope_id "<fs_smud_occurrences>-show_inactive
      INTO lv_smud_context.

      ls_parameters-name = 'SMUD_CONTEXT'.
      ls_parameters-value = lv_smud_context.
      APPEND ls_parameters TO lt_parameters.

      lv_line = lv_line + 1.

      CALL METHOD cl_ags_crm_1o_api=>write_cache
        EXPORTING
          it_parameters = lt_parameters
          iv_guid       = iv_guid
          iv_line       = lv_line.

    ENDLOOP.
  ENDMETHOD.


  METHOD set_status.
*    DATA:
*      lv_status_u    TYPE crm_j_status,
*      lv_status_c    TYPE crm_j_status,
*      lt_status_com  TYPE crmt_status_comt,
*      ls_status_com  TYPE crmt_status_com,
*      lt_status      TYPE crmt_status_wrkt,
*      lt_stat_schema TYPE crm_j_stsma,
*      lv_stat_hist   TYPE LINE OF zstatus_tt_history.
*
*    DATA: ls_status_int         TYPE jstat.
*    DATA: lt_status_int         TYPE STANDARD TABLE OF jstat.
*
**check status
*    iv_1o_api->get_status(
*      IMPORTING
*        ev_user_status       = lv_status_u
*        et_status            = lt_status
*      EXCEPTIONS
*        document_not_found   = 1
*        error_occurred       = 2
*        document_locked      = 3
*        no_change_authority  = 4
*        no_display_authority = 5
*        no_change_allowed    = 6
*        OTHERS               = 7
*    ).
*    IF sy-subrc <> 0.
*    ENDIF.
*
*    READ TABLE lt_status INTO DATA(ls_status) WITH KEY status = lv_status_u. "#EC CI_SORTSEQ
*    MOVE-CORRESPONDING ls_status TO ls_status_com.
*
*    LOOP AT iv_status INTO lv_status_c.
*      IF lv_status_c(1) = 'E'. "set user statuses
*        IF lv_status_c <> lv_status_u.
*          ls_status_com-status = lv_status_c.
*
*          ls_status_com-ref_guid       = ls_status-guid.
*          ls_status_com-ref_kind       = 'A'.
*          ls_status_com-activate       = 'X'.
*
*          INSERT ls_status_com INTO TABLE lt_status_com.
*
*        ENDIF.
*      ELSE."set system status
*        READ TABLE lt_status INTO DATA(ls_status_sys) WITH KEY user_stat_proc = ''. "#EC CI_SORTSEQ
*        MOVE-CORRESPONDING ls_status_sys TO ls_status_com.
*        IF lv_status_c <> ls_status_com-status.
*          ls_status_int-inact = space.
*          ls_status_int-stat  = lv_status_c.
*          INSERT ls_status_int INTO TABLE lt_status_int.
*        ENDIF.
*      ENDIF.
*    ENDLOOP.
*
*    IF lt_status_com IS NOT INITIAL.
*      iv_1o_api->set_status(
*            EXPORTING
*              it_status         =     lt_status_com
*            EXCEPTIONS
*              document_locked   = 1
*              error_occurred    = 2
*              no_authority      = 3
*              no_change_allowed = 4
*              OTHERS            = 5
*          ).
*      IF sy-subrc <> 0.
*      ENDIF.
*    ENDIF.
*
*    IF lt_status_int IS NOT INITIAL.
*      CALL FUNCTION 'CRM_STATUS_CHANGE_INTERN'
*        EXPORTING
*          objnr               = ls_status-guid
*        TABLES
*          status              = lt_status_int
*        EXCEPTIONS
*          object_not_found    = 1
*          status_inconsistent = 2
*          status_not_allowed  = 3.
*      IF sy-subrc <> 0.
** Implement suitable error handling here
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD set_status_db.
    DATA: lv_stat_hist  TYPE LINE OF zstatus_tt_history,
          lv_table      TYPE TABLE OF crm_jcds,
          lv_stat_db    TYPE crm_jest,
          lv_table_stat TYPE TABLE OF crm_jest.

    LOOP AT iv_status_hist INTO lv_stat_hist.
      lv_stat_hist-objnr = iv_guid.
      APPEND lv_stat_hist TO lv_table.
    ENDLOOP.
    DELETE FROM crm_jcds WHERE objnr = iv_guid.
    MODIFY crm_jcds FROM TABLE lv_table.

    LOOP AT iv_status_db INTO lv_stat_db.
      lv_stat_db-objnr = iv_guid.
      APPEND lv_stat_db TO lv_table_stat.
    ENDLOOP.
    DELETE FROM crm_jest WHERE objnr = iv_guid.
    MODIFY crm_jest FROM TABLE lv_table_stat.

  ENDMETHOD.


  METHOD set_texts.

    INCLUDE crm_mode_con.
    INCLUDE crm_object_names_con.
    INCLUDE crm_object_kinds_con.

    DATA lt_textdata TYPE STANDARD TABLE OF comt_text_textdata.
    DATA lt_text_com TYPE crmt_text_comt.
    DATA ls_text_com TYPE crmt_text_com.
    DATA lr_text_gen TYPE REF TO crmt_text_gen_ext_tab.
    DATA lt_textdata_gen TYPE crmt_text_gen_ext_tab.
    DATA lo_text_gen_util TYPE REF TO cl_crm_text_gen_txtformat_util.
    DATA lt_extension2 TYPE crmt_extension2_comt.
    DATA ls_extension2 TYPE crmt_extension2_com.
    DATA lv_text_html TYPE crm_text_gen_content.
    DATA lt_text_gen_com TYPE crmt_text_gen_ext_tab.
    DATA lv_target_tdid TYPE crm_text_gen_text_id.
    DATA lt_textid TYPE TABLE OF crm_text_gen_text_id.
    DATA lv_skip TYPE boolean.
    FIELD-SYMBOLS:  <lt_text_gen> TYPE crmt_text_gen_ext_tab.

    "First check if text already set (this chek can be removed or enhanced)
    DATA:
      lt_text_all	    TYPE comt_text_textdata_t.

    iv_1o_api->get_texts(
      IMPORTING
            et_text_all = lt_text_all
            et_text_gen = lt_textdata_gen ).

    IF lt_text_all IS INITIAL AND lt_textdata_gen IS INITIAL.
      CLEAR: lt_textdata_gen, lt_text_all.

      "HTML texts
      LOOP AT it_textdata_gen INTO DATA(ls_textdata_gen).
        ls_textdata_gen-rel_object_guid = iv_guid.
        CLEAR: ls_textdata_gen-guid.
        ls_textdata_gen-mode = 'A'.
        CLEAR: ls_textdata_gen-text_content_plain.
        INSERT ls_textdata_gen INTO TABLE lt_text_gen_com.
        APPEND ls_textdata_gen-text_id  TO lt_textid. "will not process ITF texts if text was processed as HTML
      ENDLOOP.

      "ITF texts
      LOOP AT it_textdata INTO DATA(ls_textdata)
        GROUP BY ( tdid = ls_textdata-stxh-tdid ) ASCENDING ASSIGNING FIELD-SYMBOL(<text_grp>).

        CLEAR lt_textdata.

        " Collect all text ids with the same target text id
        LOOP AT GROUP <text_grp> ASSIGNING FIELD-SYMBOL(<text>).
          lv_skip = 0.
          LOOP AT lt_textid INTO DATA(lv_tdid).
            IF lv_tdid = <text>-stxh-tdid.
              " do not process text texts types which was processed as html
              lv_skip = 1.
              EXIT.
            ENDIF.
          ENDLOOP.
          IF lv_skip = 1.
            CONTINUE.
          ENDIF.
          " Change target TDID with source TDID for building the text log
          ls_textdata           = <text>.
          lv_target_tdid        = <text>-stxh-tdid.
          ls_textdata-stxh-tdid = <text>-stxh-tdrefid.
          APPEND ls_textdata TO lt_textdata.
        ENDLOOP.

        IF lt_textdata IS NOT INITIAL.
          cl_im_ai_crm_copy_badi=>crm_orderh_text_write_api(
            EXPORTING
              iv_procedure = iv_text_proc
            CHANGING
              ct_textdata  = lt_textdata ).

          LOOP AT lt_textdata INTO ls_textdata.
            CLEAR ls_text_com.
            MOVE-CORRESPONDING ls_textdata-stxh TO ls_text_com.

            ls_text_com-ref_guid    = iv_guid.
            ls_text_com-ref_kind    = gc_object_kind-orderadm_h.
            ls_text_com-tdid        = lv_target_tdid.
            ls_text_com-ext-tdspras = sy-langu.
            ls_text_com-lines       = ls_textdata-lines.
            ls_text_com-mode        = gc_mode-change.
            INSERT ls_text_com INTO TABLE lt_text_com.
          ENDLOOP.
        ENDIF.
      ENDLOOP.

      " Maintain HTML text
      IF lt_text_gen_com IS NOT INITIAL.
        " Create a Data reference to the structure of the Generic Table and
        " assign it to the Extension2 data component
        CREATE DATA lr_text_gen TYPE crmt_text_gen_ext_tab.
        ls_extension2-data = lr_text_gen.

        " De-reference the Data reference
        ASSIGN lr_text_gen->* TO <lt_text_gen>.

        " Now fill in the data into the Extension2 table.
        ls_extension2-object = if_crm_text_gen_constants=>gc_object_name.
        ls_extension2-ref_guid =  iv_guid.
        ls_extension2-ref_kind = gc_object_kind-orderadm_h.
        INSERT ls_extension2 INTO TABLE lt_extension2.

        <lt_text_gen> = lt_text_gen_com.

        cl_crm_component=>get_instance(
          EXPORTING
            iv_object_name = if_crm_text_gen_constants=>gc_object_name
          IMPORTING
            ev_instance    = DATA(lo_component) ).

        IF lo_component IS NOT INITIAL.
          LOOP AT lt_extension2 INTO ls_extension2.
            ASSIGN ls_extension2-data->* TO FIELD-SYMBOL(<lt_data>).

            DATA(lt_input_fields) = VALUE crmt_input_field_tab( ( ref_guid    = iv_guid
                                                                  ref_kind    = gc_object_kind-orderadm_h
                                                                  objectname  = if_crm_text_gen_constants=>gc_object_name
                                                                  field_names = VALUE crmt_input_field_names_tab( ( fieldname = 'TEXT_CONTENT' ) )
                                                                ) ).
            "maintain HTML text
            CALL METHOD lo_component->maintain
              EXPORTING
                iv_ref_kind      = 'A'
                iv_ref_guid      = iv_guid
                is_data          = <lt_data>
                iv_external_call = abap_true
              CHANGING
                ct_input_fields  = lt_input_fields.

            CLEAR: lt_input_fields.
          ENDLOOP.
        ENDIF.
      ENDIF.
      " Maintain ITF text
      IF lt_text_com IS NOT INITIAL.

        DATA(ls_input_field_name) = VALUE crmt_input_field_names( fieldname = 'LINES' ).
        DATA(lt_input_field_names) = VALUE crmt_input_field_names_tab( ( ls_input_field_name ) ).

        "Update the text
        CALL FUNCTION 'CRM_TEXT_MAINTAIN_OW'
          EXPORTING
            it_text                  = lt_text_com
            iv_object_guid           = iv_guid
            iv_object_kind           = gc_object_kind-orderadm_h
            iv_textobject            = 'CRM_ORDERH'
          CHANGING
            ct_input_field_names     = lt_input_field_names
          EXCEPTIONS
            object_kind_unknown      = 0
            read_error_object_buffer = 0
            OTHERS                   = 0.

      ENDIF.

    ELSE.
      ev_message = 'Texts exist, skipping seting texts.'.
    ENDIF.

  ENDMETHOD.


  METHOD set_tr_db.
    "just update TABLE /tmwflow/trord_n
    "(no changes in the managed system)
    DATA: ls_transport    TYPE ztr_data_st,
          lt_trordhc      TYPE /tmwflow/trordhc_t,
          ls_trordhc      TYPE /tmwflow/trordhc_s,
          ls_logic_system TYPE /tmwflow/logical_system,
          lv_message      TYPE tdline.
    "Prepare missing information for the transport
    SELECT SINGLE * FROM tsocm_cr_context INTO @DATA(lv_context)
    WHERE guid = @iv_guid AND item_guid = @iv_guid .

    SELECT SINGLE * FROM aic_release_cycl INTO @DATA(lv_rel)
    WHERE smi_project = @lv_context-project_id.

    LOOP AT iv_transports INTO ls_transport.
      SELECT COUNT(*) INTO @DATA(lv_tr) FROM /tmwflow/trord_n WHERE trorder_number = @ls_transport-trorder_number.
      IF lv_tr > 0.
        "transport already assigned.
        "can be deleted with FM /TMWFLOW/TS_DELETE_TRORDER_HDR
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
        RAISING error_tr_already_registered.
        CONTINUE.
      ENDIF.

      "Assigne tr (without checks)
      "how to do in a correct way see i.e.:
      "in /SALM/CL_CRMUI5_SERVICE_DATA->DO_ASSIGN_TRANSPORT_REQS
      "we do this in direct way, without any checks
      "update ChaRM database table from 'FM /TMWFLOW/REGISTER_TR_TO_TL')

      SELECT SINGLE * FROM /tmwflow/ttrckhn INTO @DATA(ls_track_hdr)
        WHERE tasklist = @lv_rel-tasklist_id
        AND status   = @/tmwflow/cl_constants=>con_config_stat-active
        AND src_sys_name = @ls_transport-sys_name
        AND src_sys_type = @ls_transport-sys_type
        AND src_sys_client = @ls_transport-sys_client.

      SELECT SINGLE * FROM /tmwflow/projman INTO @DATA(ls_projman)
      WHERE tasklist = @lv_rel-tasklist_id
      AND status   = @/tmwflow/cl_constants=>con_config_stat-active
      AND src_sys_name = @ls_transport-sys_name
      AND src_sys_type = @ls_transport-sys_type
      AND src_sys_client = @ls_transport-sys_client.

      MOVE-CORRESPONDING ls_transport TO ls_trordhc.
      " !but we are not changing CTS_IT = Inconsistancy
      IF ls_projman IS NOT INITIAL.
        ls_trordhc-cts_id = ls_projman-cts_id.
      ENDIF.
      ls_trordhc-tasklist = lv_rel-tasklist_id.
      IF ls_track_hdr IS NOT INITIAL.
        " !possible inconsistance if system not in the cycle
        ls_trordhc-transport_track = ls_track_hdr-transport_track.
      ENDIF.
      ls_trordhc-originator_id = iv_guid.
      ls_trordhc-originator_key = iv_change_id.
      ls_trordhc-project_name = lv_context-project_id.
      ls_trordhc-smi_project = lv_context-project_id.
      APPEND ls_trordhc TO lt_trordhc.
    ENDLOOP.

    CALL FUNCTION '/TMWFLOW/TS_UPDATE_TRORDER_HDR'
      EXPORTING
        it_trordhc    = lt_trordhc
      EXCEPTIONS
        update_failed = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      MESSAGE    e177(/tmwflow/tasklist)           "error writing table
         WITH    '/TMWFLOW/TRORD_N'
         RAISING error_tr_not_added.
    ENDIF.

    IF iv_tr_move IS NOT INITIAL.
      "move unreleased tr to the new CTS id
      "refer to /TMWFLOW/IF_COMMON_TRANSPORT~CREATE_TR
      CALL METHOD zcl_solmove_helper=>assign_tr
        EXPORTING
          it_trorders = lt_trordhc
        IMPORTING
          ev_message  = lv_message.
      IF lv_message IS NOT INITIAL.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
        RAISING error_tr_not_changed_in_mnged.
      ENDIF.

    ENDIF.

  ENDMETHOD.


  METHOD set_webui_fields.

    "Record Customer_h fields
    DATA: ls_customer_h     TYPE crmt_customer_h_com,
          ls_orderadm_h     TYPE crmt_orderadm_h_wrk,
          ls_customer_h_old TYPE crmt_customer_h_wrk,
          ls_fields         TYPE zcustom_fields,
          lv_test           TYPE char32,
          fldname           TYPE fieldname.


    FIELD-SYMBOLS:
    <fld> TYPE any.

    iv_1o_api->get_customer_h( IMPORTING es_customer_h = ls_customer_h_old ).
    iv_1o_api->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h ).

    ls_customer_h-ref_guid = ls_orderadm_h-guid.

    LOOP AT ev_custom_fields INTO ls_fields.
      IF ls_fields-target_table = 'CUSTOMER_H'.
        CONCATENATE 'ls_customer_h-' ls_fields-target_field INTO fldname.
        ASSIGN (fldname) TO <fld>.
        CONDENSE ls_fields-value.
        <fld> = ls_fields-value.
        "ls_customer_h-ls_fields-target_field = ls_fields-value.
      ENDIF.
    ENDLOOP.

    iv_1o_api->set_customer_h( EXPORTING is_customer_h = ls_customer_h
      EXCEPTIONS
        error_occurred    = 1
        document_locked   = 2
        no_change_allowed = 3
        no_authority      = 4
        OTHERS            = 5 ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
        RAISING error_customer_header.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

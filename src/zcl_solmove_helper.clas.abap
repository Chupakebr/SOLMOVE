class ZCL_SOLMOVE_HELPER definition
  public
  final
  create public .

public section.

  class-methods CREATE_BP
    importing
      !IV_BP_DATA type ZBP_DATA
    exporting
      !EV_MESSAGE type ZPROCESS_LOG_TT
      !EV_PARTNER type BU_PARTNER .
  class-methods FIND_DOC
    importing
      !IV_DOC_ID type ZCUSTOM_FIELDS
      !IV_TYPE type CRMT_PROCESS_TYPE
    exporting
      !EV_GUID type CRMT_OBJECT_GUID
    exceptions
      ERROR_MAPPING .
  class-methods GET_DOC_DATA
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !LT_DOC_PROPERTIES type ZDOC_PROPS_STRUCT
    exceptions
      ERROR_READ_DOC
      ERROR_GET_ATTACHMENTS
      ERROR_NO_TARGET_TTYPE .
  class-methods CREATE_DOC
    importing
      !IV_DOCUMENTPROPS type ZDOC_PROPS_STRUCT
    exporting
      !EV_MESSAGE type ZPROCESS_LOG_TT .
  class-methods GET_STATUS
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_STATUS type ZSTATUS_TT .
  class-methods GET_TR
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_TRANSPORTS type ZTRANSPORTS_TT .
  class-methods SET_TR
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_TRANSPORTS type ZTRANSPORTS_TT
      !IV_CHANGE_ID type CRMT_OBJECT_ID
    exceptions
      ERROR_TR_ALREADY_REGISTERED
      ERROR_TR_NOT_ADDED .
  class-methods GET_PARTNERS
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !LT_PARTNER type COMT_PARTNER_COMT .
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
      !EV_IBASE type COMT_PRODUCT_ID .
  class-methods GET_CYCLE
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_CYCLE type CRMT_OBJECT_ID_DB .
  class-methods GET_JCDS
    importing
      !IV_GUID type CRMT_OBJECT_GUID
    exporting
      !EV_STATUS type ZSTATUS_TT_HISTORY .
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
    exporting
      !EV_MESSAGE type TDLINE .
  class-methods SET_SOLDOC
    importing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !IV_SMUD_T type SMUD_T_GUID22 .
  class-methods SET_STATUS
    importing
      !IV_STATUS type ZSTATUS_TT
      !IV_STATUS_HIST type ZSTATUS_TT_HISTORY
    changing
      !IV_1O_API type ref to CL_AGS_CRM_1O_API .
  class-methods GET_TYPE
    importing
      !IV_TYPE type CRMT_PROCESS_TYPE
    exporting
      !EV_TYPE type CRMT_PROCESS_TYPE .
  class-methods GET_ATTACHMENTS
    importing
      !IV_ATTACHMENT_LIST type AGS_T_CRM_ATTACHMENT
    exporting
      !EV_ATTACHMENTS type ZATTACHMENT_TT .
  class-methods SET_CREATION_INFO
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_DOC_PROPERTIES type ZDOC_PROPS_STRUCT .
  class-methods GET_CATEGORIES
    importing
      !IV_GUID type CRMT_OBJECT_GUID
      !IV_CATALOG_TYPE type CRMT_CATALOGTYPE optional
    exporting
      !RT_RESULT type CRMT_ERMS_CAT_CA_LANG_TAB .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SOLMOVE_HELPER IMPLEMENTATION.


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
          lv_message    TYPE tdline.

    IF iv_documentprops-update IS NOT INITIAL.
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
          lv_message = 'Error: Could not read created Document.'.
        ELSE.
          lv_message = 'Document found, updating.'.
        ENDIF.
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
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.

    IF lo_cd IS NOT BOUND.
      lv_message = 'Error: Could not initialize document. Process stoped.'.
      APPEND lv_message TO ev_message.
      EXIT.
    ENDIF.
    "get guid of the created document
    lo_cd->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h ).

    "set description
    lo_cd->set_short_text( EXPORTING iv_short_text = iv_documentprops-description ).

    "set priority
    IF iv_documentprops-priority IS NOT INITIAL.
      lo_cd->set_priority( EXPORTING iv_priority = iv_documentprops-priority ).
    ENDIF.

    "set category
    IF iv_documentprops-category IS NOT INITIAL.
      lo_cd->set_category( EXPORTING iv_category = iv_documentprops-category ).
    ENDIF.

    "set soldoc data
    IF iv_documentprops-occ_ids IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>set_soldoc
        EXPORTING
          iv_1o_api = lo_cd
          iv_smud_t = iv_documentprops-occ_ids.
    ENDIF.

    " add attachments
    IF iv_documentprops-attach_list IS NOT INITIAL.
      DATA: lt_object_type TYPE sibftypeid.
      lt_object_type = ls_orderadm_h-object_type.

      CALL METHOD zcl_solmove_helper=>set_attachments
        EXPORTING
          iv_guid        = ls_orderadm_h-guid
          iv_object_type = lt_object_type
          iv_attach_list = iv_documentprops-attach_list.
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

      "set transports
      IF iv_documentprops-transports IS NOT INITIAL.
        CALL METHOD zcl_solmove_helper=>set_tr
          EXPORTING
            iv_guid                     = ls_orderadm_h-guid
            iv_transports               = iv_documentprops-transports
            iv_change_id                = ls_orderadm_h-object_id
          EXCEPTIONS
            error_tr_already_registered = 1
            error_tr_not_added          = 2
            OTHERS                      = 3.
        IF sy-subrc <> 0.
          CASE sy-subrc.
            WHEN 1.
              lv_message = 'Error: Transports already mapped in target system'.
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
        lv_message = 'Error: Could not set document webui fields'.
        APPEND lv_message TO ev_message.
      ENDIF.
    ENDIF.

    "set partners. This call is enough. Additional fields will be picked inside method set_partners
    IF iv_documentprops-partners IS NOT INITIAL.
      lo_cd->set_partners( EXPORTING it_partner = iv_documentprops-partners ).
    ENDIF.



    "set status
    " !status set should be the last action to allow other changes for closed document!
    IF iv_documentprops-status IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>set_status
        EXPORTING
          iv_status = iv_documentprops-status
          iv_status_hist = iv_documentprops-stat_hist_table
        CHANGING
          iv_1o_api = lo_cd.
    ENDIF.
    " !status set should be the last action to allow other changes for closed document!

*    record document and return solution manager id and solution manager guid
    lo_cd->save( CHANGING cv_log_handle = lv_log_handle ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 INTO lv_message.
      APPEND lv_message TO ev_message.
    ENDIF.

    COMMIT WORK.

    "update creation information
    CALL METHOD zcl_solmove_helper=>set_creation_info
      EXPORTING
        iv_guid           = lo_cd->get_guid( )
        iv_doc_properties = iv_documentprops.


*    Check if document was created?
    lo_cd->get_orderadm_h( IMPORTING es_orderadm_h = ls_orderadm_h ).

    CONCATENATE 'Document:' ls_orderadm_h-object_id 'processed in target.' INTO lv_message SEPARATED BY space.
    APPEND lv_message TO ev_message.

  ENDMETHOD.


  METHOD find_doc.
    DATA: cond_syntax TYPE string,
          fldname     TYPE fieldname,
          oref        TYPE REF TO cx_root,
          text        TYPE string.

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
  ENDMETHOD.


  method get_attachments.

    data: ls_phio                type skwf_io,
          lt_file_access_info    type sdokfilacis,
          lt_file_content_ascii  type sdokcntascs,
          lt_file_content_binary type sdokcntbins,
          ls_attachments         type zattachment.


*     get attachments
    if iv_attachment_list is not initial.

      loop at iv_attachment_list into data(ls_attachment_list).

        clear: ls_phio, lt_file_access_info, lt_file_content_ascii, lt_file_content_binary, ls_attachments.

        ls_phio-objtype = 'P'.
        ls_phio-class = 'CRM_P_ORD'.
        ls_phio-objid = ls_attachment_list-docid.

        call method cl_crm_documents=>get_with_table
          exporting
            phio                = ls_phio
            raw_mode            = abap_true
          importing
            file_access_info    = lt_file_access_info
            file_content_ascii  = lt_file_content_ascii
            file_content_binary = lt_file_content_binary
            error               = data(lt_errors)
            bad_ios             = data(lt_bad_files).

        ls_attachments-phio = ls_phio.
        ls_attachments-file_access_info = lt_file_access_info.
        ls_attachments-file_content_ascii = lt_file_content_ascii.
        ls_attachments-file_content_binary = lt_file_content_binary.

        append ls_attachments to ev_attachments.

      endloop.

    endif.


  endmethod.


  METHOD get_categories.
* low level function for debugging: crm_erms_cat_ca_read + crm_erms_cat_as_read.

    TYPES :
      tt_category TYPE  TABLE  OF  REF  TO if_crm_erms_catego_category.

    DATA :
      li_aspect     TYPE  REF  TO if_crm_erms_catego_aspect,
      li_category   TYPE  REF  TO if_crm_erms_catego_category,
      lr_categories TYPE  REF  TO data,
      ls_cat_lang   TYPE crmt_erms_cat_ca_lang.

    FIELD-SYMBOLS:
      <ft_category> TYPE tt_category,
      <fi_category> LIKE li_category.

* Ensure valid result.
    REFRESH rt_result[].

* Get Assigned Categorys.
    CALL METHOD cl_crm_ml_category_util=>get_categoryfirst
      EXPORTING
        iv_ref_guid     = iv_guid
        iv_ref_kind     = 'A'
        iv_catalog_type = iv_catalog_type
      IMPORTING
        er_aspect       = li_aspect
        er_category     = li_category.

    CHECK li_aspect IS  BOUND  AND li_category IS  BOUND .

* Get All Parent Nodes.
    CALL METHOD cl_crm_ml_category_util=>get_cat_pars_all
      EXPORTING
        ir_aspect     = li_aspect
        ir_category   = li_category
      IMPORTING
        er_categories = lr_categories.

    CHECK lr_categories IS  BOUND .

    ASSIGN lr_categories->* TO <ft_category>.

* Don't forget our assigned category.
    INSERT li_category INTO <ft_category> INDEX 1.

    LOOP  AT <ft_category> ASSIGNING <fi_category>.

* Get Category Details.
      CALL METHOD <fi_category>->get_details
* EXPORTING
* iv_auth_check = ''
        IMPORTING
*         ev_cat      = ls_cat
          ev_cat_lang = ls_cat_lang.

* Ensure that description is filled.
      IF ls_cat_lang-cat_desc IS  INITIAL .
        ls_cat_lang-cat_desc = ls_cat_lang-cat_labl.
      ENDIF .

      IF ls_cat_lang-cat_desc IS  INITIAL .
        ls_cat_lang-cat_desc = ls_cat_lang-cat-cat_id.
      ENDIF .

* Transfer Result
      INSERT ls_cat_lang INTO rt_result[] INDEX 1.

    ENDLOOP .
  ENDMETHOD.


  method get_cycle.
    data lv_source type zsolmove_source.

    select single release_crm_id into @ev_cycle
      from tsocm_cr_context as cont
      left join aic_release_cycl as cycl on cont~project_id = cycl~smi_project
    where created_guid = @iv_guid and release_crm_id is not null.

    lv_source = ev_cycle.

    select single target into @data(lv_target) from zsolmove_mapping
      where source = @lv_source and type = 'CYCLE'.

    ev_cycle = lv_target.

  endmethod.


  METHOD get_doc_data.

    DATA: lo_api_object       TYPE REF TO cl_ags_crm_1o_api,
          ls_orderadm_h       TYPE crmt_orderadm_h_wrk,
          lv_type             TYPE crmt_process_type,
          ls_occ_ids          TYPE LINE OF smud_t_guid22,
          lt_occ_ids          TYPE smud_t_guid22,
          ls_status           TYPE crmt_status_wrkt,
          lt_smud_occurrences TYPE cl_ags_crm_1o_api=>tt_smud_occurrence,
          lt_attachment_list  TYPE ags_t_crm_attachment,
          lt_partner_wrkt     TYPE crmt_partner_external_wrkt,
          lt_partner          TYPE comt_partner_comt.

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

    "save document guid, just for history
    lt_doc_properties-object_id-value = ls_orderadm_h-GUID.
    SELECT SINGLE sub_type, target FROM zsolmove_mapping WHERE type = 'GUID'
      INTO (@lt_doc_properties-object_id-target_table, @lt_doc_properties-object_id-target_field).

    "get all statuses of the document
    CALL METHOD zcl_solmove_helper=>get_status
      EXPORTING
        iv_guid   = iv_guid
      IMPORTING
        ev_status = lt_doc_properties-status.

    "get hist statuses of the document
    CALL METHOD zcl_solmove_helper=>get_jcds
      EXPORTING
        iv_guid   = iv_guid
      IMPORTING
        ev_status = lt_doc_properties-stat_hist_table.

    "get occ_ids
    lo_api_object->get_smud_occurrences(
      IMPORTING
        et_smud_occurrences = lt_smud_occurrences ).

    IF lt_smud_occurrences IS NOT INITIAL.
      LOOP AT lt_smud_occurrences INTO DATA(ls_smud_ids).
        ls_occ_ids = ls_smud_ids-occ_id.
        APPEND ls_occ_ids TO lt_occ_ids.
      ENDLOOP.
    ENDIF.
    lt_doc_properties-occ_ids = lt_occ_ids.

    " get attachments
    lo_api_object->get_attachment_list( IMPORTING et_attach_list = lt_attachment_list ).
    IF lt_attachment_list IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>get_attachments
        EXPORTING
          iv_attachment_list = lt_attachment_list
        IMPORTING
          ev_attachments     = lt_doc_properties-attach_list.
    ENDIF.

    "get i-base
    lo_api_object->get_ibase( IMPORTING es_refobj = DATA(lv_refobj) ) .
    IF lv_refobj IS NOT INITIAL.
      CALL METHOD zcl_solmove_helper=>get_ibase
        EXPORTING
          iv_ibase = lv_refobj-product_id
        IMPORTING
          ev_ibase = lt_doc_properties-ibase.
    ENDIF.

    " get change cycle
    CALL METHOD zcl_solmove_helper=>get_cycle
      EXPORTING
        iv_guid  = iv_guid
      IMPORTING
        ev_cycle = lt_doc_properties-cycle.

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

    "get partners
    CALL METHOD zcl_solmove_helper=>get_partners
      EXPORTING
        iv_1o_api  = lo_api_object
      IMPORTING
        lt_partner = lt_doc_properties-partners.

    "get multi level categories
    CALL METHOD zcl_solmove_helper=>get_categories
      EXPORTING
        iv_guid   = iv_guid
      IMPORTING
        rt_result = lt_doc_properties-categories.

  ENDMETHOD.


  method get_ibase.
    data lv_source_ibase type zsolmove_source.
    lv_source_ibase = iv_ibase.
    select single target into @data(lv_ibase) from zsolmove_mapping
      where source = @lv_source_ibase
      and type = 'IBASE'.
    ev_ibase = lv_ibase.
  endmethod.


  method GET_JCDS.
    data lv_stat type line of zstatus_tt_history.

    select single stat, chgnr, usnam, udate, utime from crm_jcds where objnr = @iv_guid
      into (@lv_stat-stat, @lv_stat-chgnr, @lv_stat-usnam, @lv_stat-udate, @lv_stat-utime).  "system status

    append lv_stat to ev_status.
  endmethod.


  method GET_PARTNERS.

    data: lt_partner_wrkt     type crmt_partner_external_wrkt,
          ls_partner          type comt_partner_com.

    call method iv_1o_api->get_partners
      importing
        et_partner           = lt_partner_wrkt
      exceptions
        document_not_found   = 1
        error_occurred       = 2
        document_locked      = 3
        no_change_authority  = 4
        no_display_authority = 5
        no_change_allowed    = 6
        others               = 7.

    if lt_partner_wrkt is not initial.
      loop at lt_partner_wrkt into data(ls_partner_wrk).
        select single target from zsolmove_mapping where source eq @ls_partner_wrk-ref_partner_no into @data(target_partner_no).
        if sy-subrc = 0.
          ls_partner-partner_fct    = ls_partner_wrk-ref_partner_fct.
          ls_partner-no_type        = ls_partner_wrk-ref_no_type.
          ls_partner-partner_no     = target_partner_no.
          ls_partner-display_type   = ls_partner_wrk-ref_display_type.
        endif.
        insert ls_partner into table lt_partner.
        clear ls_partner.
      endloop.
    endif.


  endmethod.


  method get_status.
    data lv_stat type crm_j_status.

    select stat from crm_jest into (@lv_stat) "system status
      where inact = '' and objnr = @iv_guid.
      append lv_stat to ev_status.
    endselect.

  endmethod.


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


  method get_type.
    data lv_source_type type zsolmove_source.
    lv_source_type = iv_type.
    select single target into @data(lv_type) from zsolmove_mapping
      where source = @lv_source_type
      and TYPE = 'TYPE'.
    ev_type = lv_type.
  endmethod.


  method get_webui_fields.

    data: ls_customer_h  type crmt_customer_h_wrk.
    data: ls_orderadm_h  type crmt_orderadm_h_wrk.
    data: ls_custom_line type zcustom_fields.
    data: lv_source       type zsolmove_source.
    data: lv_sub_type    type zsolmove_param.
    data: fldname        type fieldname.

    field-symbols: <fld> type any.

    "get header data
    iv_1o_api->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

    " get customer header
    iv_1o_api->get_customer_h( importing es_customer_h = ls_customer_h ).

    "save customer_h fields that was mapped
    select source, target from zsolmove_mapping where type = 'FILD' and sub_type = 'CUSTOMER_H'
      into (@lv_source, @ls_custom_line-target_field).
      ls_custom_line-target_table = 'CUSTOMER_H'.
      concatenate 'ls_customer_h-' lv_source into fldname.
      assign (fldname) to <fld>.
      ls_custom_line-value = <fld>.
      if ls_custom_line-value is not initial.
        append ls_custom_line to ev_custom_fields.
      endif.
    endselect.
    "add other custom tables if requiered....

    "get additional data (old document id) to custom fields in target system
    select sub_type, target from zsolmove_mapping where type = 'ID'
      into (@lv_sub_type, @ls_custom_line-target_field).

      if lv_sub_type = 'CUSTOMER_H'.
        ls_custom_line-target_table = 'CUSTOMER_H'.
        ls_custom_line-value = ls_orderadm_h-object_id.
        "add other custom tables if requiered....
      endif.

      if ls_custom_line-value is not initial.
        append ls_custom_line to ev_custom_fields.
      endif.

    endselect.


  endmethod.


  method set_attachments.

    data: ls_attachment       type  zattachment,
          ls_bo               type  sibflporb,
          lt_file_err         type  skwf_error,
          ls_loio             type  skwf_io,
          ls_phio             type  skwf_io,
          lt_attachment_props type  sdokproptys,
          ls_attachment_props like  line of lt_attachment_props.

    ls_bo-instid = iv_guid.
    ls_bo-typeid = IV_OBJECT_TYPE.
    ls_bo-catid = 'BO'. " ! Change

    loop at iv_attach_list into ls_attachment.

      clear: lt_file_err, lt_attachment_props, ls_attachment_props.

      ls_attachment_props-name = 'FILE_NAME'.
      ls_attachment_props-value = ls_attachment-file_access_info[ 1 ]-file_name.
      append ls_attachment_props to lt_attachment_props.

      ls_attachment_props-name = 'TECHN_FILE_NAME'.
      ls_attachment_props-value = ls_attachment-file_access_info[ 1 ]-file_name.
      append ls_attachment_props to lt_attachment_props.

      ls_attachment_props-name = 'DESCRIPTION'.
      ls_attachment_props-value = ls_attachment-file_access_info[ 1 ]-file_name.
      append ls_attachment_props to lt_attachment_props.

      ls_attachment_props-name = 'KW_RELATIVE_URL'.
      ls_attachment_props-value = ls_attachment-file_access_info[ 1 ]-file_name.
      append ls_attachment_props to lt_attachment_props.

      ls_attachment_props-name = 'LANGUAGE'.
      ls_attachment_props-value = sy-langu.
      append ls_attachment_props to lt_attachment_props.


      call method cl_crm_documents=>create_with_table
        exporting
          business_object     = ls_bo
          properties          = lt_attachment_props
          file_access_info    = ls_attachment-file_access_info
          file_content_binary = ls_attachment-file_content_binary
*         file_content_ascii  = ls_attachment-file_content_ascii
        importing
          loio                = ls_loio
          phio                = ls_phio
          error               = lt_file_err.

      if lt_file_err is not initial.
        concatenate 'Attachment creation failed,' lt_file_err-no lt_file_err-v1 into ev_message separated by space.
        continue.
      endif.
    endloop.

  endmethod.


  METHOD set_creation_info.

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


  method set_soldoc.

    data:
      lv_smud_occ type smud_context_occ,
      lv_root_occ type smud_guid22.

    "set smud context
    loop at iv_smud_t into data(ls_occ_id).
      lv_smud_occ(22) = ls_occ_id.

      " get root occ
      select single root_occ from smud_node where occ_id = @ls_occ_id into @lv_root_occ.

      iv_1o_api->set_smud_context_occ(
              exporting
                iv_smud_context_occ = conv #( lv_smud_occ && lv_root_occ )
                iv_sbom_type        = cl_ags_crm_smud_util=>cs_sbom_type-cd
              exceptions
                invalid_parameters  = 1
                others              = 2 ).

      iv_1o_api->save_smud_occurrences(
      exceptions
        error_occurred = 1
        others         = 2 ).

      if sy-subrc <> 0.
      endif.
    endloop.

  endmethod.


  method set_status.
    data:
      lv_status_u    type crm_j_status,
      lv_status_c    type crm_j_status,
      lt_status_com  type crmt_status_comt,
      ls_status_com  type crmt_status_com,
      lt_status      type crmt_status_wrkt,
      lt_stat_schema type crm_j_stsma,
      lv_stat_hist   type line of zstatus_tt_history.

    data: ls_status_int         type jstat.
    data: lt_status_int         type standard table of jstat.

*check status
    iv_1o_api->get_status(
      importing
        ev_user_status       = lv_status_u
        et_status            = lt_status
      exceptions
        document_not_found   = 1
        error_occurred       = 2
        document_locked      = 3
        no_change_authority  = 4
        no_display_authority = 5
        no_change_allowed    = 6
        others               = 7
    ).
    if sy-subrc <> 0.
    endif.

    read table lt_status into data(ls_status) with key status = lv_status_u. "#EC CI_SORTSEQ
    move-corresponding ls_status to ls_status_com.

    loop at iv_status into lv_status_c.
      if lv_status_c(1) = 'E'. "set user statuses
        if lv_status_c <> lv_status_u.
          ls_status_com-status = lv_status_c.

          ls_status_com-ref_guid       = ls_status-guid.
          ls_status_com-ref_kind       = 'A'.
          ls_status_com-activate       = 'X'.

          append ls_status_com to lt_status_com.

        endif.
      else."set system status
        read table lt_status into data(ls_status_sys) with key user_stat_proc = ''. "#EC CI_SORTSEQ
        move-corresponding ls_status_sys to ls_status_com.
        if lv_status_c <> ls_status_com-status.

          ls_status_int-inact = space.
          ls_status_int-stat  = lv_status_c.
          append ls_status_int to lt_status_int.

*          ls_status_int-inact = 'X'.
*          ls_status_int-stat  = ls_status_com-status.
*          append ls_status_int to lt_status_int.

        endif.
      endif.
    endloop.

    if lt_status_com is not initial.
      iv_1o_api->set_status(
            exporting
              it_status         =     lt_status_com
            exceptions
              document_locked   = 1
              error_occurred    = 2
              no_authority      = 3
              no_change_allowed = 4
              others            = 5
          ).
      if sy-subrc <> 0.
      endif.
    endif.

    if lt_status_int is not initial.
      call function 'CRM_STATUS_CHANGE_INTERN'
        exporting
          objnr               = ls_status-guid
        tables
          status              = lt_status_int
        exceptions
          object_not_found    = 1
          status_inconsistent = 2
          status_not_allowed  = 3.
      if sy-subrc <> 0.
* Implement suitable error handling here
      endif.
    endif.

    data: lv_table type table of crm_jcds.
    loop at iv_status_hist into lv_stat_hist.
      lv_stat_hist-objnr = ls_status-guid.
      append lv_stat_hist to lv_table.
      commit work.
    endloop.

  endmethod.


  METHOD set_tr.
    "just update TABLE /tmwflow/trord_n
    "(no changes in the managed system)
    DATA: ls_transport TYPE ztr_data_st,
          lt_trordhc   TYPE /tmwflow/trordhc_t,
          ls_trordhc   TYPE /tmwflow/trordhc_s.
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

      MOVE-CORRESPONDING ls_transport TO ls_trordhc.
      " !but we are not changing CTS_IT = Inconsistancy
      ls_trordhc-tasklist = lv_rel-tasklist_id.
      IF ls_track_hdr IS NOT INITIAL.
        " !possible inconsistance
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
  ENDMETHOD.


  method set_webui_fields.

    "Record Customer_h fields
    data: ls_customer_h type crmt_customer_h_com.
    data: ls_orderadm_h  type crmt_orderadm_h_wrk.
    data: ls_customer_h_old type crmt_customer_h_wrk.
    data: ls_fields type zcustom_fields.
    data: fldname type fieldname.

    field-symbols:
    <fld> type any.

    iv_1o_api->get_customer_h( importing es_customer_h = ls_customer_h_old ).
    iv_1o_api->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

    ls_customer_h-ref_guid = ls_orderadm_h-guid.

    loop at ev_custom_fields into ls_fields.
      if ls_fields-target_table = 'CUSTOMER_H'.
        concatenate 'ls_customer_h-' ls_fields-target_field into fldname.

        assign (fldname) to <fld>.
        <fld> = ls_fields-value.
        "ls_customer_h-ls_fields-target_field = ls_fields-value.
      endif.
    endloop.

    iv_1o_api->set_customer_h( exporting is_customer_h = ls_customer_h
      exceptions
        error_occurred    = 1
        document_locked   = 2
        no_change_allowed = 3
        no_authority      = 4
        others            = 5 ).
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
        raising error_customer_header.
    endif.

  endmethod.
ENDCLASS.

class ZCL_SOLMOVE_HELPER definition
  public
  final
  create public .

public section.

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
protected section.
private section.

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
      !IV_STATUS type CRM_J_STATUS
      !IV_SYST_STATUS type CRM_J_STATUS
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
ENDCLASS.



CLASS ZCL_SOLMOVE_HELPER IMPLEMENTATION.


  method create_doc.

    include: crm_mode_con. "Include with standard CRM constants

    data: lo_cd         type ref to cl_ags_crm_1o_api, "CRM Document object instance to create and maintain CRM Document through standard API
          lv_log_handle type balloghndl,
          ls_orderadm_h type crmt_orderadm_h_wrk,
          ls_customer_h type crmt_customer_h_com,
          lt_status_com type crmt_status_comt,
          lv_message    type tdline.

    "Create document
    cl_ags_crm_1o_api=>get_instance(
    exporting
      iv_process_mode = gc_mode-create
      iv_process_type = iv_documentprops-type
    importing
      eo_instance = lo_cd
      ).

    if lo_cd is not bound.
      lv_message = 'Error: Could not initialize cl_ags_crm_1o_api for creation'.
      append lv_message to ev_message.
      exit.
    endif.
    "get guid of the created document
    lo_cd->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

    "set description
    lo_cd->set_short_text( exporting iv_short_text = iv_documentprops-description ).

    "set priority
    if iv_documentprops-priority is not initial.
      lo_cd->set_priority( exporting iv_priority = iv_documentprops-priority ).
    endif.

    "set soldoc data
    if iv_documentprops-occ_ids is not initial.
      call method zcl_solmove_helper=>set_soldoc
        exporting
          iv_1o_api = lo_cd
          iv_smud_t = iv_documentprops-occ_ids.
    endif.

    "set status
    if iv_documentprops-status is not initial.
      call method zcl_solmove_helper=>set_status
        exporting
          iv_status      = iv_documentprops-status
          iv_syst_status = iv_documentprops-sys_status
        changing
          iv_1o_api      = lo_cd.
    endif.

    " add attachments
    if iv_documentprops-attach_list is not initial.
      data: lt_object_type type sibftypeid.
      lt_object_type = ls_orderadm_h-object_type.

      call method zcl_solmove_helper=>set_attachments
        exporting
          iv_guid        = ls_orderadm_h-guid
          iv_object_type = lt_object_type
          iv_attach_list = iv_documentprops-attach_list.
    endif.

    "add ibase
    if iv_documentprops-ibase is not initial.
      call method zcl_solmove_helper=>set_ibase
        exporting
          iv_guid   = ls_orderadm_h-guid
          iv_ibase  = iv_documentprops-ibase
        changing
          iv_1o_api = lo_cd.
    endif.

    "add cycle
    if iv_documentprops-cycle is not initial.
      call method zcl_solmove_helper=>set_cycle
        exporting
          iv_guid  = ls_orderadm_h-guid
          iv_type  = ls_orderadm_h-process_type
          iv_ibase = iv_documentprops-ibase
          iv_cycle = iv_documentprops-cycle.
    endif.

    "add webui fields
    if iv_documentprops-custom_fields is not initial.
      call method zcl_solmove_helper=>set_webui_fields
        exporting
          ev_custom_fields      = iv_documentprops-custom_fields
        changing
          iv_1o_api             = lo_cd
        exceptions
          error_customer_header = 1
          others                = 2.
      if sy-subrc <> 0.
        lv_message = 'Error: Could not set document webui fields'.
        append lv_message to ev_message.
      endif.

    endif.

*    record document and return solution manager id and solution manager guid
    lo_cd->save( changing cv_log_handle = lv_log_handle ).

*    Check if document was ctreated?
    lo_cd->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).
    concatenate 'Document:' ls_orderadm_h-object_id 'created in target.' into lv_message separated by space.
    append lv_message to ev_message.

  endmethod.


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


  method get_cycle.
    data lv_sorce type zsolmove_sorce.

    select single release_crm_id into @ev_cycle
      from tsocm_cr_context as cont
      left join aic_release_cycl as cycl on cont~project_id = cycl~smi_project
    where created_guid = @iv_guid and release_crm_id is not null.

    lv_sorce = ev_cycle.

    select single target into @data(lv_target) from zsolmove_mapping where sorce = @lv_sorce and type = 'CYCLE'.

    ev_cycle = lv_target.

  endmethod.


  method get_doc_data.

    data: lo_api_object       type ref to cl_ags_crm_1o_api,
          ls_orderadm_h       type crmt_orderadm_h_wrk,
          lv_type             type crmt_process_type,
          ls_occ_ids          type line of smud_t_guid22,
          lt_occ_ids          type smud_t_guid22,
          lt_smud_occurrences type cl_ags_crm_1o_api=>tt_smud_occurrence,
          lt_attachment_list  type ags_t_crm_attachment.

    "Get document instance
    call method cl_ags_crm_1o_api=>get_instance
      exporting
        iv_language                   = sy-langu
        iv_header_guid                = iv_guid
        iv_process_mode               = cl_ags_crm_1o_api=>ac_mode-display
      importing
        eo_instance                   = lo_api_object
      exceptions
        invalid_parameter_combination = 1
        error_occurred                = 2
        others                        = 3.
    if sy-subrc <> 0.
      message id sy-msgid type sy-msgty number sy-msgno
        with sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
        raising error_read_doc.
    endif.

    "get header data
    lo_api_object->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

    "mapping to the target t-type
    call method zcl_solmove_helper=>get_type
      exporting
        iv_type = ls_orderadm_h-process_type
      importing
        ev_type = lt_doc_properties-type.

    lv_type = ls_orderadm_h-process_type.

    if lt_doc_properties-type is initial.
      message text-001 type 'E'
      raising error_no_target_ttype.
    endif.

    "get Header data
    lt_doc_properties-description = ls_orderadm_h-description.
    lt_doc_properties-object_id = ls_orderadm_h-object_id. "to be removed (moved to get WebUI fields)
    lt_doc_properties-created_at = ls_orderadm_h-created_at.
    lo_api_object->get_priority( importing ev_priority = lt_doc_properties-priority ).
    lo_api_object->get_status( importing ev_user_status = lt_doc_properties-status ). "user status

    select single stat from crm_jest into (@lt_doc_properties-sys_status) "system status
    where stat like 'I%' and inact = '' and objnr = @ls_orderadm_h-guid.

    "get occ_ids
    lo_api_object->get_smud_occurrences(
      importing
        et_smud_occurrences = lt_smud_occurrences ).

    if lt_smud_occurrences is not initial.
      loop at lt_smud_occurrences into data(ls_smud_ids).
        ls_occ_ids = ls_smud_ids-occ_id.
        append ls_occ_ids to lt_occ_ids.
      endloop.
    endif.
    lt_doc_properties-occ_ids = lt_occ_ids.

    " get attachments
    lo_api_object->get_attachment_list( importing et_attach_list = lt_attachment_list ).
    if lt_attachment_list is not initial.
      call method zcl_solmove_helper=>get_attachments
        exporting
          iv_attachment_list = lt_attachment_list
        importing
          ev_attachments     = lt_doc_properties-attach_list.
    endif.

    "get i-base
    lo_api_object->get_ibase( importing es_refobj = data(lv_refobj) ) .
    if lv_refobj is not initial.
      call method zcl_solmove_helper=>get_ibase
        exporting
          iv_ibase = lv_refobj-product_id
        importing
          ev_ibase = lt_doc_properties-ibase.
    endif.

    " get change cycle
    call method zcl_solmove_helper=>get_cycle
      exporting
        iv_guid  = iv_guid
      importing
        ev_cycle = lt_doc_properties-cycle.

    " get custom fields for WEB UI
    call method zcl_solmove_helper=>get_webui_fields
      exporting
        iv_1o_api        = lo_api_object
      importing
        ev_custom_fields = lt_doc_properties-custom_fields.


  endmethod.


  method get_ibase.
    data lv_sorce_ibase type zsolmove_sorce.
    lv_sorce_ibase = iv_ibase.
    select single target into @data(lv_ibase) from zsolmove_mapping
      where sorce = @lv_sorce_ibase
      and type = 'IBASE'.
    ev_ibase = lv_ibase.
  endmethod.


  method get_type.
    data lv_sorce_type type zsolmove_sorce.
    lv_sorce_type = iv_type.
    select single target into @data(lv_type) from zsolmove_mapping
      where sorce = @lv_sorce_type
      and TYPE = 'TYPE'.
    ev_type = lv_type.
  endmethod.


  method get_webui_fields.

    data: ls_customer_h  type crmt_customer_h_wrk.
    data: ls_orderadm_h  type crmt_orderadm_h_wrk.
    data: ls_custom_line type zcustom_fields.
    data: lv_sorce       type zsolmove_sorce.
    data: lv_sub_type    type zsolmove_param.
    data: fldname        type fieldname.

    field-symbols: <fld> type any.

    "get header data
    iv_1o_api->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

    " get customer header
    iv_1o_api->get_customer_h( importing es_customer_h = ls_customer_h ).

    "save customer_h fields that was mapped
    select sorce, target from zsolmove_mapping where type = 'FILD' and sub_type = 'CUSTOMER_H'
      into (@lv_sorce, @ls_custom_line-target_field).
      ls_custom_line-target_table = 'CUSTOMER_H'.
      concatenate 'ls_customer_h-' lv_sorce into fldname.
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
    ls_bo-catid = 'BO'. "! Change

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
      lt_status_com  type crmt_status_comt,
      ls_status_com  type crmt_status_com,
      lt_status      type crmt_status_wrkt,
      lt_stat_schema type crm_j_stsma.

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

    if iv_status <> lv_status_u. "user status

      read table lt_status into data(ls_status) with key status = lv_status_u. "#EC CI_SORTSEQ
      move-corresponding ls_status to ls_status_com.
      ls_status_com-status = iv_status.

      ls_status_com-ref_guid       = ls_status-guid.
      ls_status_com-ref_kind       = 'A'.
      ls_status_com-activate       = 'X'.

      append ls_status_com to lt_status_com.

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

      "system status
      read table lt_status into data(ls_status_sys) with key user_stat_proc = ''. "#EC CI_SORTSEQ
      move-corresponding ls_status_sys to ls_status_com.
      if ls_status_com-status <> iv_syst_status.

        ls_status_int-inact = space.
        ls_status_int-stat  = iv_syst_status.
        append ls_status_int to lt_status_int.

        ls_status_int-inact = 'X'.
        ls_status_int-stat  = ls_status_com-status.
        append ls_status_int to lt_status_int.


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

    endif.

  endmethod.


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

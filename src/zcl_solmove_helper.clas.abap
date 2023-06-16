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
      !EV_MESSAGE type TDLINE .
protected section.
private section.

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
      !IV_1O_API type ref to CL_AGS_CRM_1O_API
      !IV_STATUS type CRM_J_STATUS .
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
          lt_status_com type crmt_status_comt.

    "Create document
    cl_ags_crm_1o_api=>get_instance(
    exporting
      iv_process_mode = gc_mode-create
      iv_process_type = iv_documentprops-type
    importing
      eo_instance = lo_cd
      ).

    if lo_cd is not bound.
      ev_message = 'Error: Could not initialize cl_ags_crm_1o_api for creation'.
      exit.
    endif.

*   lo_cd->set_customer_h( exporting is_customer_h = ls_customer_h ).
    "set description
    lo_cd->set_short_text( exporting iv_short_text = iv_documentprops-description ).

    "set priority
    if iv_documentprops-priority is not initial.
      lo_cd->set_priority( exporting iv_priority = iv_documentprops-priority ).
    endif.

    lo_cd->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

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
          iv_1o_api = lo_cd
          iv_status = iv_documentprops-status.
    endif.

    if iv_documentprops-attach_list is not initial.
      data: lt_object_type type sibftypeid.
      lt_object_type = ls_orderadm_h-object_type.

      call method zcl_solmove_helper=>set_attachments
        exporting
          iv_guid        = ls_orderadm_h-guid
          iv_object_type = lt_object_type
          iv_attach_list = iv_documentprops-attach_list.
    endif.

*    record document and return solution manager id and solution manager guid
    lo_cd->save( changing cv_log_handle = lv_log_handle ).
*     Check if document was ctreated?
    lo_cd->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).

    "temp get occ_ids check
    lo_cd->get_smud_occurrences(
      importing
        et_smud_occurrences = data(lt_smud_occurrences) ).

    concatenate 'Document:' ls_orderadm_h-object_id 'created in target.' into ev_message separated by space.

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


  method get_doc_data.

    data: lo_api_object       type ref to cl_ags_crm_1o_api,
          ls_orderadm_h       type crmt_orderadm_h_wrk,
          lv_type             type crmt_process_type,
          ls_occ_ids          type line of smud_t_guid22,
          lt_occ_ids          type smud_t_guid22,
          lt_smud_occurrences type cl_ags_crm_1o_api=>tt_smud_occurrence,
          lt_attachment_list  type ags_t_crm_attachment.

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

    "get Priority, description, status
    lt_doc_properties-description = ls_orderadm_h-description.
    lo_api_object->get_priority( importing ev_priority = lt_doc_properties-priority ).
    lo_api_object->get_status( importing ev_user_status = lt_doc_properties-status ).

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
    lo_api_object->get_attachment_list( importing et_attach_list = lt_attachment_list
"    et_url_list    =
    ).
    if lt_attachment_list is not initial.
      call method zcl_solmove_helper=>get_attachments
        exporting
          iv_attachment_list = lt_attachment_list
        importing
          ev_attachments     = lt_doc_properties-attach_list.


    endif.


  endmethod.


  method get_type.
    data lv_sorce_type type zsolmove_sorce.
    lv_sorce_type = iv_type.
    select single target into @data(lv_type) from zsolmove_mapping
      where sorce = @lv_sorce_type
      and TYPE = 'TYPE'.
    ev_type = lv_type.
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
      lv_status_u   type crm_j_status,
      lt_status_com type crmt_status_comt,
      ls_status_com type crmt_status_com,
      lt_status     type crmt_status_wrkt.

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

    if iv_status <> lv_status_u.

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
    endif.


******************************************

  endmethod.
ENDCLASS.

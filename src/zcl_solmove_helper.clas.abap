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
      ERROR_GET_ATTACHMENTS .
  class-methods CREATE_DOC
    importing
      !IV_DOCUMENTPROPS type ZDOC_PROPS_STRUCT .
protected section.
private section.

  class-methods GET_ATTACHMENTS
    importing
      !IC_1O_API type ref to CL_AGS_CRM_1O_API
    exporting
      !ET_ATTACHMENT_LIST type ZITSM_ATTACHMENTS_T
    exceptions
      ERROR_OCCURRED .
ENDCLASS.



CLASS ZCL_SOLMOVE_HELPER IMPLEMENTATION.


  method create_doc.

    include: crm_mode_con. "Include with standard CRM constants
    data: lo_cd type ref to cl_ags_crm_1o_api. "CRM Document object instance to create and maintain CRM Document through standard API

*    cl_ags_crm_1o_api=>get_instance(
*    exporting
*      iv_process_mode = gc_mode-create
*      iv_process_type = iv_documentprops-type
*    importing
*      eo_instance = lo_cd
*      ).

    "Record document and return Solution Manager ID and Solution Manager GUID
*    lo_cd->save( changing cv_log_handle = lv_log_handle ).

*    lo_cd->get_orderadm_h( importing es_orderadm_h = ls_orderadm_h ).
*    cdnumber = ls_orderadm_h-object_id.

  endmethod.


  method get_attachments.
    data: ls_phio                type skwf_io,
          lt_file_access_info    type sdokfilacis,
          lt_file_content_ascii  type sdokcntascs,
          lt_file_content_binary type sdokcntbins,
          lt_attachment_list     type ags_t_crm_attachment,
          ls_attachments         type zitsm_attachments.

    call method ic_1o_api->get_attachment_list
      importing
        et_attach_list = lt_attachment_list.

    if lt_attachment_list is not initial.

      loop at lt_attachment_list into data(ls_attachment_list).

        clear: ls_phio, lt_file_access_info, lt_file_content_ascii, lt_file_content_binary.

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

        append ls_attachments to et_attachment_list.

      endloop.
    endif.

  endmethod.


  method get_doc_data.

    data: lo_api_object          type ref to cl_ags_crm_1o_api.

    call method cl_ags_crm_1o_api=>get_instance
      exporting
        iv_language                   = sy-langu
        iv_header_guid                = iv_guid
*       iv_process_type               =
        iv_process_mode               = cl_ags_crm_1o_api=>ac_mode-display
      importing
*       et_msg                        =
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


    call method zcl_solmove_helper=>get_attachments
      exporting
        ic_1o_api          = lo_api_object
      importing
        et_attachment_list = lt_doc_properties-attach_list.


  endmethod.
ENDCLASS.

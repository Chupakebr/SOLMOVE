FUNCTION Z_CREATE_DOC .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_DOCUMENTPROPS) TYPE  ZDOC_PROPS_STRUCT
*"  EXPORTING
*"     VALUE(ET_MESSAGES) TYPE  ZPROCESS_LOG_TT
*"----------------------------------------------------------------------

  call method zcl_solmove_helper=>create_doc
    exporting
      iv_documentprops = is_documentprops
    importing
      ev_message = ET_MESSAGES.

endfunction.

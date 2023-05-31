FUNCTION Z_DOC_CREATE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(DOCUMENTPROPS) TYPE  ZITSM_PROPS_T
*"  EXPORTING
*"     VALUE(ET_MESSAGES) TYPE  TDLINE
*"----------------------------------------------------------------------

call method zcl_solmove_helper=>doc_create
  exporting
    iv_documentprops = DOCUMENTPROPS
    .




ENDFUNCTION.

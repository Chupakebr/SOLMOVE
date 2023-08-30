FUNCTION z_create_bp.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_BP_DATA) TYPE  ZBP_DATA
*"  EXPORTING
*"     VALUE(EV_PARTNER) TYPE  BU_PARTNER
*"     VALUE(ET_MESSAGES) TYPE  ZPROCESS_LOG_TT
*"----------------------------------------------------------------------
  CALL METHOD zcl_solmove_helper=>create_bp
    EXPORTING
      iv_bp_data = iv_bp_data
    IMPORTING
      ev_message = et_messages
      ev_partner = ev_partner.

ENDFUNCTION.

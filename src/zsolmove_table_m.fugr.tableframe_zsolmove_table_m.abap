*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZSOLMOVE_TABLE_M
*   generation date: 02.06.2023 at 14:36:34
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZSOLMOVE_TABLE_M   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

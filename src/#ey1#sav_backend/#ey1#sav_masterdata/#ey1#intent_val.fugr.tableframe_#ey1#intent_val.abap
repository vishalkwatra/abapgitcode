*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/INTENT_VAL
*   generation date: 21.01.2021 at 10:30:45
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/INTENT_VAL    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/GLOBALPAR
*   generation date: 04.10.2021 at 04:54:26
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/GLOBALPAR     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

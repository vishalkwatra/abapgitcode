*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/GLOBALPAR
*   generation date: 21.07.2021 at 08:13:39
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/GLOBALPAR     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/TAXRATE_VH
*   generation date: 16.02.2021 at 10:22:09
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/TAXRATE_VH    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

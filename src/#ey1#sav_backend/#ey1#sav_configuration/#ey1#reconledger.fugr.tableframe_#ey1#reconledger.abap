*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/RECONLEDGER
*   generation date: 18.01.2021 at 07:24:38
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/RECONLEDGER   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

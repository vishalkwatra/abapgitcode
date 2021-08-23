*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/INTENTION
*   generation date: 27.07.2021 at 11:24:53
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/INTENTION     .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

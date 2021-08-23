*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_/EY1/CTAFORPL_VH
*   generation date: 01.06.2021 at 05:14:18
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_/EY1/CTAFORPL_VH   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.

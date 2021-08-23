*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 01.06.2021 at 05:14:19
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/CTAFORPL_VH................................*
DATA:  BEGIN OF STATUS_/EY1/CTAFORPL_VH              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/CTAFORPL_VH              .
CONTROLS: TCTRL_/EY1/CTAFORPL_VH
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/CTAFORPL_VH              .
TABLES: /EY1/CTAFORPL_VH               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

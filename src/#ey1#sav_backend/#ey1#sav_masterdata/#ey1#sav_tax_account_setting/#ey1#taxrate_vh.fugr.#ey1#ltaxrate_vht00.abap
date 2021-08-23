*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 16.02.2021 at 10:22:10
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/TAXRATE_VH.................................*
DATA:  BEGIN OF STATUS_/EY1/TAXRATE_VH               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/TAXRATE_VH               .
CONTROLS: TCTRL_/EY1/TAXRATE_VH
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/TAXRATE_VH               .
TABLES: /EY1/TAXRATE_VH                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

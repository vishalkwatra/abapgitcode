*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 16.02.2021 at 10:15:06
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/CLASS_VH...................................*
DATA:  BEGIN OF STATUS_/EY1/CLASS_VH                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/CLASS_VH                 .
CONTROLS: TCTRL_/EY1/CLASS_VH
            TYPE TABLEVIEW USING SCREEN '0002'.
*.........table declarations:.................................*
TABLES: */EY1/CLASS_VH                 .
TABLES: /EY1/CLASS_VH                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

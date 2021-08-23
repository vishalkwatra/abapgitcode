*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 16.02.2021 at 10:30:35
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/DTARECO_VH.................................*
DATA:  BEGIN OF STATUS_/EY1/DTARECO_VH               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/DTARECO_VH               .
CONTROLS: TCTRL_/EY1/DTARECO_VH
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/DTARECO_VH               .
TABLES: /EY1/DTARECO_VH                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

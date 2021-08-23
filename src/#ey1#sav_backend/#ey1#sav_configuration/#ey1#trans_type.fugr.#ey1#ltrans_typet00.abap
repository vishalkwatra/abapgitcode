*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 18.01.2021 at 08:38:37
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/TRANS_TYPE.................................*
DATA:  BEGIN OF STATUS_/EY1/TRANS_TYPE               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/TRANS_TYPE               .
CONTROLS: TCTRL_/EY1/TRANS_TYPE
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/TRANS_TYPE               .
TABLES: /EY1/TRANS_TYPE                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

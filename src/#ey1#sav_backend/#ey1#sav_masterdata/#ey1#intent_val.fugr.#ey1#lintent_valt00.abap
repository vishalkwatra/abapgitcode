*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 21.01.2021 at 10:30:47
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/INTENT_VAL.................................*
DATA:  BEGIN OF STATUS_/EY1/INTENT_VAL               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/INTENT_VAL               .
CONTROLS: TCTRL_/EY1/INTENT_VAL
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/INTENT_VAL               .
TABLES: /EY1/INTENT_VAL                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

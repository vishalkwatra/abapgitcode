*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 27.07.2021 at 11:24:54
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/INTENTION..................................*
DATA:  BEGIN OF STATUS_/EY1/INTENTION                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/INTENTION                .
CONTROLS: TCTRL_/EY1/INTENTION
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/INTENTION                .
TABLES: /EY1/INTENTION                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

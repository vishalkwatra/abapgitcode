*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 31.05.2021 at 06:23:32
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/CURR_TYPE..................................*
DATA:  BEGIN OF STATUS_/EY1/CURR_TYPE                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/CURR_TYPE                .
CONTROLS: TCTRL_/EY1/CURR_TYPE
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/CURR_TYPE                .
TABLES: /EY1/CURR_TYPE                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

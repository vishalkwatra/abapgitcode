*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 18.01.2021 at 07:24:41
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/RECONLEDGER................................*
DATA:  BEGIN OF STATUS_/EY1/RECONLEDGER              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/RECONLEDGER              .
CONTROLS: TCTRL_/EY1/RECONLEDGER
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/RECONLEDGER              .
TABLES: /EY1/RECONLEDGER               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

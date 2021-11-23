*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 04.10.2021 at 04:54:27
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: /EY1/GLOBALPARAM................................*
DATA:  BEGIN OF STATUS_/EY1/GLOBALPARAM              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_/EY1/GLOBALPARAM              .
CONTROLS: TCTRL_/EY1/GLOBALPARAM
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: */EY1/GLOBALPARAM              .
TABLES: /EY1/GLOBALPARAM               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

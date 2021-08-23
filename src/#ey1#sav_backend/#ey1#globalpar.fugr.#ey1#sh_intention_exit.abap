FUNCTION /EY1/SH_INTENTION_EXIT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) LIKE  DDSHF4CTRL STRUCTURE  DDSHF4CTRL
*"----------------------------------------------------------------------

DATA: lt_tab TYPE TABLE OF /ey1/F4_INTNT.

IF record_tab[] IS NOT INITIAL.
 lt_tab[] = record_tab[].
 SORT lt_tab ASCENDING BY seqnr_flb.
 record_tab[] = lt_tab[].
ENDIF.




ENDFUNCTION.

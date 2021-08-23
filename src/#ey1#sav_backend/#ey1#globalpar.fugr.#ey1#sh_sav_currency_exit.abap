FUNCTION /EY1/SH_SAV_CURRENCY_EXIT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) LIKE  DDSHF4CTRL STRUCTURE  DDSHF4CTRL
*"----------------------------------------------------------------------

TYPES: BEGIN OF tt_curr,
          consolidationunit TYPE fc_bunit,
          currency          TYPE fc_curr,
       END OF tt_curr.

DATA: lt_tab TYPE TABLE OF tt_curr WITH HEADER LINE.

IF record_tab[] IS NOT INITIAL.
 LOOP AT record_tab INTO DATA(ls_tab).
   CONDENSE ls_tab-string.
   SPLIT ls_tab-string AT space INTO lt_tab-consolidationunit lt_tab-currency.
*   lt_tab = ls_tab-string.
   APPEND lt_tab.
 ENDLOOP.
* lt_tab[] = record_tab[].
* SORT lt_tab ASCENDING BY seqnr_flb.
* REFRESH record_tab[].
* LOOP AT lt_tab.
*   CONCATENATE '  ' lt_tab-consolidationunit '  ' lt_tab-currency INTO ls_tab-string RESPECTING BLANKS.
**   lt_tab = ls_tab-string.
*   APPEND ls_tab TO record_tab[].
* ENDLOOP.
ENDIF.




ENDFUNCTION.

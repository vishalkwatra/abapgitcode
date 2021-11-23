FUNCTION /EY1/FM_PYA_LINES_POST.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  TABLES
*"      TT_PYA STRUCTURE  /EY1/PYA_AMOUNT
*"----------------------------------------------------------------------

IF tt_pya[] IS NOT INITIAL.
  MODIFY /ey1/pya_amount FROM TABLE tt_pya[].
ENDIF.



ENDFUNCTION.

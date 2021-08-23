FUNCTION /EY1/FM_DATA_MONITOR_BAL_TRANS.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_DIMEN) TYPE  FC_DIMEN
*"     VALUE(IV_CONGR) TYPE  FC_CONGR
*"     VALUE(IV_BUNIT) TYPE  FC_BUNIT
*"     VALUE(IV_RVERS) TYPE  FC_RVERS
*"     VALUE(IV_RYEAR) TYPE  FC_RYEAR
*"     VALUE(IV_PERIOD_FROM) TYPE  POPER
*"     VALUE(IV_PERIOD_TO) TYPE  POPER
*"     VALUE(IV_JOBNAME) TYPE  TBTCJOB-JOBNAME
*"     VALUE(IV_RLDNR) TYPE  RLDNR OPTIONAL
*"     VALUE(IV_ITCLG) TYPE  STRING OPTIONAL
*"----------------------------------------------------------------------

CALL FUNCTION '/EY1/FM_DM_BALANCE_TRANSFER'
  IN BACKGROUND TASK
  DESTINATION 'NONE'
  EXPORTING
    iv_dimen             = iv_dimen
    iv_congr             = iv_congr
    iv_bunit             = iv_bunit
    iv_rvers             = iv_rvers
    iv_ryear             = iv_ryear
    iv_period_from       = iv_period_from
    iv_period_to         = iv_period_to
    iv_jobname           = iv_jobname
    iv_rldnr             = iv_rldnr
    iv_itclg             = iv_itclg.




ENDFUNCTION.

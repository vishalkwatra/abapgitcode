@AbapCatalog.sqlViewName: '/EY1/ERG2SIRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S Rec Check'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_RecChk
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention

  as select from    /EY1/SAV_I_ER_StatGaapEquiTot(p_ryear:$parameters.p_ryear,
                                                  p_fromperiod:$parameters.p_fromyb,
                                                  p_toperiod:$parameters.p_toyb,
                                                  p_taxintention: $parameters.p_taxintention) as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_RechChkLCGC(p_ryear:$parameters.p_ryear,
                                                  p_fromyb:$parameters.p_fromyb,
                                                  p_toyb:$parameters.p_toyb,
                                                  p_switch:$parameters.p_switch,
                                                  p_taxintention: $parameters.p_taxintention,
                                                  p_intention: $parameters.p_intention
                                                  )                                           as RecChk on  RecChk.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                        and RecChk.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                        and RecChk.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                        and RecChk.FiscalYear                   = GLAcc.FiscalYear
                                                                                                        and RecChk.CurrencyType                 = GLAcc.CurrencyType
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.FiscalYear,

      GLAcc.ConsolidationDimension,
      GLAcc.CurrencyType,

      @Semantics.currencyCode: 'true'
      GLAcc.MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      case when OBBalance is null then cast( 0 as abap.curr(23,2)) - StatOpeningBalance
           when StatOpeningBalance is null then OBBalance
           else OBBalance - StatOpeningBalance end as ReconciliationCheckOB,

      @Semantics.amount.currencyCode: 'MainCurrency'
      case when YBBalance is null then cast( 0 as abap.curr(23,2)) - YBClosingBalance
           when YBClosingBalance is null then YBBalance
           else YBBalance - YBClosingBalance end   as ReconciliationCheckYB,

      @Semantics.amount.currencyCode: 'MainCurrency'
      case when CBBalance is null then cast( 0 as abap.curr(23,2)) - CBClosingBalance
           when CBClosingBalance is null then CBBalance
           else CBBalance - CBClosingBalance end   as ReconciliationCheckCB
}

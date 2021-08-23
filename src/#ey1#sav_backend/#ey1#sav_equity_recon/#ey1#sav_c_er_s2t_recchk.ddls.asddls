@AbapCatalog.sqlViewName: '/EY1/CERS2TRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View ER S2T Rec Check'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ER_S2T_RecChk
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_fromperiod   : poper,
    p_switch       : char1

  as select from /EY1/SAV_I_ER_S2T_RecChk( p_ryear:$parameters.p_ryear ,
                                           p_fromyb: $parameters.p_fromperiod,
                                           p_toyb:$parameters.p_toperiod ,
                                           p_switch: $parameters.p_switch,
                                           p_taxintention:$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      MainCurrency,

      CurrencyType,

      ReconciliationCheckOB as TAXOpeningBalance,
      ReconciliationCheckYB as YBClosingBalance,
      ReconciliationCheckCB as CBClosingBalance
}

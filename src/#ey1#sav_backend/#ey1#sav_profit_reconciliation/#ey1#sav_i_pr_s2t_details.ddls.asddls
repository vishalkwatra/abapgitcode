@AbapCatalog.sqlViewName: '/EY1/PRS2TDETAI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T Details'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_S2T_Details
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_S2T_Detail_LCGC
                 ( p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      ReconciliationCheck,

      CurrencyType
}

@AbapCatalog.sqlViewName: '/EY1/CPRG2SDETAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View - Profit Recon - G2S Details'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_PR_G2S_Details
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_G2S_Details
                 ( p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalG2S,

      @Semantics.amount.currencyCode: 'MainCurrency'
      STATIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      ReconciliationCheck,

      CurrencyType
}

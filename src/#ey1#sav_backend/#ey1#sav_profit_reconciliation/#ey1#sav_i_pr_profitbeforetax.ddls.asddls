@AbapCatalog.sqlViewName: '/EY1/PRSECPBT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - Profit Recon - PBT'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_ProfitBeforeTax
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_PBT_LCGC
                 ( p_toperiod:$parameters.p_toperiod,
                  p_ryear:$parameters.p_ryear,
                  p_taxintention:$parameters.p_taxintention)
{
      ///EY1/SAV_I_PR_Section_PBT_LCGC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: 'true'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      GAAPIncomeLossCY,
      
      CurrencyType
}

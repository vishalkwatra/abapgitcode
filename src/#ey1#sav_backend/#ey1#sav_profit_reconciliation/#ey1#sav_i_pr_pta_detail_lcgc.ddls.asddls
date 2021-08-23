@AbapCatalog.sqlViewName: '/EY1/PRPTADLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- PTA - Details LCGC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_PTA_Detail_LCGC
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr,
    p_taxintention : zz1_taxintention
    
  as select from /EY1/SAV_I_PR_PTA_Total_LC
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
      LocalCurrency                 as MainCurrency,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalPTA,
      cast('Local' as abap.char(5)) as CurrencyType
}

union all select from /EY1/SAV_I_PR_PTA_Total_GC
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
      GroupCurrency                 as MainCurrency,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalPTA,
      cast('Group' as abap.char(5)) as CurrencyType
}

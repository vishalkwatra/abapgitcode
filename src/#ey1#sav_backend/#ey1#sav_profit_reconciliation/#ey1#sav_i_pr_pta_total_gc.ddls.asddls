@AbapCatalog.sqlViewName: '/EY1/PRPTATOTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- PTA Total GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_PTA_Total_GC
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr,
    p_taxintention : zz1_taxintention
    
  as select from /EY1/SAV_I_PR_PTA_YB_GC
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
      GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(TransactionTotal) as TotalPTA
}
group by
  ChartOfAccounts,
  ConsolidationUnit,
  ConsolidationChartofAccounts,
  FiscalYear,
  ConsolidationDimension,
  GroupCurrency

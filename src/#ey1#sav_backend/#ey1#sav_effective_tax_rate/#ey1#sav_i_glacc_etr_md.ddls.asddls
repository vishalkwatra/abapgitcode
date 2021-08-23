@AbapCatalog.sqlViewName: '/EY1/GLETRMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-Vie For GL Account - ETR - Master Data'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_GlAcc_ETR_MD
  with parameters
    p_ryear : gjahr
  as select from /EY1/SAV_I_GlAcc_PL_MD
                 ( p_ryear:$parameters.p_ryear)
{
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      FinancialStatementItem,
      ChartOfAccounts,
      ConsolidationUnit,
      @Semantics.currencyCode: true
      LocalCurrency,
      @Semantics.currencyCode: true
      GroupCurrency,
      ConsolidationChartofAccounts,
      BsEqPl,
      TaxEffected,
      ProfitBeforeTax
}
where
  ProfitBeforeTax = 'X'

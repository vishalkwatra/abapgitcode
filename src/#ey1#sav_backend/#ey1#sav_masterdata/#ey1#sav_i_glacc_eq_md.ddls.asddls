@AbapCatalog.sqlViewName: '/EY1/GLEQMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch Equity(EQ) GL Account - MD'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_GlAcc_EQ_MD
  with parameters
    p_ryear : gjahr
  as select from /EY1/SAV_I_GlAcc_MD(p_ryear: $parameters.p_ryear)
{
      ///EY1/SAV_I_GlAcc_MD
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,

      FinancialStatementItem,
      ChartOfAccounts,
      ConsolidationUnit,
      LocalCurrency,
      GroupCurrency,
      ConsolidationChartofAccounts,
      BsEqPl,
      TaxEffected
}
where
      BsEqPl = 'EQ'
  and ConsolidationChartofAccounts != ''
  and ChartOfAccounts != ''
  and ConsolidationUnit != ''

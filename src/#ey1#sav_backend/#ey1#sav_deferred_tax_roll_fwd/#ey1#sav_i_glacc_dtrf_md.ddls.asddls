@AbapCatalog.sqlViewName: '/EY1/GLDTRFMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for GL Account Master Data - DTRF'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_GlAcc_DTRF_MD
  with parameters
    p_ryear : gjahr
  as select from /EY1/SAV_I_GlAcc_BSEQTE_MD( p_ryear:$parameters.p_ryear )
{
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
      CNC,
      TaxEffected
}

@AbapCatalog.sqlViewName: '/EY1/GLTRFMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for GL Account Master Data'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_GlAcc_TRF_MD
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
      TaxEffected,

      cast (0 as abap.curr( 23, 2)) as PlaceholderCurrency
}

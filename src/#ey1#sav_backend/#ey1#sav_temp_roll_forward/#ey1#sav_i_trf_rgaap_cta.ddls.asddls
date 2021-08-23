@AbapCatalog.sqlViewName: '/EY1/IRGCTALCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Temp Roll Fwd CTA'


define view /EY1/SAV_I_TRF_RGAAP_CTA
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr
  as select from    /EY1/SAV_I_GlAcc_TRF_MD (p_ryear : $parameters.p_ryear) as GLAccnt
//    left outer join /EY1/SAV_P_PlaceholderValue                             as PlaceholderValue on GLAccnt.ChartOfAccounts = PlaceholderValue.ktopl

{
        //GLAccnt
  key   GLAccnt.ChartOfAccounts,
  key   GLAccnt.ConsolidationUnit,
  key   GLAccnt.ConsolidationChartofAccounts,
  key   GLAccnt.GLAccount,
  key   GLAccnt.FiscalYear,
  key   GLAccnt.ConsolidationDimension,
        GLAccnt.FinancialStatementItem,


        PlaceholderCurrency as CTAPl,
        PlaceholderCurrency as CTAPmnt,
        PlaceholderCurrency as CTAEq,
        PlaceholderCurrency as CTA
}
where
  GLAccnt.FiscalYear = :p_ryear

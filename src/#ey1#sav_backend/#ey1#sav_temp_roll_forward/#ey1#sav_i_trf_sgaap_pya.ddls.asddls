@AbapCatalog.sqlViewName: '/EY1/ISGPYALCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP PYA'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_TRF_SGAAP_PYA
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


        PlaceholderCurrency as PYAPl,
        PlaceholderCurrency as PYAPmnt,
        PlaceholderCurrency as PYAEq,
        PlaceholderCurrency as PYAOpl,
        PlaceholderCurrency as PYAOpmnt,
        PlaceholderCurrency as PYAOeq,
        PlaceholderCurrency as PYA
}
where
  GLAccnt.FiscalYear = :p_ryear

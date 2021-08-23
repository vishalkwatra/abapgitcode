@AbapCatalog.sqlViewName: '/EY1/DTRFSCTA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward CTA'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_DTRF_SGAAP_CTA 
    with parameters
    p_toperiod : poper,
    p_ryear    : gjahr
  as select  from /EY1/SAV_I_GlAcc_DTRF_MD (p_ryear : $parameters.p_ryear) as GLAccnt
{
        //GLAccnt
  key   GLAccnt.ChartOfAccounts,
  key   GLAccnt.ConsolidationUnit,
  key   GLAccnt.ConsolidationChartofAccounts,
  key   GLAccnt.GLAccount,
  key   GLAccnt.FiscalYear,
  key   GLAccnt.ConsolidationDimension,
        GLAccnt.FinancialStatementItem,
       

        cast (0 as abap.curr( 23, 2)) as CTAPl,
        cast (0 as abap.curr( 23, 2)) as CTAEq,
        cast (0 as abap.curr( 23, 2)) as CTA
}
where
  GLAccnt.FiscalYear = :p_ryear

@AbapCatalog.sqlViewName: '/EY1/DTRFRTRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward Tax Rate Change(TRC)'
@VDM.viewType: #BASIC
define view /EY1/SAV_I_DTRF_RGAAP_TRC
   with parameters
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
       

        cast (0 as abap.curr( 23, 2)) as TRCPl,
        cast (0 as abap.curr( 23, 2)) as TRCEq,
        cast (0 as abap.curr( 23, 2)) as TRC
}
where
  GLAccnt.FiscalYear = :p_ryear

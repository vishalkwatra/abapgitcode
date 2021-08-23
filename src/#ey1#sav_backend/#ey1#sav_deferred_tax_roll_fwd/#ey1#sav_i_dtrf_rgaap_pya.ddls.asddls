@AbapCatalog.sqlViewName: '/EY1/DTRFRPYA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward PYA'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_DTRF_RGAAP_PYA 
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
       

        cast (0 as abap.curr( 23, 2)) as PYAPl,
        cast (0 as abap.curr( 23, 2)) as PYAEq,
        cast (0 as abap.curr( 23, 2)) as PYAOpl,
        cast (0 as abap.curr( 23, 2)) as PYAOeq,
        cast (0 as abap.curr( 23, 2)) as PYA
}
where
  GLAccnt.FiscalYear = :p_ryear

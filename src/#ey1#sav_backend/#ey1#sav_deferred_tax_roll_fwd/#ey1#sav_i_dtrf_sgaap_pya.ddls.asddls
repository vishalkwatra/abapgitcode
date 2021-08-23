@AbapCatalog.sqlViewName: '/EY1/DTRFSGPYA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for DTRF SGAAP PYA'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_DTRF_SGAAP_PYA  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr
  as select  from ZEY_SAV_I_GLACC_DTRF_MD (p_ryear : $parameters.p_ryear) as GLAccnt
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

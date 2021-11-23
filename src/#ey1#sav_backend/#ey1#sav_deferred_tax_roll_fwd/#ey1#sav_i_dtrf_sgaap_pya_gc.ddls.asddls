@AbapCatalog.sqlViewName: '/EY1/DTRFSPYAGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward PYA'
define view /EY1/SAV_I_DTRF_SGAAP_PYA_GC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper,
    p_rbunit       : fc_bunit
  as select from    /EY1/SAV_I_DTRF_SGAAP_PYANR_GC(p_ryear : $parameters.p_ryear,
                                                  p_taxintention : $parameters.p_taxintention,
                                                  p_toperiod     : $parameters.p_toperiod,
                                                  p_rbunit       : $parameters.p_rbunit ) as GLAccnt
    left outer join /EY1/SAV_I_Get_Tax_Rate
                        (p_toperiod:$parameters.p_toperiod ,
                        p_ryear:$parameters.p_ryear ,
                        p_rbunit: $parameters.p_rbunit)                                   as TaxRate on  TaxRate.ConsolidationUnit = $parameters.p_rbunit
                                                                                                     and TaxRate.FiscalYear        = $parameters.p_ryear

{
        //GLAccnt
  key   GLAccnt.ChartOfAccounts,
  key   GLAccnt.ConsolidationUnit,
  key   GLAccnt.ConsolidationChartofAccounts,
  key   GLAccnt.GLAccount,
  key   GLAccnt.FiscalYear,
  key   GLAccnt.ConsolidationDimension,
        GLAccnt.FinancialStatementItem,

        //        PYAPl,
        //        PYAEq,
        //        PYAOpl,
        //        PYAOeq,
        //        (PYAPl+PYAEq+PYAOpl+PYAOeq) as PYA
        PYAPl* StatOBDTRate * MultiFactor                         as PYAPl,
        PYAOpl* StatOBDTRate * MultiFactor                        as PYAOpl,
        PYAEq* StatOBDTRate * MultiFactor                         as PYAEq,
        PYAOeq* StatOBDTRate * MultiFactor                        as PYAOeq,
        (PYAPl+PYAEq+PYAOpl+PYAOeq)  * StatOBDTRate * MultiFactor as PYA
}
where
  GLAccnt.FiscalYear = :p_ryear

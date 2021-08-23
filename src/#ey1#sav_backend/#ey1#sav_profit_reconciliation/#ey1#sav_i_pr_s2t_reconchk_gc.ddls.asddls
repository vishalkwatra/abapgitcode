@AbapCatalog.sqlViewName: '/EY1/PRS2TRCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T -Reconciliation Check GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_S2T_ReconChk_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt
    left outer join /EY1/SAV_I_PR_TAX_YB_GC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as TAXYearMvmntGC on  TAXYearMvmntGC.GLAccount         = GLAccnt.GLAccount
                                                                                   and TAXYearMvmntGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                   and TAXYearMvmntGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                   and GLAccnt.ProfitBeforeTax          = 'X'
                                                                                   and GLAccnt.BsEqPl                   = 'P&L'
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.FiscalYear,
      GLAccnt.ConsolidationDimension,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(TAXLedgerTransactions) as ReconciliationCheck
}
where
      GLAccnt.ProfitBeforeTax = 'X'
  and BsEqPl                  = 'P&L'

group by
  GLAccnt.ChartOfAccounts,
  GLAccnt.ConsolidationUnit,
  GLAccnt.ConsolidationChartofAccounts,
  GLAccnt.FiscalYear,
  GLAccnt.ConsolidationDimension,
  GLAccnt.GroupCurrency

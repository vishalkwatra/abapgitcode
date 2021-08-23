@AbapCatalog.sqlViewName: '/EY1/PRS2TRCLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T -Reconciliation Check LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_S2T_ReconChk_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt
    left outer join /EY1/SAV_I_PR_TAX_YB_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as TAXYearMvmntLC on  TAXYearMvmntLC.GLAccount         = GLAccnt.GLAccount
                                                                                   and TAXYearMvmntLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                   and TAXYearMvmntLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                   and GLAccnt.ProfitBeforeTax          = 'X'
                                                                                   and GLAccnt.BsEqPl                   = 'P&L'
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.FiscalYear,
      GLAccnt.ConsolidationDimension,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,
      @Semantics.amount.currencyCode: 'LocalCurrency'
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
  GLAccnt.LocalCurrency

@AbapCatalog.sqlViewName: '/EY1/PRCYTERCLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- CYTE - Reconciliation Check LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CYTE_ReconChk_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt
    left outer join /EY1/SAV_I_PR_GAAP_YB_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as GAAPYearMvmntLC on  GAAPYearMvmntLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and GAAPYearMvmntLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and GAAPYearMvmntLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax           = 'X'
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.FiscalYear,
      GLAccnt.ConsolidationDimension,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(GAAPLedgerTransactions) as ReconciliationCheck
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

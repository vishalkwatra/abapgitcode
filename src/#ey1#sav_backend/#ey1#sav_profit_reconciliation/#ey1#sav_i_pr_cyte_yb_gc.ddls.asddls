@AbapCatalog.sqlViewName: '/EY1/PRCYTEYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- CYTE - Year Mvmnt GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CYTE_YB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt
    left outer join /EY1/SAV_I_PR_GAAP_YB_GC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as PBTGILCYGC on  PBTGILCYGC.GLAccount         = GLAccnt.GLAccount
                                                                               and PBTGILCYGC.FiscalYear        = GLAccnt.FiscalYear
                                                                               and PBTGILCYGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                               and GLAccnt.ProfitBeforeTax      = ''


{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.FiscalYear,
  key GLAccnt.GLAccount,
  key AccountClassCode,
      GLAccnt.ConsolidationDimension,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GAAPLedgerTransactions as YearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GAAPLedgerTransactions as TransactionTotal

}
where
  GLAccnt.ProfitBeforeTax = ''
  and BsEqPl = 'P&L'

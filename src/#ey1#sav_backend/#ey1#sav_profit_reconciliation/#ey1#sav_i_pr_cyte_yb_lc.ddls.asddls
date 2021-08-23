@AbapCatalog.sqlViewName: '/EY1/PRCYTEYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- CYTE - Year Mvmnt LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CYTE_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt
    left outer join /EY1/SAV_I_PR_GAAP_YB_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as PBTGILCYLC on  PBTGILCYLC.GLAccount         = GLAccnt.GLAccount
                                                                               and PBTGILCYLC.FiscalYear        = GLAccnt.FiscalYear
                                                                               and PBTGILCYLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
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
      GLAccnt.LocalCurrency,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GAAPLedgerTransactions as YearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GAAPLedgerTransactions as TransactionTotal

}
where
  GLAccnt.ProfitBeforeTax = ''
  and BsEqPl = 'P&L'

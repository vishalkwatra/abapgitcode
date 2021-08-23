@AbapCatalog.sqlViewName: '/EY1/PRPTAYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- PTA Mvmnt GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_PTA_YB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
    
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                   as GLAccnt
                 
    left outer join /EY1/SAV_I_PR_PTA_Pmnt_YB_GC
                    ( p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention:$parameters.p_taxintention) as PTAPmntYBGC on  PTAPmntYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                  and PTAPmntYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and PTAPmntYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                  and GLAccnt.ProfitBeforeTax       = 'X'
                                                                                  and BsEqPl                        = 'P&L'
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
      cast(0 as abap.curr( 23, 2 )) as PTATransactionsPL,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PTATransactionsPmnt           as PTATransactionsPmnt,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PTATransactionsPmnt           as TransactionTotal
}
where
      GLAccnt.ProfitBeforeTax = 'X'
  and BsEqPl                  = 'P&L'

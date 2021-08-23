@AbapCatalog.sqlViewName: '/EY1/PRG2SYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- G2S Year Mvmnt GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_G2S_YB_GC with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                     as GLAccnt
    left outer join /EY1/SAV_I_PR_G2S_PL_YB_GC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention)     as G2SPLYBGC   on  G2SPLYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and G2SPLYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and G2SPLYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax     = 'X'
                                                                                    and BsEqPl != 'P&L'
    left outer join /EY1/SAV_I_PR_G2S_Pmnt_YB_GC
                        ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention) as G2SPmntYBGC on  G2SPmntYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and G2SPmntYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and G2SPmntYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax       = 'X'
                                                                                    and BsEqPl != 'P&L'
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
      G2SLedgerPL                                                             as G2SPLYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      G2SLedgerPmnt                                                           as G2SPmntYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast (case when G2SLedgerPL is null then G2SLedgerPmnt
                 when G2SLedgerPmnt is null then G2SLedgerPL
                 else G2SLedgerPL + G2SLedgerPmnt  end as abap.curr( 23, 2 )) as TransactionTotal

}
where
      GLAccnt.ProfitBeforeTax = 'X'
  and BsEqPl != 'P&L'

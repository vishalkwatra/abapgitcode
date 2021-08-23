@AbapCatalog.sqlViewName: '/EY1/PRS2TYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T Year Mvmnt GC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_S2T_YB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                     as GLAccnt
    left outer join /EY1/SAV_I_PR_S2T_PL_YB_GC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention)     as S2TPLYBGC   on  S2TPLYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and S2TPLYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and S2TPLYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax     = 'X'
                                                                                    and BsEqPl != 'P&L'
    left outer join /EY1/SAV_I_PR_S2T_Pmnt_YB_GC
                        ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention) as S2TPmntYBGC on  S2TPmntYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and S2TPmntYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and S2TPmntYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
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
      S2TLedgerPL                                                             as S2TPLYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TLedgerPmnt                                                           as S2TPmntYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast (case when S2TLedgerPL is null then S2TLedgerPmnt
                 when S2TLedgerPmnt is null then S2TLedgerPL
                 else S2TLedgerPL + S2TLedgerPmnt  end as abap.curr( 23, 2 )) as TransactionTotal

}
where
      GLAccnt.ProfitBeforeTax = 'X'
  and BsEqPl != 'P&L'

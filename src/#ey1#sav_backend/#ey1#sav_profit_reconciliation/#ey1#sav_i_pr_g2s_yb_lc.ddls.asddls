@AbapCatalog.sqlViewName: '/EY1/PRG2SYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- G2S Year Mvmnt LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_G2S_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                     as GLAccnt
    left outer join /EY1/SAV_I_PR_G2S_PL_YB_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention)     as G2SPLYBLC   on  G2SPLYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and G2SPLYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and G2SPLYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax     = 'X'
                                                                                    and BsEqPl != 'P&L'
    left outer join /EY1/SAV_I_PR_G2S_Pmnt_YB_LC
                        ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention) as G2SPmntYBLC on  G2SPmntYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and G2SPmntYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and G2SPmntYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
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
      GLAccnt.LocalCurrency,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SLedgerPL                                                             as G2SPLYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SLedgerPmnt                                                           as G2SPmntYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when G2SLedgerPL is null then G2SLedgerPmnt
                 when G2SLedgerPmnt is null then G2SLedgerPL
                 else G2SLedgerPL + G2SLedgerPmnt  end as abap.curr( 23, 2 )) as TransactionTotal

}
where
      GLAccnt.ProfitBeforeTax = 'X'
  and BsEqPl != 'P&L'

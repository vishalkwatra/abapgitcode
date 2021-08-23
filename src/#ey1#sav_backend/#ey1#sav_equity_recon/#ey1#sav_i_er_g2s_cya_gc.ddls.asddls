@AbapCatalog.sqlViewName: '/EY1/ERG2SCYAGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S CYA Values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_CYA_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear)               as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_YB_PL_GC(p_toperiod:$parameters.p_toperiod,
                                               p_ryear:$parameters.p_ryear,
                                               p_taxintention: $parameters.p_taxintention )  as G2SPL on  G2SPL.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                      and G2SPL.GLAccount                    = GLAcc.GLAccount
                                                                                                      and G2SPL.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                      and G2SPL.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                      and G2SPL.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_G2S_YB_Pmt_GC(p_toperiod:$parameters.p_toperiod,
                                                p_ryear:$parameters.p_ryear,
                                                p_taxintention: $parameters.p_taxintention ) as G2SPM on  G2SPM.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                      and G2SPM.GLAccount                    = GLAcc.GLAccount
                                                                                                      and G2SPM.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                      and G2SPM.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                      and G2SPM.GroupCurrency                = GLAcc.GroupCurrency
{

  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key GLAcc.AccountClassCode,
  key GLAcc.ConsolidationDimension,
  key GLAcc.FiscalYear,

      @Semantics.currencyCode: 'true'
      GLAcc.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmtYearBalance,

      GLAcc.BsEqPl,
      GLAcc.TaxEffected,
      GLAcc.PBT,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast(case when PlYearBalance is null then PmtYearBalance *-1
                when PmtYearBalance is null then PlYearBalance*-1
                else (PlYearBalance+PmtYearBalance)*-1 end as abap.curr( 23, 2 )) as G2SCYABalance

}
where
  (
        BsEqPl      = 'EQ'
    and TaxEffected = 'X'
    and PBT         = 'X'
  )
  or(
        BsEqPl      = 'BS'
  )

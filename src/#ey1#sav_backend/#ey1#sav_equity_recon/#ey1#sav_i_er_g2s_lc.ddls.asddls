@AbapCatalog.sqlViewName: '/EY1/ERG2SLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER G2S LC values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_LC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear)                 as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_OB_LC(p_ryear:$parameters.p_ryear,
                                            p_taxintention: $parameters.p_taxintention )       as G2SOB    on  G2SOB.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SOB.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SOB.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SOB.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SOB.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_G2S_YB_PLBETP_LC(p_toperiod:$parameters.p_toperiod,
                                                   p_ryear:$parameters.p_ryear,
                                                   p_taxintention: $parameters.p_taxintention) as G2SPL    on  G2SPL.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SPL.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SPL.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SPL.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SPL.LocalCurrency                = GLAcc.LocalCurrency
    left outer join /EY1/SAV_I_ER_G2S_YB_PmBETP_LC(p_toperiod:$parameters.p_toperiod,
                                                   p_ryear:$parameters.p_ryear,
                                                   p_taxintention: $parameters.p_taxintention) as G2SPM    on  G2SPM.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SPM.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SPM.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SPM.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SPM.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_G2S_CYA_LC(p_toperiod:$parameters.p_toperiod,
                                             p_ryear:$parameters.p_ryear,
                                             p_taxintention: $parameters.p_taxintention)       as G2SCYA   on  G2SCYA.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SCYA.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SCYA.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SCYA.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SCYA.LocalCurrency                = GLAcc.LocalCurrency
    left outer join /EY1/SAV_I_ER_G2S_YB_Equi_LC(p_toperiod:$parameters.p_toperiod,
                                                 p_ryear:$parameters.p_ryear,
                                                 p_taxintention: $parameters.p_taxintention)   as G2SEQ    on  G2SEQ.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SEQ.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SEQ.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SEQ.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SEQ.LocalCurrency                = GLAcc.LocalCurrency
    left outer join /EY1/SAV_I_ER_G2S_YB_Othr_LC(p_toperiod:$parameters.p_toperiod,
                                                 p_ryear:$parameters.p_ryear,
                                                 p_taxintention: $parameters.p_taxintention)   as G2SOther on  G2SOther.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SOther.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SOther.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SOther.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SOther.LocalCurrency                = GLAcc.LocalCurrency
    left outer join /EY1/SAV_I_ER_G2S_CB_LC(p_toperiod:$parameters.p_toperiod,
                                            p_ryear:$parameters.p_ryear,
                                            p_taxintention: $parameters.p_taxintention)        as G2SCB    on  G2SCB.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                           and G2SCB.GLAccount                    = GLAcc.GLAccount
                                                                                                           and G2SCB.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                           and G2SCB.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                           and G2SCB.LocalCurrency                = GLAcc.LocalCurrency
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key GLAcc.AccountClassCode,
  key GLAcc.ConsolidationDimension,
  key GLAcc.FiscalYear,

      @Semantics.currencyCode: 'true'
      GLAcc.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SOB.G2SAdjustAmt,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SPYA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SPL.PlYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SPM.PmtYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SCYABalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SEQ.EqTotalYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SOther.OthrTotalYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SCTA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      G2SCB.CBYearBalance,

      cast ('Local' as abap.char(5)) as CurrencyType,

      GLAcc.BsEqPl,
      GLAcc.TaxEffected,
      GLAcc.PBT
}

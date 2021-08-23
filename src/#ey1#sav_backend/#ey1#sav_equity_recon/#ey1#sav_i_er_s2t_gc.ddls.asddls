@AbapCatalog.sqlViewName: '/EY1/ERS2TGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER S2T GC values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc

    left outer join /EY1/SAV_I_ER_S2T_OB_GC(p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention )              as S2TOB    on  S2TOB.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TOB.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TOB.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TOB.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TOB.GroupCurrency                = GLAcc.GroupCurrency

    left outer join /EY1/SAV_I_ER_S2T_YB_PLBETP_GC(
                      p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention )            as S2TPL    on  S2TPL.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TPL.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TPL.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TPL.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TPL.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_S2T_YB_PmBETP_GC(
                       p_toperiod:$parameters.p_toperiod,
                       p_ryear:$parameters.p_ryear ,
                       p_taxintention:$parameters.p_taxintention )           as S2TPM    on  S2TPM.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TPM.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TPM.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TPM.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TPM.GroupCurrency                = GLAcc.GroupCurrency

    left outer join /EY1/SAV_I_ER_S2T_CYA_GC(
                         p_toperiod:$parameters.p_toperiod,
                         p_ryear:$parameters.p_ryear ,
                         p_taxintention:$parameters.p_taxintention )         as S2TCYA   on  S2TCYA.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TCYA.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TCYA.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TCYA.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TCYA.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_S2T_YB_Equi_GC(
                         p_toperiod:$parameters.p_toperiod,
                         p_ryear:$parameters.p_ryear ,
                         p_taxintention:$parameters.p_taxintention )         as S2TEQ    on  S2TEQ.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TEQ.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TEQ.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TEQ.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TEQ.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_S2T_YB_Othr_GC(
                             p_toperiod:$parameters.p_toperiod,
                             p_ryear:$parameters.p_ryear ,
                             p_taxintention:$parameters.p_taxintention )     as S2TOther on  S2TOther.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TOther.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TOther.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TOther.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TOther.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_S2T_CB_GC(
                                 p_toperiod:$parameters.p_toperiod,
                                 p_ryear:$parameters.p_ryear ,
                                 p_taxintention:$parameters.p_taxintention ) as S2TCB    on  S2TCB.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TCB.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TCB.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TCB.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TCB.GroupCurrency                = GLAcc.GroupCurrency
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
      S2TOB.S2TAdjustAmt,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TPYA,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TPL.PlYearBalance,


      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TPM.PmtYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TCYABalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TEQ.EqTotalYearBalance,


      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TOther.OthrTotalYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TCTA,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TCB.CBYearBalance,

      cast ('Group' as abap.char(5)) as CurrencyType,

      GLAcc.BsEqPl,
      GLAcc.TaxEffected,
      GLAcc.PBT


}

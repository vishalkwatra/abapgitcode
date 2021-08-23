@AbapCatalog.sqlViewName: '/EY1/ERSTYBEBELC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T YB Eq BS, Eq, TE, PBT values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_YB_EqBETP_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc
    left outer join   /EY1/SAV_I_ER_S2T_YB_Eq_LC( p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention)          as S2T on  S2T.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                   and S2T.GLAccount                    = GLAcc.GLAccount
                                                                                   and S2T.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                   and S2T.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                   and S2T.LocalCurrency                = GLAcc.LocalCurrency
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqYearBalance * -1 as EqTotalYearBalance,
      @Semantics.currencyCode: true
      GLAcc.LocalCurrency,
      BsEqPl,
      TaxEffected,
      PBT
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

@AbapCatalog.sqlViewName: '/EY1/ERS2TCYALC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T CYA Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_CYA_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc

    left outer join /EY1/SAV_I_ER_S2T_YB_PL_LC(
                     p_toperiod:$parameters.p_toperiod ,
                     p_ryear:$parameters.p_ryear ,
                     p_taxintention:$parameters.p_taxintention )             as S2TPL on  S2TPL.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                        and S2TPL.GLAccount                    = GLAcc.GLAccount
                                                                                        and S2TPL.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                        and S2TPL.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                        and S2TPL.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_S2T_YB_Pmt_LC(
                      p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention )            as S2TPM on  S2TPM.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                        and S2TPM.GLAccount                    = GLAcc.GLAccount
                                                                                        and S2TPM.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                        and S2TPM.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                        and S2TPM.LocalCurrency                = GLAcc.LocalCurrency
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
      PlYearBalance,


      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmtYearBalance,

      GLAcc.BsEqPl,
      GLAcc.TaxEffected,
      GLAcc.PBT,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast(case when PlYearBalance is null then PmtYearBalance *-1
           when   PmtYearBalance is null then PlYearBalance*-1
             else (PlYearBalance+PmtYearBalance)*-1 end as abap.curr( 23, 2 )) as S2TCYABalance

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

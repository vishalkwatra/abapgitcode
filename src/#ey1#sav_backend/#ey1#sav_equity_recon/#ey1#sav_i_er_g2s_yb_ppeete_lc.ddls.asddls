@AbapCatalog.sqlViewName: '/EY1/ERGSPPEETLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB PL Pmt Eq EQTE Sum Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_PPEETE_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_YB_PL_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as G2SPl   on  G2SPl.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                          and G2SPl.GLAccount                    = GLAcc.GLAccount
                                                                                          and G2SPl.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                          and G2SPl.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                          and G2SPl.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_G2S_YB_Pmt_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as G2SPmnt on  G2SPmnt.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                          and G2SPmnt.GLAccount                    = GLAcc.GLAccount
                                                                                          and G2SPmnt.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                          and G2SPmnt.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                          and G2SPmnt.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_G2S_YB_Eq_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as G2SEq   on  G2SEq.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                          and G2SEq.GLAccount                    = GLAcc.GLAccount
                                                                                          and G2SEq.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                          and G2SEq.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                          and G2SEq.LocalCurrency                = GLAcc.LocalCurrency


{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GLAcc.LocalCurrency,
      BsEqPl,
      TaxEffected,
      PBT,


      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when PlYearBalance is null then cast (0 as abap.curr( 23, 2))
      else PlYearBalance *-1 end as PlYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when PmtYearBalance is null then cast (0 as abap.curr( 23, 2))
      else PmtYearBalance*-1 end as PmtYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when EqYearBalance is null then cast (0 as abap.curr( 23, 2))
      else EqYearBalance*-1 end  as EqYearBalance

      //@Semantics.amount.currencyCode: 'LocalCurrency'

      // PlYearBalance+PmtYearBalance+EqYearBalance as EQTotalYearBalance

}
where

      BsEqPl      = 'EQ'
  and TaxEffected = 'X'

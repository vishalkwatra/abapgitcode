@AbapCatalog.sqlViewName: '/EY1/ERSTYOPPELC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T YB Other PL Pmt and Eq Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_YB_OPLPmE_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc

    left outer join /EY1/SAV_I_ER_S2T_YB_OPL_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as S2TOPl   on  S2TOPl.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TOPl.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TOPl.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TOPl.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TOPl.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_S2T_YB_OPmt_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as S2TOPmnt on  S2TOPmnt.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TOPmnt.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TOPmnt.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TOPmnt.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TOPmnt.LocalCurrency                = GLAcc.LocalCurrency

    left outer join /EY1/SAV_I_ER_S2T_YB_OEqui_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as S2TOEq   on  S2TOEq.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                           and S2TOEq.GLAccount                    = GLAcc.GLAccount
                                                                                           and S2TOEq.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                           and S2TOEq.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                           and S2TOEq.LocalCurrency                = GLAcc.LocalCurrency


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
      case when oPlYearBalance is null then cast (0 as abap.curr( 23, 2))
      else oPlYearBalance *-1 end as OPlYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when oPmtYearBalance is null then cast (0 as abap.curr( 23, 2))
      else oPmtYearBalance*-1 end as OPmtYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when oEqYearBalance is null then cast (0 as abap.curr( 23, 2))
      else oEqYearBalance*-1 end  as OEqYearBalance

      //@Semantics.amount.currencyCode: 'LocalCurrency'

      // PlYearBalance+PmtYearBalance+EqYearBalance as EQTotalYearBalance

}
where

  (
        BsEqPl      = 'EQ'
    and TaxEffected = 'X'
  )
  or(
        BsEqPl      = 'BS'
  )

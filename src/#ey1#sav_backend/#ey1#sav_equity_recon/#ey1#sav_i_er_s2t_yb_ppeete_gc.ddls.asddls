@AbapCatalog.sqlViewName: '/EY1/ERSTPPEETGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T YB PL Pmt Eq EQTE Sum Values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_YB_PPEETE_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc

    left outer join /EY1/SAV_I_ER_S2T_YB_PL_GC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as S2TPl   on  S2TPl.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                          and S2TPl.GLAccount                    = GLAcc.GLAccount
                                                                                          and S2TPl.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                          and S2TPl.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                          and S2TPl.GroupCurrency                = GLAcc.GroupCurrency

    left outer join /EY1/SAV_I_ER_S2T_YB_Pmt_GC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as S2TPmnt on  S2TPmnt.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                          and S2TPmnt.GLAccount                    = GLAcc.GLAccount
                                                                                          and S2TPmnt.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                          and S2TPmnt.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                          and S2TPmnt.GroupCurrency                = GLAcc.GroupCurrency

    left outer join /EY1/SAV_I_ER_S2T_YB_Eq_GC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as S2TEq   on  S2TEq.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                          and S2TEq.GLAccount                    = GLAcc.GLAccount
                                                                                          and S2TEq.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                          and S2TEq.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                          and S2TEq.GroupCurrency                = GLAcc.GroupCurrency


{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GLAcc.GroupCurrency,
      BsEqPl,
      TaxEffected,
      PBT,


      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PlYearBalance is null then cast (0 as abap.curr( 23, 2))
      else PlYearBalance end  as PlYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PmtYearBalance is null then cast (0 as abap.curr( 23, 2))
      else PmtYearBalance end as PmtYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when EqYearBalance is null then cast (0 as abap.curr( 23, 2))
      else EqYearBalance end  as EqYearBalance

      //@Semantics.amount.currencyCode: 'GroupCurrency'

      // PlYearBalance+PmtYearBalance+EqYearBalance as EQTotalYearBalance

}
where

      BsEqPl      = 'EQ'
  and TaxEffected = 'X'

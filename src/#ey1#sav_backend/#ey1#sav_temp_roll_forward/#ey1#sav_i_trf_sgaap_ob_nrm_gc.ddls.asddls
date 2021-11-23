@AbapCatalog.sqlViewName: '/EY1/ISGOBNMRGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize Values of OB GC'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_TRF_SGAAP_OB_NRM_GC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
      p_toperiod     : poper
  as select distinct from /EY1/SAV_I_GlAcc_TRF_MD
                          ( p_ryear:$parameters.p_ryear )              as GLAccnt

    left outer join       /EY1/SAV_I_TRF_SGAAP_OBPLNR_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod ) as SGaapPl   on  SGaapPl.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapPl.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_OBPmNR_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod  ) as SGaapPmnt on  SGaapPmnt.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapPmnt.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_OBEqNR_GC
                    (  p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod  ) as SGaapEq   on  SGaapEq.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapEq.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      //      GLAccnt.AccountClassCode,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when EqOpeningBalance is null then PlaceholderCurrency
      else EqOpeningBalance end   as EqOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PlOpeningBalance is null then PlaceholderCurrency
      else PlOpeningBalance end   as PlOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PmntOpeningBalance is null then PlaceholderCurrency
      else PmntOpeningBalance end as PmntOpeningBalance

}

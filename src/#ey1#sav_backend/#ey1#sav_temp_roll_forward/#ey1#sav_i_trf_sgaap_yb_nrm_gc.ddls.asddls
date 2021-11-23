@AbapCatalog.sqlViewName: '/EY1/ISGYBNRMGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to normalize values of current year - GC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_TRF_SGAAP_YB_NRM_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select distinct from /EY1/SAV_I_GlAcc_TRF_MD
                          ( p_ryear:$parameters.p_ryear )              as GLAccnt

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_PL_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapPl    on  RGaapPl.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapPl.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapPl.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_PMT_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapPmnt  on  RGaapPmnt.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapPmnt.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapPmnt.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_EQ_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapEq    on  RGaapEq.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapEq.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapEq.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_OPL_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapOPl   on  RGaapOPl.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapOPl.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapOPl.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_OPM_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapOPmnt on  RGaapOPmnt.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapOPmnt.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapOPmnt.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_OEQ_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapOEq   on  RGaapOEq.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapOEq.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapOEq.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      //      GLAccnt.ConsolidationLedger,
      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      //      //Tax Rates
      //      GaapOBRate,
      //      GaapCBRate,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PlYearBalance is null then PlaceholderCurrency
      else PlYearBalance end    as PlYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PmntYearBalance is null then PlaceholderCurrency
      else PmntYearBalance end  as PmntYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when EqYearBalance is null then PlaceholderCurrency
      else EqYearBalance end    as EqYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when OPlYearBalance is null then PlaceholderCurrency
      else OPlYearBalance end   as OPlYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when OPmntYearBalance is null then PlaceholderCurrency
      else OPmntYearBalance end as OPmntYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when OEqYearBalance is null then PlaceholderCurrency
      else OEqYearBalance end   as OEqYearBalance

}

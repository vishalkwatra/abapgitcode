@AbapCatalog.sqlViewName: '/EY1/ISGYBNRMLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to normalize values of current year - LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_TRF_SGAAP_YB_NRM_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention
  as select distinct from /EY1/SAV_I_GlAcc_TRF_MD
                          ( p_ryear:$parameters.p_ryear )                  as GLAccnt

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_PL_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )   as SGaapPl    on  SGaapPl.GLAccount         = GLAccnt.GLAccount
                                                                                         and SGaapPl.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and SGaapPl.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_PMT_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )   as SGaapPmnt  on  SGaapPmnt.GLAccount         = GLAccnt.GLAccount
                                                                                         and SGaapPmnt.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and SGaapPmnt.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_EQ_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )   as SGaapEq    on  SGaapEq.GLAccount         = GLAccnt.GLAccount
                                                                                         and SGaapEq.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and SGaapEq.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_OPL_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )   as SGaapOPl   on  SGaapOPl.GLAccount         = GLAccnt.GLAccount
                                                                                         and SGaapOPl.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and SGaapOPl.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_OPM_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )   as SGaapOPmnt on  SGaapOPmnt.GLAccount         = GLAccnt.GLAccount
                                                                                         and SGaapOPmnt.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and SGaapOPmnt.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_SGAAP_YB_OEQ_LC
                    ( p_toperiod :$parameters.p_toperiod,
                            p_ryear:$parameters.p_ryear,
                            p_taxintention :$parameters.p_taxintention ) as SGaapOEq   on  SGaapOEq.GLAccount         = GLAccnt.GLAccount
                                                                                         and SGaapOEq.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and SGaapOEq.ConsolidationUnit = GLAccnt.ConsolidationUnit
  //    left outer join /EY1/SAV_I_Tax_Rates
  //                    (p_toperiod :$parameters.p_toperiod,
  //                        p_ryear:$parameters.p_ryear)                 as TaxRate    on  TaxRate.ConsolidationUnit = GLAccnt.ConsolidationUnit
  //                                                                                   and TaxRate.FiscalYear        = GLAccnt.FiscalYear
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      //      //Tax Rates
      //      StatOBRate,
      //      StatCBRate,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when PlYearBalance is null then PlaceholderCurrency
      else PlYearBalance end    as PlYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when PmntYearBalance is null then PlaceholderCurrency
      else PmntYearBalance end  as PmntYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when EqYearBalance is null then PlaceholderCurrency
      else EqYearBalance end    as EqYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when OPlYearBalance is null then PlaceholderCurrency
      else OPlYearBalance end   as OPlYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when OPmntYearBalance is null then PlaceholderCurrency
      else OPmntYearBalance end as OPmntYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case when OEqYearBalance is null then PlaceholderCurrency
      else OEqYearBalance end   as OEqYearBalance

}

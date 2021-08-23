@AbapCatalog.sqlViewName: '/EY1/ISGCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd SGAAP CB - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_CB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                          ( p_ryear:$parameters.p_ryear )            as GLAccnt

    left outer join /EY1/SAV_I_TRF_SGAAP_CB_PL_GC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )   as SGaapCBPlGC   on  SGaapCBPlGC.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapCBPlGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and SGaapCBPlGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_CB_PMT_GC
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapCBPmntGC on  SGaapCBPmntGC.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapCBPmntGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and SGaapCBPmntGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_CB_EQ_GC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )   as SGaapCBEqGC   on  SGaapCBEqGC.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapCBEqGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and SGaapCBEqGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,
      //  key AccountClassCode,
      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: 'true'
      GLAccnt.GroupCurrency,

      //RGaapCBPlGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlClosingBalance,

      //RGaapCBPmntGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmntClosingBalance,

      //RGaapCBEqGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqClosingBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqClosingBalance + PlClosingBalance + PmntClosingBalance as ClosingBalance
      //      cast (case when EqClosingBalance is null then cast( case when PlClosingBalance is null then PmntClosingBalance
      //                                                                 when PmntClosingBalance is null then PlClosingBalance
      //                                                                 else PlClosingBalance + PmntClosingBalance end as abap.curr(23,2))
      //
      //                 when PlClosingBalance is null then cast( case when PmntClosingBalance is null then EqClosingBalance
      //                                                              when EqClosingBalance is null then PmntClosingBalance
      //                                                              else PmntClosingBalance + EqClosingBalance end as abap.curr(23,2))
      //
      //                 when PmntClosingBalance is null then cast(case when EqClosingBalance is null then PlClosingBalance
      //                                                              when PlClosingBalance is null then EqClosingBalance
      //                                                              else EqClosingBalance + PlClosingBalance end as abap.curr(23,2))
      //
      //                 else EqClosingBalance + PlClosingBalance + PmntClosingBalance  end as abap.curr( 23, 2 )) as ClosingBalance
}

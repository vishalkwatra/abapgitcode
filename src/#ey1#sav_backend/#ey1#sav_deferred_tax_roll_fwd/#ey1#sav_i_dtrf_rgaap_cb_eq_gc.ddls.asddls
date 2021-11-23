@AbapCatalog.sqlViewName: '/EY1/DTRFRCBEQGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward CB EQ - GC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_RGAAP_CB_EQ_GC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention
    

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                   as GLAccnt

    left outer join /EY1/SAV_I_DTRF_RGAAP_OB_GC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapOBGC on  RGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                and RGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_YB_GC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapYBGC on  RGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                and RGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and RGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA
                    ( p_ryear:$parameters.p_ryear,
                    p_taxintention  : $parameters.p_taxintention,
                    p_toperiod : $parameters.p_toperiod,
                    p_rbunit    : $parameters.p_rbunit )                as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                and RGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_CTA
                    ( p_ryear:$parameters.p_ryear )                as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_TRC
                    ( p_ryear:$parameters.p_ryear )                as RGaapTRC  on  RGaapTRC.GLAccount         = GLAccnt.GLAccount
                                                                                and RGaapTRC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and RGaapTRC.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: 'true'
      GLAccnt.GroupCurrency,

      //RGaapOBGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance,

      //RGaapYBGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OEqYearBalance,

      //RGaapPYA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOeq,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      CTAEq,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      TRCEq,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance + EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq as EqClosingBalance
      //      cast (case when EqOpeningBalance is null then cast( case when EqYearBalance is null then OEqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq
      //                                                                 when OEqYearBalance is null then EqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq
      //                                                                 else EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq end as abap.curr(23,2))
      //
      //                 when EqYearBalance is null then cast( case when OEqYearBalance is null then EqOpeningBalance + PYAEq + PYAOeq + CTAEq + TRCEq
      //                                                              when EqOpeningBalance is null then OEqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq
      //                                                              else OEqYearBalance + EqOpeningBalance + PYAEq + PYAOeq + CTAEq + TRCEq end as abap.curr(23,2))
      //
      //                 when OEqYearBalance is null then cast(case when EqOpeningBalance is null then EqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq
      //                                                              when EqYearBalance is null then EqOpeningBalance + PYAEq + PYAOeq + CTAEq + TRCEq
      //                                                              else EqOpeningBalance + EqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq end as abap.curr(23,2))
      //
      //                 else EqOpeningBalance + EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq end as abap.curr( 23, 2 )) as EqClosingBalance
}

@AbapCatalog.sqlViewName: '/EY1/IRGCBEQGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd RGAAP CB for EQ - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_CB_EQ_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

    left outer join /EY1/SAV_I_TRF_RGAAP_OB_GC
                    (  p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                           p_toperiod :$parameters.p_toperiod )        as RGaapOBGC on  RGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_YB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapYBGC on  RGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_PYA_GC
                     (  p_ryear:$parameters.p_ryear,
                           p_taxintention :$parameters.p_taxintention,
                           p_toperiod :$parameters.p_toperiod )        as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                      as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit

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

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance + EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq as EqClosingBalance
      //      cast (case when EqOpeningBalance is null then cast( case when EqYearBalance is null then OEqYearBalance + PYAEq + PYAOeq + CTAEq
      //                                                                 when OEqYearBalance is null then EqYearBalance + PYAEq + PYAOeq + CTAEq
      //                                                                 else EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq end as abap.curr(23,2))
      //
      //                 when EqYearBalance is null then cast( case when OEqYearBalance is null then EqOpeningBalance + PYAEq + PYAOeq + CTAEq
      //                                                              when EqOpeningBalance is null then OEqYearBalance + PYAEq + PYAOeq + CTAEq
      //                                                              else OEqYearBalance + EqOpeningBalance + PYAEq + PYAOeq + CTAEq end as abap.curr(23,2))
      //
      //                 when OEqYearBalance is null then cast(case when EqOpeningBalance is null then EqYearBalance + PYAEq + PYAOeq + CTAEq
      //                                                              when EqYearBalance is null then EqOpeningBalance + PYAEq + PYAOeq + CTAEq
      //                                                              else EqOpeningBalance + EqYearBalance + PYAEq + PYAOeq + CTAEq end as abap.curr(23,2))
      //
      //                 else EqOpeningBalance + EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq end as abap.curr( 23, 2 )) as EqClosingBalance
}

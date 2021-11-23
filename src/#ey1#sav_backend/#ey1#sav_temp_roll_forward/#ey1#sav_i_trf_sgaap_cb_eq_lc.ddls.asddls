@AbapCatalog.sqlViewName: '/EY1/ISGCBEQLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd SGAAP CB for EQ - LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_CB_EQ_LC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

    left outer join /EY1/SAV_I_TRF_SGAAP_OB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                           p_toperiod :$parameters.p_toperiod )        as SGaapOBLC on  SGaapOBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapOBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_YB_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as SGaapYBLC on  SGaapYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and SGaapYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_PYA_LC
                     ( p_ryear:$parameters.p_ryear,
                           p_taxintention :$parameters.p_taxintention,
                           p_toperiod :$parameters.p_toperiod  )       as SGaapPYA  on  SGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                      as SGaapCTA  on  SGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                    and SGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and SGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit

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
      GLAccnt.LocalCurrency,

      //SGaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqOpeningBalance,

      //SGaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OEqYearBalance,

      //SGaapPYA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOeq,

      //SGaapCTA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      CTAEq,

      @Semantics.amount.currencyCode: 'LocalCurrency'
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

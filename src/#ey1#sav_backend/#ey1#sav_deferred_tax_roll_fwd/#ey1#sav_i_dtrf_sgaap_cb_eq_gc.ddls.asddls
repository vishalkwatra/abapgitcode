@AbapCatalog.sqlViewName: '/EY1/DTRFSCBEQGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward CB EQ - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_SGAAP_CB_EQ_GC

  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                   as GLAccnt

    left outer join /EY1/SAV_I_DTRF_SGAAP_OB_GC
                    ( p_rbunit: $parameters.p_rbunit,
                      p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapOBGC on  SGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_YB_GC
                    ( p_rbunit: $parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapYBGC on  SGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_PYA
                    (p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention: $parameters.p_taxintention,
                      p_rbunit: $parameters.p_rbunit )             as SGaapPYA  on  SGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear )                as SGaapCTA  on  SGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_TRC
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear )                as SGaapTRC  on  SGaapTRC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapTRC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapTRC.ConsolidationUnit = GLAccnt.ConsolidationUnit
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

      //SGaapOBGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance,

      //SGaapYBGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OEqYearBalance,

      //SGaapPYA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOeq,

      //SGaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      CTAEq,

      //SGaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      TRCEq,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance + EqYearBalance + OEqYearBalance + PYAEq + PYAOeq + CTAEq + TRCEq as EqClosingBalance

}

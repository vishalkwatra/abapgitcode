@AbapCatalog.sqlViewName: '/EY1/DTRFSCBPLLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward CB P&L - LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_SGAAP_CB_PL_LC

  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                     as GLAccnt

    left outer join /EY1/SAV_I_DTRF_SGAAP_OB_LC
                    ( p_rbunit:$parameters.p_rbunit,
                      p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapOBLC on  SGaapOBLC.GLAccount         = GLAccnt.GLAccount
                                                                                  and SGaapOBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_YB_LC
                    ( p_rbunit:$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapYBLC on  SGaapYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                  and SGaapYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and SGaapYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_PYA
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention: $parameters.p_taxintention,
                      p_rbunit: $parameters.p_rbunit )                  as SGaapPYA  on  SGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                  and SGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and SGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear )                  as SGaapCTA  on  SGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                  and SGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and SGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_TRC
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear )                  as SGaapTRC  on  SGaapTRC.GLAccount         = GLAccnt.GLAccount
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
      GLAccnt.LocalCurrency,

      //SGaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlOpeningBalance,

      //SGaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYearBalance,

      //SGaapPYA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPl,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpl,

      //SGaapCTA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      CTAPl,

      //SGaapTRC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      TRCPl,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance + PlOpeningBalance + OPlYearBalance + PYAPl + PYAOpl + CTAPl + TRCPl as PlClosingBalance
}

@AbapCatalog.sqlViewName: '/EY1/DTRFRCBPLLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward CB P&L - LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_RGAAP_CB_PL_LC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                         as GLAccnt

    left outer join /EY1/SAV_I_DTRF_RGAAP_OB_LC
                    ( p_rbunit :$parameters.p_rbunit,
                          p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapOBLC on  RGaapOBLC.GLAccount         = GLAccnt.GLAccount
                                                                                      and RGaapOBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_YB_LC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapYBLC on  RGaapYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                      and RGaapYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and RGaapYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA
                    (p_ryear:$parameters.p_ryear,
                    p_taxintention  : $parameters.p_taxintention,
                    p_toperiod : $parameters.p_toperiod,
                    p_rbunit    : $parameters.p_rbunit )                       as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                      and RGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_CTA
                    ( p_ryear:$parameters.p_ryear )                      as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                      and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_TRC
                    ( p_ryear:$parameters.p_ryear )                      as RGaapTRC  on  RGaapTRC.GLAccount         = GLAccnt.GLAccount
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
      GLAccnt.LocalCurrency,

      //RGaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlOpeningBalance,

      //RGaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYearBalance,
      
      //RGaapPYA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPl,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpl,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      CTAPl,

      //RGaapTRC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      TRCPl,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance + PlOpeningBalance + OPlYearBalance + PYAPl + PYAOpl + CTAPl + TRCPl as PlClosingBalance

}

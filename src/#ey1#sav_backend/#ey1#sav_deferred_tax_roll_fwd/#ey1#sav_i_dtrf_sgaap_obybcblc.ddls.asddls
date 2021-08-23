@AbapCatalog.sqlViewName: '/EY1/DTRFSOYCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View DTRF SGAAP OB YB CB - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_SGAAP_OBYBCBLC
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                   as GLAccnt

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
    left outer join /EY1/SAV_I_DTRF_SGAAP_CB_LC
                    ( p_rbunit:$parameters.p_rbunit,
                      p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapCBLC on  SGaapCBLC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapCBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapCBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_PYA
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear )                as SGaapPYA  on  SGaapPYA.GLAccount         = GLAccnt.GLAccount
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
  association [1] to /ey1/ggaap_tas as _GGaapTAS on _GGaapTAS.mandt = $session.client

{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,
  key AccountClassCode,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency               as MainCurrency,

      // TAX Rates
      SGaapOBLC.StatOBRate,
      SGaapOBLC.StatCBRate,

      //RGaapOBLC
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance + PlOpeningBalance as OpeningBalanceDTADTL,

      //RGaapYBLC
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance + EqYearBalance       as TempTransType,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance + OPlYearBalance     as TempOtherTransType,

      //RGaapCBLC
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalanceDTADTL,

      // CTA
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTA,

      // PYA
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAOeq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYA,

      //TRC
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRCPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRCEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRC,

      _GGaapTAS.classification            as Classification,

      cast ('Local' as abap.char(5))      as CurrencyType,

      BsEqPl,
      CNC,
      TaxEffected,

      //Association
      _GGaapTAS
}

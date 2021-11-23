@AbapCatalog.sqlViewName: '/EY1/DTRFROYCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward RGAAP OB YB CB - LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_RGAAP_OBYBCBLC
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

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
    left outer join /EY1/SAV_I_DTRF_RGAAP_CB_LC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )       as RGaapCBLC on  RGaapCBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA
                    ( p_ryear:$parameters.p_ryear,
                      p_taxintention : $parameters.p_taxintention,
                    p_toperiod : $parameters.p_toperiod,
                    p_rbunit    : $parameters.p_rbunit )                 as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_CTA
                    ( p_ryear:$parameters.p_ryear )                    as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_TRC
                    ( p_ryear:$parameters.p_ryear )                    as RGaapTRC  on  RGaapTRC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapTRC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapTRC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    inner join      /EY1/Sav_I_Group_Unit_Mapping                      as IMap      on IMap.ConsoidationUnit = GLAccnt.ConsolidationUnit

{     //GLAccnt
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
      RGaapOBLC.GaapOBRate,
      RGaapOBLC.GaapCBRate,

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

      IMap.Classification,

      cast ('Local' as abap.char(5))      as CurrencyType,

      BsEqPl,
      CNC,
      TaxEffected
}

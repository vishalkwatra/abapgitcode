@AbapCatalog.sqlViewName: '/EY1/DTRFROYCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward RGAAP OB YB CB - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_RGAAP_OBYBCBGC
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt

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
    left outer join /EY1/SAV_I_DTRF_RGAAP_CB_GC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapCBGC on  RGaapCBGC.GLAccount         = GLAccnt.GLAccount
                                                                              and RGaapCBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                              and RGaapCBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_GC
                    ( p_ryear:$parameters.p_ryear,
                    p_taxintention  : $parameters.p_taxintention,
                    p_toperiod : $parameters.p_toperiod,
                    p_rbunit    : $parameters.p_rbunit )              as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                              and RGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                              and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_CTA
                    ( p_ryear:$parameters.p_ryear )              as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                              and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                              and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_TRC
                    ( p_ryear:$parameters.p_ryear )              as RGaapTRC  on  RGaapTRC.GLAccount         = GLAccnt.GLAccount
                                                                              and RGaapTRC.FiscalYear        = GLAccnt.FiscalYear
                                                                              and RGaapTRC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    inner join      /EY1/Sav_I_Group_Unit_Mapping                as IMap      on IMap.ConsoidationUnit = GLAccnt.ConsolidationUnit

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
      GLAccnt.GroupCurrency               as MainCurrency,

      // TAX Rates
      RGaapOBGC.GaapOBRate,
      RGaapOBGC.GaapCBRate,

      //RGaapOBGC
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance + EqOpeningBalance as OpeningBalanceDTADTL,

      //RGaapYBGC
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqYearBalance + PlYearBalance       as TempTransType,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance + OPlYearBalance     as TempOtherTransType,

      //RGaapCBGC
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

      // TRC
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRCPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRCEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRC,

      IMap.Classification,

      cast ('Group' as abap.char(5))      as CurrencyType,

      BsEqPl,
      CNC,
      TaxEffected
}

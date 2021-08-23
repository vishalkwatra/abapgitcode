@AbapCatalog.sqlViewName: '/EY1/IRGOYCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP OB YB CB - LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_OBYBCB_LC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

    left outer join /EY1/SAV_I_TRF_RGAAP_OB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapOBLC on  RGaapOBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapOBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_YB_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapYBLC on  RGaapYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CB_LC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )       as RGaapCBLC on  RGaapCBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_PYA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                      as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapPYA.FiscalYear        = GLAccnt.FiscalYear
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
  key AccountClassCode,

      //GLAccnt.ConsolidationLedger,
      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      //@Semantics.currencyCode: true
      GLAccnt.LocalCurrency              as MainCurrency,

      //      // TAX Rates
      //      GaapOBRate,
      //      GaapCBRate,

      //RGaapOBLC
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      TempDiffOpeningBalance,

      //RGaapYBLC
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntYearBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqYearBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      OPlYearBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      OPmntYearBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      TempTransType,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      TempOtherTransType,

      //RGaapCBLC
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalance,

      // CTA
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTAPl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTAPmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTAEq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTA,

      // PYA
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYAPl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYAPmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYAEq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYAOpl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYAOpmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYAOeq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      RGaapPYA.PYA,

      //@Semantics.amount.currencyCode: 'MainCurrency'
      TempTransType + TempOtherTransType as CurrentYearMvmnt,
      //      cast( case when TempTransType is null then TempOtherTransType
      //                 when TempOtherTransType is null then TempTransType
      //                 else TempTransType + TempOtherTransType end as abap.curr(23,2)) as CurrentYearMvmnt,

      cast ('Local' as abap.char(5))     as CurrencyType,

      BsEqPl,
      TaxEffected
}

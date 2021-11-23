@AbapCatalog.sqlViewName: '/EY1/IRGOYCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP OB YB CB - GC'

@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_OBYBCB_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

    left outer join /EY1/SAV_I_TRF_RGAAP_OB_GC
                    (p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )         as RGaapOBGC  on  RGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_YB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapYBGC  on  RGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )            as RGaapCBGC  on  RGaapCBGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapCBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and RGaapCBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_PYA_GC
                    ( p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention,
                     p_toperiod  : $parameters.p_toperiod)             as RGaapPYAGC on  RGaapPYAGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and RGaapPYAGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                      as RGaapCTA   on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
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
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency              as MainCurrency,

      // TAX Rates
      //      GaapOBRate,
      //      GaapCBRate,

      //RGaapOBGC
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmntOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TempDiffOpeningBalance,

      //RGaapYBGC
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmntYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OPmntYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TempTransType,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TempOtherTransType,

      //RGaapCBGC
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmntClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalance,

      // CTA
      @Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTAPmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      RGaapCTA.CTA,

      // PYA
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAPmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYAOeq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PYABal+PYAOBal                     as PYA,


      @Semantics.amount.currencyCode: 'MainCurrency'
      TempTransType + TempOtherTransType as CurrentYearMvmnt,
      //      cast( case when TempTransType is null then TempOtherTransType
      //                 when TempOtherTransType is null then TempTransType
      //                 else TempTransType + TempOtherTransType end as abap.curr(23,2)) as CurrentYearMvmnt,


      cast ('Group' as abap.char(5))     as CurrencyType,

      BsEqPl,
      TaxEffected
}

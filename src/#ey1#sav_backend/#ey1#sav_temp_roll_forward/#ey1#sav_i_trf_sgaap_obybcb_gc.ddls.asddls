@AbapCatalog.sqlViewName: '/EY1/ISGOYCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP OB YB CB - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_OBYBCB_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

    left outer join /EY1/SAV_I_TRF_SGAAP_OB_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )         as SGaapOBGC  on  SGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and SGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_YB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as SGaapYBGC  on  SGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and SGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and SGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_CB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention  )            as SGaapCBGC  on  SGaapCBGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and SGaapCBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and SGaapCBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_PYA_GC
                    (  p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention,
                    p_toperiod :$parameters.p_toperiod )               as SGaapPYAGC on  SGaapPYAGC.GLAccount         = GLAccnt.GLAccount
                                                                                     and SGaapPYAGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                      as SGaapCTA   on  SGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                     and SGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and SGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
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
      CTAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAPmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTA,

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

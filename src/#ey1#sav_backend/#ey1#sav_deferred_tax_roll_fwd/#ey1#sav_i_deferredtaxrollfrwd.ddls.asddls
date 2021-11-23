@AbapCatalog.sqlViewName: '/EY1/SAVIDTRF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View  for Deferred Tax Roll Forward'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DeferredTaxRollFrwd
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_DTRF_RS_GAAP_Union( p_rbunit :$parameters.p_rbunit,
                                                p_toperiod :$parameters.p_toperiod,
                                                p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention ) as RSGaap
{ //RGaapUnion
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      @Semantics.currencyCode: true
      MainCurrency,

      //OB & CB Class
      OBClass,
      CBClass,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OpeningBalanceDTADTL,

      //Year Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OEqYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TempTransType,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TempOtherTransType,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CurrentYearMvmnt,

      //Closing Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalanceDTADTL,

      //CTA
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTA,

      //PYA
      @Semantics.amount.currencyCode: 'MainCurrency'
      // ( cast(( PYAPl * OBRate ) as abap.fltp) / 100.0 ) as PYAPl,
      PYAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      //( cast((PYAEq * OBRate ) as abap.fltp ) / 100.0 ) as PYAEq,
      PYAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      //( cast((PYAOpl * OBRate) as abap.fltp ) / 100.0 ) as PYAOpl,
      PYAOpl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      //( cast((PYAOeq * OBRate) as abap.fltp ) / 100.0 ) as PYAOeq,
      PYAOeq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      //( cast((PYA * OBRate) as abap.fltp ) / 100.0 ) as PYA,
      PYA,

      //TRC
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRCPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRCEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TRC,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      ReportingType
}
where
     EqOpeningBalance != 0
  or PlOpeningBalance != 0
  or OpeningBalanceDTADTL != 0
  or PlYearBalance != 0
  or EqYearBalance != 0
  or OPlYearBalance != 0
  or OEqYearBalance != 0
  or TempTransType != 0
  or TempOtherTransType != 0
  or CurrentYearMvmnt != 0
  or PlClosingBalance != 0
  or EqClosingBalance != 0
  or ClosingBalanceDTADTL != 0
  or CTAPl != 0
  or CTAEq != 0
  or CTA != 0
  or PYAPl != 0
  or PYAEq != 0
  or PYAOpl != 0
  or PYAOeq != 0
  or PYA != 0
  or TRCPl != 0
  or TRCEq != 0
  or TRC != 0

@AbapCatalog.sqlViewName: '/EY1/ITRF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Temp Roll Forward'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TempRollForward
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    //    p_specialperiod : zz1_specialperiod,
    p_rbunit       : fc_bunit
    
  as select from /EY1/SAV_I_TRF_RS_GAAP_Union( p_toperiod :$parameters.p_toperiod,
                                               p_ryear:$parameters.p_ryear,
                                               p_taxintention :$parameters.p_taxintention,
                                               p_rbunit:$parameters.p_rbunit ) as RSGaap
{ //RGaapUnion
  key ChartOfAccounts,
  key RSGaap.ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key RSGaap.FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      @Semantics.currencyCode: true
      MainCurrency,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmntOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TempDiffOpeningBalance,

      //Year Balance
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
      @Semantics.amount.currencyCode: 'MainCurrency'
      CurrentYearMvmnt,

      //Closing Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmntClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalance,

      //CTA
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAPl,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAPmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTAEq,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CTA,

      //PYA
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
      PYA,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      ReportingType
}

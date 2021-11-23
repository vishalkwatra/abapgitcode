@AbapCatalog.sqlViewName: '/EY1/IRSGUNION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP SGAAP Union'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RS_GAAP_Union
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit


  as select from /EY1/SAV_I_TRF_RGAAP_LCGC_Uni( p_toperiod :$parameters.p_toperiod,
                                                p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention,
                                                p_rbunit:$parameters.p_rbunit )
{ //ZEY_SAV_I_TRF_RGAAP_LCGC_UNION
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      // @Semantics.currencyCode: true
      MainCurrency,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      TempDiffOpeningBalance,

      //Year Balance
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
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CurrentYearMvmnt,

      //Closing Balance
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalance,

      //CTA
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTAPl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTAPmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTAEq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTA,

      //PYA
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAPl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAPmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAEq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAOeq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYA,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      cast ('RGAAP' as abap.char(5)) as ReportingType
}

union select from /EY1/SAV_I_TRF_SGAAP_LCGC_Uni( p_toperiod :$parameters.p_toperiod,
                                                 p_ryear:$parameters.p_ryear,
                                                 p_taxintention :$parameters.p_taxintention,
                                                 p_rbunit:$parameters.p_rbunit )
{ //ZEY_SAV_I_TRF_SGAAP_LCGC_UNION
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      //@Semantics.currencyCode: true
      MainCurrency,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntOpeningBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      TempDiffOpeningBalance,

      //Year Balance
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
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CurrentYearMvmnt,

      //Closing Balance
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PlClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PmntClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      EqClosingBalance,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      ClosingBalance,

      //CTA
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTAPl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTAPmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTAEq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      CTA,

      //PYA
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAPl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAPmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAEq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpl,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAOpmnt,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYAOeq,
      //@Semantics.amount.currencyCode: 'MainCurrency'
      PYA,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      cast ('SGAAP' as abap.char(5)) as ReportingType
}

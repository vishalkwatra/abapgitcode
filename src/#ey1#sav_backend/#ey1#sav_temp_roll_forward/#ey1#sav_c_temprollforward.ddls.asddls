@AbapCatalog.sqlViewName: '/EY1/CTRF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Temp Roll Forward'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION


define view /EY1/SAV_C_TempRollForward
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //p_specialperiod : zz1_specialperiod,
    @EndUserText.label: 'Tax Intention'
    @Consumption.defaultValue: '101'
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit
  as select from /EY1/SAV_I_TempRollForward
                 ( p_toperiod :$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention :$parameters.p_taxintention,
                   p_rbunit:$parameters.p_rbunit ) as TRF

  association [0..1] to /EY1/SAV_I_GlAccText    as _RAcct_Text   on  _RAcct_Text.GLAccount       = TRF.GLAccount
                                                                 and _RAcct_Text.Language        = $session.system_language
                                                                 and _RAcct_Text.ChartOfAccounts = TRF.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_AccClassText as _AccCode_Text on  _AccCode_Text.AccountClassCode = TRF.AccountClassCode
                                                                 and _AccCode_Text.Language         = $session.system_language

  association [0..1] to /EY1/SAV_I_FSItemText   as _FSItem_Text  on  _FSItem_Text.ConsolidationReportingItem   = TRF.FinancialStatementItem
                                                                 and _FSItem_Text.ConsolidationChartOfAccounts = TRF.ConsolidationChartofAccounts
                                                                 and _FSItem_Text.Language                     = $session.system_language
{ //TRF
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,

      @UI.lineItem: [{ position: 10 }]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Account'
  key GLAccount,

  key FiscalYear,

      @Consumption.semanticObject: 'AccountClass'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Acct Class'
  key AccountClassCode,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _AccCode_Text.AccountClassCodeText,

      @EndUserText.label: 'Account Description'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _RAcct_Text.GLAccountMdmText,

      ConsolidationDimension,
      FinancialStatementItem,

      @EndUserText.label: 'FS Item Description'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _FSItem_Text.ConsolidationRptgItemMdmText,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      MainCurrency,

      //Tax Rates
      @EndUserText.label: 'OB DT Rate'
      OBRate,
      @EndUserText.label: 'CB DT Rate'
      CBRate,

      //Opening Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'OB EQ'
      EqOpeningBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'OB P&L'
      PlOpeningBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'OB Permanent'
      PmntOpeningBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'OB Temp'
      TempDiffOpeningBalance,

      //Current Year Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY P&L'
      PlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY Permanent'
      PmntYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY EQ'
      EqYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY Other P&L'
      OPlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY Other Permanent'
      OPmntYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY Other EQ'
      OEqYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Current Year Movement'
      CurrentYearMvmnt,

      //Closing Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB P&L'
      PlClosingBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB Permanent'
      PmntClosingBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB EQ'
      EqClosingBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB Temp'
      ClosingBalance,

      //CTA
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CTA P&L'
      CTAPl,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CTA Permanent'
      CTAPmnt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CTA EQ'
      CTAEq,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CTA'
      CTA,

      //PYA
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA P&L'
      PYAPl,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA Permanent'
      PYAPmnt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA EQ'
      PYAEq,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA Other P&L'
      PYAOpl,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA Other Permanent'
      PYAOpmnt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA Other EQ'
      PYAOeq,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA'
      PYA,

      cast ('' as abap.char( 3 )) as PeriodFrom,
      cast ('' as abap.char( 3 )) as PeriodTo,
      cast (' ' as abap.char(4))  as Intention,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      ReportingType,

      // Associations
      _RAcct_Text,
      _AccCode_Text,
      _FSItem_Text
}

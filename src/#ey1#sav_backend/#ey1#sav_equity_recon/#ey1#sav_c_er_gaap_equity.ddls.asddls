@AbapCatalog.sqlViewName: '/EY1/CERGEQUITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch values of Gaap EQ section of ER'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ER_GAAP_Equity
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_GAAP_Equity(p_ryear:$parameters.p_ryear,
                                           p_fromperiod:$parameters.p_fromperiod,
                                           p_toperiod:$parameters.p_toperiod,
                                           p_taxintention: $parameters.p_taxintention) as GaapEquity

  association [0..1] to /EY1/SAV_I_GlAccText    as _RAcct_Text   on  _RAcct_Text.GLAccount       = GaapEquity.GLAccount
                                                                 and _RAcct_Text.Language        = $session.system_language
                                                                 and _RAcct_Text.ChartOfAccounts = GaapEquity.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_AccClassText as _AccCode_Text on  _AccCode_Text.AccountClassCode = GaapEquity.AccountClassCode
                                                                 and _AccCode_Text.Language         = $session.system_language

  association [0..1] to /EY1/SAV_I_FSItemText   as _FSItem_Text  on  _FSItem_Text.ConsolidationReportingItem   = GaapEquity.FinancialStatementItem
                                                                 and _FSItem_Text.ConsolidationChartOfAccounts = GaapEquity.ConsolidationChartofAccounts
                                                                 and _FSItem_Text.Language                     = $session.system_language
{ ///EY1/SAV_I_ER_GAAP_Equity
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,

      @Consumption.semanticObject: 'AccountClass'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Acct Class'
  key AccountClassCode,

      @UI.lineItem: [{ position: 10 }]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Account'
  key GLAccount,

      @EndUserText.label: 'Account Description'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _RAcct_Text.GLAccountMdmText,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _AccCode_Text.AccountClassCodeText,

      ConsolidationDimension,

      FinancialStatementItem,
      
      @EndUserText.label: 'FS Item Description'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _FSItem_Text.ConsolidationRptgItemMdmText,

      @Semantics.currencyCode: true
      @EndUserText.label: 'CCY'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Opening Balance'
      GaapOpeningBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @EndUserText.label: 'Prior Year Adjustments'
      cast ('' as abap.char( 3 )) as PYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @EndUserText.label: 'P&L'
      cast ('' as abap.char( 3 )) as ProfitLoss,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @EndUserText.label: 'Permanent'
      cast ('' as abap.char( 3 )) as Pmnt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Current Year Result'
      GaapMvmnt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'EQ'
      GaapEQ,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @EndUserText.label: 'Other'
      cast ('' as abap.char( 3 )) as Other,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CTA'
      GaapCTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Closing Balance'
      GaapClosingBalance,

      CurrencyType,

      cast ('' as abap.char( 3 )) as PeriodFrom,
      cast ('' as abap.char( 3 )) as PeriodTo,
      cast (' ' as abap.char(4))  as Intention,

      // Associations
      _RAcct_Text,
      _AccCode_Text,
      _FSItem_Text
}

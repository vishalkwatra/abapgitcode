@AbapCatalog.sqlViewName: '/EY1/SAVCDTRF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Deferred Tax Roll Forward'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_DeferredTaxRollFrwd
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
    
  as select from /EY1/SAV_I_DeferredTaxRollFrwd
                 ( p_rbunit :$parameters.p_rbunit,
                   p_toperiod :$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention :$parameters.p_taxintention ) as DTRF

  association [0..1] to /EY1/SAV_I_GlAccText    as _RAcct_Text   on  _RAcct_Text.GLAccount       = DTRF.GLAccount
                                                                 and _RAcct_Text.Language        = $session.system_language
                                                                 and _RAcct_Text.ChartOfAccounts = DTRF.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_AccClassText as _AccCode_Text on  _AccCode_Text.AccountClassCode = DTRF.AccountClassCode
                                                                 and _AccCode_Text.Language         = $session.system_language

  association [0..1] to /EY1/SAV_I_FSItemText   as _FSItem_Text  on  _FSItem_Text.ConsolidationReportingItem   = DTRF.FinancialStatementItem
                                                                 and _FSItem_Text.ConsolidationChartOfAccounts = DTRF.ConsolidationChartofAccounts
                                                                 and _FSItem_Text.Language                     = $session.system_language
{     //DTRF
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

      // OB & CB Class
      @EndUserText.label: 'OB Class'
      OBClass,
      @EndUserText.label: 'CB Class'
      CBClass,

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
      @EndUserText.label: 'OB DTA/DTL'
      OpeningBalanceDTADTL,

      //Current Year Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY P&L'
      PlYearBalance,
      //cast( 0 as abap.curr(23,2))    as PlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY EQ'
      EqYearBalance,
      //cast( 0 as abap.curr(23,2))    as EqYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY OTH P&L'
      OPlYearBalance,
      //cast( 0 as abap.curr(23,2))    as OPlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY OTH EQ'
      OEqYearBalance,
      //cast( 0 as abap.curr(23,2))    as OEqYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CY Mvmnt'
      CurrentYearMvmnt,
      //cast( 0 as abap.curr(23,2))    as CurrentYearMvmnt,

      //Closing Balance
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB P&L'
      PlClosingBalance,
      //cast( 0 as abap.curr(23,2))    as PlClosingBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB EQ'
      EqClosingBalance,
      //cast( 0 as abap.curr(23,2))    as EqClosingBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CB DTA/DTL'
      ClosingBalanceDTADTL,
      //cast( 0 as abap.curr(23,2))    as ClosingBalanceDTADTL,

      //CTA
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'CTA P&L'
      CTAPl,

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
      @EndUserText.label: 'PYA EQ'
      PYAEq,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA OTH P&L'
      PYAOpl,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA OTH EQ'
      PYAOeq,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PYA'
      PYA,

      //TRC
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TRC P&L'
      TRCPl,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TRC EQ'
      TRCEq,

      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TRC'
      TRC,

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

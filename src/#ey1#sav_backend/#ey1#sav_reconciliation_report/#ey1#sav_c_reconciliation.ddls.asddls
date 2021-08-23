@AbapCatalog.sqlViewName: '/EY1/CRECONLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C- View Reconciliation LC & GC'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

// oData publish annotation added to create new oData service - Used for Smart Chart
@OData.publish: true
@ObjectModel.representativeKey: 'FinancialStatementItem'
@ObjectModel.dataCategory: #TEXT

@UI.chart: [{ title: 'Title',
              chartType: #COLUMN,
              dimensions:  ['GLAccount'],
              measures:  [ 'GaapOpeningBalance'],
              dimensionAttributes: [ { dimension: 'GLAccount', role: #CATEGORY } ],
              measureAttributes: [{ measure: 'GaapOpeningBalance', role: #AXIS_1}] }]

define view /EY1/SAV_C_Reconciliation
  with parameters

    @EndUserText.label: 'Fiscal Year'
    @Consumption.valueHelpDefinition: [{ entity: { name: 'C_CnsldtnFiscalYearVH',
                                                   element: 'FiscalYear' } }]
    @Consumption.defaultValue: '2020'
    p_ryear        : gjahr,

    @EndUserText.label: 'Period From'
    @Consumption.defaultValue: '1'
    p_fromyb       : poper,

    @EndUserText.label: 'Period To'
    @Consumption.defaultValue: '12'
    p_toyb         : poper,

    @EndUserText.label: 'CTA Switch for P&L'
    @Consumption.defaultValue: 'X'
    p_switch       : char1,

    @EndUserText.label: 'Tax Intention'
    @Consumption.defaultValue: '101'
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_Recon_LC_GC( p_ryear: $parameters.p_ryear,
                                         p_fromyb: $parameters.p_fromyb,
                                         p_toyb: $parameters.p_toyb,
                                         p_switch: $parameters.p_switch,
                                         p_taxintention : $parameters.p_taxintention ) as GLAccnt

  association [0..1] to /EY1/SAV_I_GlAccText      as _rAcct_Text       on  _rAcct_Text.GLAccount       = GLAccnt.GLAccount
                                                                       and _rAcct_Text.Language        = $session.system_language
                                                                       and _rAcct_Text.ChartOfAccounts = GLAccnt.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_Acc_Class_Text as _AccCode_Text     on  _AccCode_Text.AccountClassCode = GLAccnt.AccountClassCode
                                                                       and _AccCode_Text.Language         = $session.system_language

  association [0..1] to /EY1/SAV_I_FSItemText     as _FSItem_Text      on  _FSItem_Text.ConsolidationReportingItem   = GLAccnt.FinancialStatementItem
                                                                       and _FSItem_Text.ConsolidationChartOfAccounts = GLAccnt.ConsolidationChartofAccounts
                                                                       and _FSItem_Text.Language                     = $session.system_language

//  association [0..1] to /EY1/SAV_I_ReadIntentVH   as _TaxIntentionText on  _TaxIntentionText.TaxIntention = $parameters.p_taxintention

{
      @UI.lineItem: [{ position: 10, label: 'FS Item'}]
      @Consumption.semanticObject: 'ConsolidationFinanceSItem'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element: ['ConsolidationRptgItemMdmText']
  key FinancialStatementItem,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Account'
      @UI.lineItem: [{ position: 20, label: 'GL Account'}]
      @ObjectModel.text.element: ['GLAccountMdmText']
  key GLAccount,

      @Consumption.semanticObject: 'AccountClass'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Acct Class'
  key AccountClassCode,

  key FiscalYear,

  key ChartOfAccounts,

  key ConsolidationChartofAccounts,

      @UI.lineItem: [{ position: 20 }]
      @EndUserText.label: 'FS Item Description'
      _FSItem_Text.ConsolidationRptgItemMdmText as ConsolidationRptgItemMdmText,

      ConsolidationUnit,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      @UI.lineItem: [{ position: 55 }]
      MainCurrency,

      //        'LC & GC' both fields are being passed into Service from UI as its a part of Smart filter.
      //        1 Field didn't existed in earlier, hence service failed.
      //        To resolve this, added a copy field with dummy name which will receive 'Blank' value as filter.
      //      @UI.hidden: true
      //      MainCurrency1,

      // TEXT   -   RACCOUNT
      @EndUserText.label: 'Account Description'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _rAcct_Text.GLAccountMdmText,

      //    GAAP DATA
      @UI.lineItem: [{ position: 60 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'GAAP OB'
      GaapOpeningBalance,

      @UI.lineItem: [{ position: 70 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'GAAP Mvmnt'
      GaapYearBalance,

      @UI.lineItem: [{ position: 80 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'GAAP CTA'
      GaapCTA,

      @UI.lineItem: [{ position: 90 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'GAAP CB'
      GaapClosingBalance,

      // GAAP to STAT
      @UI.lineItem: [{ position: 100 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S P&L'
      GaapToStatPL,

      @UI.lineItem: [{ position: 110 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S PERM'
      GaapToStatPmnt,

      @UI.lineItem: [{ position: 120 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S EQ'
      GaapToStatEQ,

      @UI.lineItem: [{ position: 130 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S OTH P&L'
      GaapToStatOtherPL,

      @UI.lineItem: [{ position: 140 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S OTH PERM'
      GaapToStatOtherPmnt,

      @UI.lineItem: [{ position: 150 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S OTH EQ'
      GaapToStatOtherEQ,

      @UI.lineItem: [{ position: 160 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'G2S CTA'
      G2SCTA,

      //    STAT DATA
      @UI.lineItem: [{ position: 170 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'STAT OB'
      StatOpeningBalance,

      @UI.lineItem: [{ position: 180 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'STAT PYA'
      StatPYA,

      @UI.lineItem: [{ position: 190 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'STAT Mvmnt'
      StatYearBalance,

      @UI.lineItem: [{ position: 200 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'STAT CTA'
      StatCTA,

      @UI.lineItem: [{ position: 210 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'STAT CB'
      StatClosingBalance,

      // STAT to TAX
      @UI.lineItem: [{ position: 220 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T P&L'
      StatToTaxPL,

      @UI.lineItem: [{ position: 230 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T PERM'
      StatToTaxPmnt,

      @UI.lineItem: [{ position: 240 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T EQ'
      StatToTaxEQ,

      @UI.lineItem: [{ position: 250 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T OTH P&L'
      StatToTaxOtherPL,

      @UI.lineItem: [{ position: 260 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T OTH PERM'
      StatToTaxOtherPmnt,

      @UI.lineItem: [{ position: 270 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T OTH EQ'
      StatToTaxOtherEQ,

      @UI.lineItem: [{ position: 280 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'S2T CTA'
      S2TCTA,

      // TAX DATA
      @UI.lineItem: [{ position: 290 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TAX OB'
      TaxOpeningBalance,

      @UI.lineItem: [{ position: 300 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TAX PYA'
      TaxPYA,

      @UI.lineItem: [{ position: 310 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TAX Mvmnt'
      TaxYearBalance,

      @UI.lineItem: [{ position: 320 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TAX CTA'
      TaxCTA,

      @UI.lineItem: [{ position: 330 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'TAX CB'
      TaxClosingBalance,

      @UI.lineItem: [{ position: 340 }]
      @Semantics.amount.currencyCode: 'MainCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'PTA'
      TaxPTA,

//      //      @UI.lineItem: [{ position: 350 }]
//      //      @DefaultAggregation: #SUM
//      @EndUserText.label: 'Tax Intention'
//      $parameters.p_taxintention                as TaxIntention,
//
//      //      @UI.lineItem: [{ position: 360 }]
//      //      @Semantics.amount.currencyCode: 'MainCurrency'
//      @DefaultAggregation: #SUM
//      @EndUserText.label: 'Tax Intention Description'
//      _TaxIntentionText.IntentDescription       as TaxIntentionText,

      BsEqPl,
      CurrType,
      Period,

      cast ('' as abap.char( 3 ))               as PeriodFrom,
      cast ('' as abap.char( 3 ))               as PeriodTo,
      cast (' ' as abap.char(4))                as Intention,

      // Texts
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _AccCode_Text.AccountClassCodeText,

      // Associations
      _rAcct_Text,
      _AccCode_Text,
      _FSItem_Text
//      _TaxIntentionText
}

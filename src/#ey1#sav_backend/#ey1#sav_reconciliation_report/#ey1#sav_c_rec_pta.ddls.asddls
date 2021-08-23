@AbapCatalog.sqlViewName: '/EY1/CRECONPTA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C- View Reconciliation PTA Table'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_Rec_PTA
  as select from /EY1/SAV_I_Rec_PTA as PTA
  association [0..1] to A_CnsldtnUnitT          as _CnsldtnUnitT    on  $projection.ConsolidationUnit = _CnsldtnUnitT.ConsolidationUnit
                                                                    and _CnsldtnUnitT.Language        = $session.system_language

  association [0..1] to /EY1/SAV_I_GlAccText    as _rAcct_Text      on  _rAcct_Text.GLAccount       = PTA.GLAccount
                                                                    and _rAcct_Text.Language        = $session.system_language
                                                                    and $projection.ChartofAccounts = _rAcct_Text.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_FSItemText   as _FSItem_Text     on  _FSItem_Text.ConsolidationReportingItem = PTA.FinancialStatementItem
                                                                    and _FSItem_Text.Language                   = $session.system_language

  association [0..1] to /EY1/SAV_I_ReadIntentVH as _TaxIntentionText on _TaxIntentionText.TaxIntention = PTA.TaxIntention
{
      //ZEY_SAV_IPTA
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @EndUserText.label: 'Document Number'
  key PTA.DocumentNumber,

  key PTA.LineItem,

      @EndUserText.label: 'Company Code'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key PTA.ConsolidationUnit,

  key PTA.FiscalYear,

      _CnsldtnUnitT.ConsolidationUnitText as ConsolidationUnitDescription,

      PTA.GLAccount,
      _rAcct_Text.GLAccountMdmText,

      PTA.ChartofAccounts,

      PTA.FinancialStatementItem,
      _FSItem_Text.ConsolidationRptgItemMdmText,

      @EndUserText.label: 'Posting Date'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      PTA.PostingDate,

      PTA.PostingDateDisplay,

      @EndUserText.label: 'Posting Period'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      PTA.FiscalPeriod,

      @EndUserText.label: 'Tax Intention'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element: ['TaxIntentionText']
      PTA.TaxIntention as TaxIntention,
      
      @EndUserText.label: 'Tax Intention Description'
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _TaxIntentionText.IntentDescription as TaxIntentionText,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Local Currency'
      PTA.AmountInLocalCurrency,

      @Semantics.currencyCode: true
      PTA.LocalCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      @DefaultAggregation: #SUM
      @EndUserText.label: 'Group Currency'
      PTA.AmountInGroupCurrency,

      @Semantics.currencyCode: true
      PTA.GroupCurrency,
      PTA.Text,

      // Associations
      _CnsldtnUnitT,
      _rAcct_Text,
      _FSItem_Text,
      _TaxIntentionText
}

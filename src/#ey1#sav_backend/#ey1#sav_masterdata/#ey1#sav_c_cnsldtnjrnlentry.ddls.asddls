@AbapCatalog.sqlViewName: '/EY1/CJRNLENTRY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View for Consolidation Journal Entries'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION
@ObjectModel.compositionRoot:true
@ObjectModel.usageType: {
  sizeCategory: #XXL,
  serviceQuality: #D,
  dataClass: #MIXED
}


define view /EY1/SAV_C_CnsldtnJrnlEntry
  with parameters
    @Consumption.defaultValue: '$'
    P_ConsolidationUnitHierarchy : fincs_hryid,
    @Consumption.defaultValue: '$'
    P_ConsolidationPrftCtrHier   : fincs_hryid,
    @Consumption.defaultValue: '$'
    P_ConsolidationSegmentHier   : fincs_hryid,
    P_KeyDate                    : sydate
  as select from I_MatrixCnsldtnJrnlEntr( P_ConsolidationUnitHierarchy: $parameters.P_ConsolidationUnitHierarchy,
                   P_ConsolidationPrftCtrHier:   $parameters.P_ConsolidationPrftCtrHier,
                   P_ConsolidationSegmentHier:   $parameters.P_ConsolidationSegmentHier,
                   P_KeyDate:                    $parameters.P_KeyDate )

  //Extension Association
  association [0..1] to /EY1/SAV_I_JournalEntryItem   as _Extension_acdoca           on  $projection.Ledger                      = _Extension_acdoca.SourceLedger
                                                                                     and $projection.CompanyCode                 = _Extension_acdoca.CompanyCode
                                                                                     and $projection.FiscalYear                  = _Extension_acdoca.FiscalYear
                                                                                     and $projection.ConsolidationDocumentNumber = _Extension_acdoca.AccountingDocument
                                                                                     and $projection.ConsolidationPostingItem    = _Extension_acdoca.LedgerGLLineItem

  association [0..1] to I_CnsldtnLedgerT              as _LedgerText                 on  $projection.ConsolidationLedger = _LedgerText.ConsolidationLedger
                                                                                     and _LedgerText.Language            = $session.system_language

  association [0..1] to I_CnsldtnGroupT               as _GroupText                  on  $projection.ConsolidationGroup     = _GroupText.ConsolidationGroup
                                                                                     and $projection.ConsolidationDimension = _GroupText.ConsolidationDimension
                                                                                     and _GroupText.Language                = $session.system_language

  association [0..1] to I_CnsldtnVersionT             as _VersionText                on  $projection.ConsolidationVersion = _VersionText.ConsolidationVersion
                                                                                     and _VersionText.Language            = $session.system_language

  association [0..1] to I_CnsldtnPeriodModeText       as _PeriodModeText             on  $projection.PeriodMode   = _PeriodModeText.PeriodMode
                                                                                     and _PeriodModeText.Language = $session.system_language

  //  association [0..1] to I_FiscalYearPeriodText        as _FisicalYearPeriodText      on  $projection.FiscalYear          = _FisicalYearPeriodText.FiscalYear
  //                                                                                     and $projection.FiscalPeriod        = _FisicalYearPeriodText.FiscalPeriod
  //                                                                                     and $projection.FiscalYearVariant   = _FisicalYearPeriodText.FiscalYearVariant
  //                                                                                     and _FisicalYearPeriodText.Language = $session.system_language

  association [0..1] to I_CnsldtnUnitForEliminationT  as _CnsldtnUnitEliminatedText  on  $projection.ConsolidationDimension   = _CnsldtnUnitEliminatedText.ConsolidationDimension
                                                                                     and $projection.ConsolidationUnitForElim = _CnsldtnUnitEliminatedText.ConsolidationUnit
                                                                                     and _CnsldtnUnitEliminatedText.Language  = $session.system_language

  association [1..1] to I_CnsldtnUnitT                as _CnsldtnUnitText            on  $projection.ConsolidationDimension = _CnsldtnUnitText.ConsolidationDimension
                                                                                     and $projection.ConsolidationUnit      = _CnsldtnUnitText.ConsolidationUnit
                                                                                     and _CnsldtnUnitText.Language          = $session.system_language

  association [0..1] to I_CnsldtnUnitT                as _PartnerUnitText            on  $projection.ConsolidationDimension   = _PartnerUnitText.ConsolidationDimension
                                                                                     and $projection.PartnerConsolidationUnit = _PartnerUnitText.ConsolidationUnit
                                                                                     and _PartnerUnitText.Language            = $session.system_language

  association [0..1] to I_CnsldtnControllingAreaT     as _ControllingAreaText        on  $projection.ControllingArea   = _ControllingAreaText.ControllingArea
                                                                                     and _ControllingAreaText.Language = $session.system_language

  association [0..1] to I_CnsldtnProfitCenterForElimT as _ProfitCenterEliminatedT    on  $projection.ControllingArea             = _ProfitCenterEliminatedT.ControllingArea
                                                                                     and $projection.ConsolidationPrftCtrForElim = _ProfitCenterEliminatedT.ProfitCenter
                                                                                     and _ProfitCenterEliminatedT.Language       = $session.system_language

  association [0..1] to I_CnsldtnProfitCenterT        as _ProfitCenterText           on  $projection.ControllingArea = _ProfitCenterText.ControllingArea
                                                                                     and $projection.ProfitCenter    = _ProfitCenterText.ProfitCenter
                                                                                     and _ProfitCenterText.Language  = $session.system_language

  association [0..1] to I_CnsldtnProfitCenterT        as _PartnerProfitCenterText    on  $projection.ControllingArea       = _PartnerProfitCenterText.ControllingArea
                                                                                     and $projection.PartnerProfitCenter   = _PartnerProfitCenterText.ProfitCenter
                                                                                     and _PartnerProfitCenterText.Language = $session.system_language

  association [0..1] to I_CnsldtnSegmentForElimT      as _CnsldtnSegmentEliminatedT  on  $projection.ConsolidationSegmentForElim = _CnsldtnSegmentEliminatedT.Segment
                                                                                     and _CnsldtnSegmentEliminatedT.Language     = $session.system_language

  association [0..1] to I_CnsldtnSegmentT             as _SegmentText                on  $projection.Segment   = _SegmentText.Segment
                                                                                     and _SegmentText.Language = $session.system_language

  association [0..1] to I_CnsldtnSegmentT             as _PartnerSegmentText         on  $projection.PartnerSegment   = _PartnerSegmentText.Segment
                                                                                     and _PartnerSegmentText.Language = $session.system_language

  association [0..1] to I_CnsldtnChartOfAccountsT     as _ChartOfAccountsText        on  $projection.ConsolidationChartOfAccounts = _ChartOfAccountsText.ConsolidationChartOfAccounts
                                                                                     and _ChartOfAccountsText.Language            = $session.system_language

  association [0..1] to I_CnsldtnFinStmntItemText     as _FinancialStatementItemText on  $projection.ConsolidationChartOfAccounts = _FinancialStatementItemText.ConsolidationChartOfAccounts
                                                                                     and $projection.FinancialStatementItem       = _FinancialStatementItemText.FinancialStatementItem
                                                                                     and _FinancialStatementItemText.Language     = $session.system_language

  association [0..1] to I_CnsldtnDocumentTypeT        as _DocumentTypeText           on  $projection.ConsolidationDimension    = _DocumentTypeText.ConsolidationDimension
                                                                                     and $projection.ConsolidationDocumentType = _DocumentTypeText.ConsolidationDocumentType
                                                                                     and _DocumentTypeText.Language            = $session.system_language

  association [0..1] to I_CnsldtnPostingLevelT        as _PostingLevelText           on  $projection.PostingLevel   = _PostingLevelText.PostingLevel
                                                                                     and _PostingLevelText.Language = $session.system_language

{
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnLedgerVH',
                  element: 'ConsolidationLedger' }
      }
      //@Consumption.filter.mandatory: true
      @ObjectModel.text.element: 'ConsolidationLedgerName'
  key ConsolidationLedger,

      @Consumption.filter.hidden:true
  key ConsolidationDimension,

      @Semantics.fiscal.year: true
  key FiscalYear,

  key ConsolidationDocumentNumber,

  key ConsolidationPostingItem,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'I_CnsldtnGroupWithEmptyValue',
                  element: 'ConsolidationGroup' },
        additionalBinding: { localElement: 'ConsolidationDimension',
                             element:      'ConsolidationDimension' }
      }
      @Consumption.filter.mandatory: true
      @Consumption.filter.defaultValue: ''
      @ObjectModel.text.element: 'ConsolidationGroupMediumText'
  key ConsolidationGroup,

      @Semantics.fiscal.period: true
      @ObjectModel.text.element: 'PostingPeriod'
  key FiscalPeriod,

      @Consumption.valueHelpDefinition: {
        entity: { name:    'I_CnsldtnPeriodMode',
                  element: 'PeriodMode' }
      }
      @Consumption.filter.mandatory: true
      @Consumption.filter.defaultValue: 'PER'
      @ObjectModel.text.element: 'PeriodModeText'
  key PeriodMode,

      @Semantics.fiscal.year: true
  key ReferenceFiscalYear,

  key CompanyCode,

      Ledger,

      _LedgerText.ConsolidationLedgerName,

      _GroupText.ConsolidationGroupMediumText,

      _PeriodModeText.PeriodModeText,

      GLRecordType,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnVersionVH',
                  element: 'ConsolidationVersion' }
      }
      @Consumption.filter.mandatory: true
      @ObjectModel.text.element: ['ConsolidationVersionText']
      ConsolidationVersion,

      _VersionText.ConsolidationVersionText,

      @Semantics.currencyCode:true
      @ObjectModel.foreignKey.association: '_TransactionCurrency'
      TransactionCurrency,

      @Semantics.currencyCode:true
      @ObjectModel.foreignKey.association: '_LocalCurrency'
      LocalCurrency,

      @Semantics.currencyCode:true
      @ObjectModel.foreignKey.association: '_GroupCurrency'
      GroupCurrency,

      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnit'
      BaseUnit,

      //      @Consumption.valueHelpDefinition: {
      //        entity: { name:    'I_FiscalCalendarDate',
      //                  element: 'FiscalYearPeriod' },
      //        additionalBinding: [{ localElement: 'FiscalYear',
      //                              element:      'FiscalYear' },
      //                            { localElement: 'FiscalPeriod',
      //                              element:      'FiscalPeriod' },
      //                            { localElement: 'FiscalYearVariant',
      //                              element:      'FiscalYearVariant' }]
      //      }
      //      @Consumption.filter.mandatory: true
      //      @ObjectModel.text.element: 'FiscalPeriodName'
      @Semantics.fiscal.yearPeriod: true
      cast(FiscalYearPeriod as fins_jahrper)            as FiscalYearPeriod,

      //      _FisicalYearPeriodText.FiscalPeriodName,

      @Semantics.fiscal.yearVariant: true
      FiscalYearVariant,

      @Semantics.fiscal.period: true
      PostingFiscalPeriod,

      @Consumption.filter.hidden:true
      DocumentCategory,

      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnDocumentTypeVH',
                  element: 'ConsolidationDocumentType' }
      }
      @ObjectModel.text.element: 'ConsolidationDocumentTypeText'
      ConsolidationDocumentType,

      _DocumentTypeText.ConsolidationDocumentTypeText,

      @Consumption.filter.hidden:true
      DebitCreditCode,

      Company,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnUnitValueHelp',
                  element: 'ConsolidationUnit' },
        additionalBinding: { localElement: 'ConsolidationDimension',
                             element:      'ConsolidationDimension' }
      }
      @ObjectModel.text.element: ['ConsolidationUnitMdmText']
      ConsolidationUnit,

      _CnsldtnUnitText.ConsolidationUnitMdmText,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnUnitForEliminationVH',
                  element: 'ConsolidationUnit' },
        additionalBinding: { localElement: 'ConsolidationDimension',
                             element:      'ConsolidationDimension' }
      }
      @ObjectModel.text.association: '_CnsldtnUnitEliminatedText'
      ConsolidationUnitForElim,

      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnChartOfAccountsVH',
                  element: 'ConsolidationChartOfAccounts' }
      }
      //@Consumption.filter.mandatory: true
      @ObjectModel.text.element: 'ConsolidationChartOfAcctsText'
      ConsolidationChartOfAccounts,

      _ChartOfAccountsText.ConsolidationChartOfAcctsText,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnFinStmntItemVH',
                  element: 'FinancialStatementItem' },
        additionalBinding: { localElement: 'ConsolidationChartOfAccounts',
                             element:      'ConsolidationChartOfAccounts' }
      }
      @ObjectModel.text.element: 'FinancialStatementItemMdmText'
      FinancialStatementItem,

      _FinancialStatementItemText.FinancialStatementItemMdmText,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnUnitValueHelp',
                  element: 'ConsolidationUnit' },
        additionalBinding: { localElement: 'ConsolidationDimension',
                             element:      'ConsolidationDimension' }
      }
      @ObjectModel.text.element: 'PartnerCnsldtnUnitMediumText'
      PartnerConsolidationUnit,

      _PartnerUnitText.ConsolidationUnitMdmText         as PartnerCnsldtnUnitMediumText,

      SubItemCategory,

      SubItem,

      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnPostingLevelVH',
                  element: 'PostingLevel' }
      }
      @ObjectModel.text.element: 'PostingLevelText'
      PostingLevel,

      _PostingLevelText.PostingLevelText,

      ConsolidationApportionment,

      CurrencyConversionsDiffType,

      @Semantics.fiscal.year: true
      ConsolidationAcquisitionYear,

      @Semantics.fiscal.year: true
      ConsolidationAcquisitionPeriod,

      InvesteeConsolidationUnit,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'TransactionCurrency'} }
      AmountInTransactionCurrency,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'LocalCurrency'} }
      @ObjectModel.text.element: ['AmountInLocalCurrency']
      AmountInLocalCurrency,

      @DefaultAggregation: #SUM
      @Semantics: { amount : {currencyCode: 'GroupCurrency'} }
      @ObjectModel.text.element: ['AmountInGroupCurrency']
      AmountInGroupCurrency,

      @DefaultAggregation: #SUM
      @Semantics: { quantity : {unitOfMeasure : 'BaseUnit'} }
      QuantityInBaseUnit,

      DocumentItemText,

      ConsolidationPostgItemAutoFlag,

      BusinessTransactionType,

      PostingDate,

      CurrencyTranslationDate,

      RefConsolidationDocumentNumber,

      RefConsolidationPostingItem,

      RefConsolidationDocumentType,

      RefBusinessTransactionType,

      CreationDateTime,

      CreationDate,

      CreationTime,

      UserID,

      ReverseDocument,

      ReversedDocument,

      InvestmentActivityType,

      InvestmentActivity,

      ConsolidationDocReversalYear,

      ReferenceDocumentType,

      ReferenceDocumentContext,

      LogicalSystem,

      ChartOfAccounts,

      GLAccount,

      AssignmentReference,

      CostCenter,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnProfitCenterVH',
                  element: 'ProfitCenter' },
        additionalBinding: { localElement: 'ControllingArea',
                             element:      'ControllingArea' }
      }
      @ObjectModel.text.element: 'ProfitCenterName'
      ProfitCenter,

      _ProfitCenterText.AdditionalMasterDataText        as ProfitCenterName,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnProfitCenterForElimVH',
                  element: 'ProfitCenter' },
        additionalBinding: { localElement: 'ControllingArea',
                             element:      'ControllingArea' }
      }
      @ObjectModel.text.association: '_ProfitCenterEliminatedT'
      ConsolidationPrftCtrForElim,

      FunctionalArea,

      BusinessArea,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnCtrlgAreaVH',
                  element: 'ControllingArea' }
      }
      @ObjectModel.text.element: 'ControllingAreaName'
      ControllingArea,

      _ControllingAreaText.AdditionalMasterDataText     as ControllingAreaName,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnSegmentVH',
                  element: 'Segment' }
      }
      @ObjectModel.text.element: 'SegmentName'
      Segment,

      _SegmentText.AdditionalMasterDataText             as SegmentName,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnSegmentForElimVH',
                  element: 'Segment' }
      }
      @ObjectModel.text.association: '_CnsldtnSegmentEliminatedT'
      ConsolidationSegmentForElim,

      PartnerCostCenter,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnProfitCenterVH',
                  element: 'ProfitCenter' },
        additionalBinding: { localElement: 'ControllingArea',
                             element:      'ControllingArea' }
      }
      @ObjectModel.text.element: 'PartnerProfitCenterName'
      PartnerProfitCenter,

      _PartnerProfitCenterText.AdditionalMasterDataText as PartnerProfitCenterName,

      PartnerFunctionalArea,

      PartnerBusinessArea,

      PartnerCompany,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      @Consumption.valueHelpDefinition: {
        entity: { name:    'C_CnsldtnSegmentVH',
                  element: 'Segment' }
      }
      @ObjectModel.text.element: 'PartnerSegmentName'
      PartnerSegment,

      _PartnerSegmentText.AdditionalMasterDataText      as PartnerSegmentName,

      OrderID,

      Customer,

      Supplier,

      Material,

      MaterialGroup,

      Plant,

      FinancialTransactionType,

      Project,

      BillingDocumentType,

      SalesOrganization,

      DistributionChannel,

      OrganizationDivision,

      SoldMaterial,

      SoldProduct,

      SoldProductGroup,

      CustomerGroup,

      CustomerSupplierCountry,

      CustomerSupplierIndustry,

      SalesDistrict,

      BillToParty,

      ShipToParty,

      CustomerSupplierCorporateGroup,

      @Consumption.filter.hidden:true
      _LedgerText,

      @Consumption.filter.hidden:true
      _GroupText,

      @Consumption.filter.hidden:true
      _VersionText,

      @Consumption.filter.hidden:true
      _PeriodModeText,

      @Consumption.filter.hidden:true
      _CnsldtnUnitEliminatedText,

      @Consumption.filter.hidden:true
      _CnsldtnUnitText,

      @Consumption.filter.hidden:true
      _PartnerUnitText,

      @Consumption.filter.hidden:true
      _ControllingAreaText,

      @Consumption.filter.hidden:true
      _ProfitCenterText,

      @Consumption.filter.hidden:true
      _PartnerProfitCenterText,

      @Consumption.filter.hidden:true
      _SegmentText,

      @Consumption.filter.hidden:true
      _PartnerSegmentText,

      @Consumption.filter.hidden:true
      _ChartOfAccountsText,

      @Consumption.filter.hidden:true
      _FinancialStatementItemText,

      @Consumption.filter.hidden:true
      _DocumentTypeText,

      @Consumption.filter.hidden:true
      _PostingLevelText,

      @Consumption.filter.hidden:true
      _CnsldtnSegmentEliminatedT,

      @Consumption.filter.hidden:true
      _ProfitCenterEliminatedT,

      @Consumption.filter.hidden:true
      _Ledger,

      @Consumption.filter.hidden:true
      _Dimension,

      @Consumption.filter.hidden:true
      _CnsldtnGroup,

      @Consumption.filter.hidden:true
      _CompanyCode,

      @Consumption.filter.hidden:true
      _Version,

      @Consumption.filter.hidden:true
      _Company,

      @Consumption.filter.hidden:true
      _CnsldtnUnit,

      @Consumption.filter.hidden:true
      _ChartOfAccounts,

      @Consumption.filter.hidden:true
      _FinStmntItm,

      @Consumption.filter.hidden:true
      _PartnerUnit,

      @Consumption.filter.hidden:true
      _SubItemCategory,

      @Consumption.filter.hidden:true
      _SubItem,

      @Consumption.filter.hidden:true
      _DebitCreditCode,

      @Consumption.filter.hidden:true
      _DocumentType,

      @Consumption.filter.hidden:true
      _PostingLevel,

      @Consumption.filter.hidden:true
      _InvesteeUnit,

      @Consumption.filter.hidden:true
      _Apportionment,

      @Consumption.filter.hidden:true
      _CrcyCnvrsnDiffType,

      @Consumption.filter.hidden:true
      _TransactionCurrency,

      @Consumption.filter.hidden:true
      _LocalCurrency,

      @Consumption.filter.hidden:true
      _GroupCurrency,

      @Consumption.filter.hidden:true
      _BaseUnit,

      @Consumption.filter.hidden:true
      _GLAccountInChartOfAccounts,

      @Consumption.filter.hidden:true
      _GLChartOfAccounts,

      @Consumption.filter.hidden:true
      _InternalOrder,

      @Consumption.filter.hidden:true
      _Customer,

      @Consumption.filter.hidden:true
      _Supplier,

      @Consumption.filter.hidden:true
      _Material,

      @Consumption.filter.hidden:true
      _MaterialGroup,

      @Consumption.filter.hidden:true
      _Plant,

      @Consumption.filter.hidden:true
      _FinancialTransactionType,

      @Consumption.filter.hidden:true
      _Project,

      @Consumption.filter.hidden:true
      _CostCenter,

      @Consumption.filter.hidden:true
      _ProfitCenter,

      @Consumption.filter.hidden:true
      _FunctionalArea,

      @Consumption.filter.hidden:true
      _BusinessArea,

      @Consumption.filter.hidden:true
      _ControllingArea,

      @Consumption.filter.hidden:true
      _Segment,

      @Consumption.filter.hidden:true
      _PartnerCostCenter,

      @Consumption.filter.hidden:true
      _PartnerProfitCenter,

      @Consumption.filter.hidden:true
      _PartnerFunctionalArea,

      @Consumption.filter.hidden:true
      _PartnerBusinessArea,

      @Consumption.filter.hidden:true
      _PartnerCompany,

      @Consumption.filter.hidden:true
      _PartnerSegment,

      @Consumption.filter.hidden:true
      _BillingDocumentType,

      @Consumption.filter.hidden:true
      _SalesOrganization,

      @Consumption.filter.hidden:true
      _DistributionChannel,

      @Consumption.filter.hidden:true
      _Division,

      @Consumption.filter.hidden:true
      _SoldMaterial,

      @Consumption.filter.hidden:true
      _SoldProduct,

      @Consumption.filter.hidden:true
      _SoldProductGroup,

      @Consumption.filter.hidden:true
      _CustomerGroup,

      @Consumption.filter.hidden:true
      _Country,

      @Consumption.filter.hidden:true
      _Industry,

      @Consumption.filter.hidden:true
      _SalesDistrict,

      @Consumption.filter.hidden:true
      _BillToParty,

      @Consumption.filter.hidden:true
      _ShipToParty,

      //      _Extension_acdoca.ZZ1_SpecialPeriod_COB           as SpecialPeriod,

      _Extension_acdoca.ZZ1_LedgerGroup_COB             as LedgerGroup,
      @UI.lineItem: [{ position: 10, label: 'TaxIntention'}]     
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      @ObjectModel.text.element: ['TaxIntentionText']
      case when _Extension_acdoca.ZZ1_TaxIntention_COB is null then cast('000' as abap.char(3))
      else _Extension_acdoca.ZZ1_TaxIntention_COB end as TaxIntention,
      
      //_Extension_acdoca.ZZ1_TaxIntention_COB            as TaxIntention,
      @UI.lineItem: [{ position: 20 }]
      @EndUserText.label: 'TaxIntention Description'
      
      _Extension_acdoca.IntentDescription               as TaxIntentionText,

      _Extension_acdoca

}

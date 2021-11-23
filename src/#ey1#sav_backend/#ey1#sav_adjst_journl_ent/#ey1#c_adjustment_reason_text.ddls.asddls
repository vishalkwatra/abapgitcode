@AbapCatalog.sqlViewName: '/EY1/C_ADRSNTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Adjustment Reason - Text'
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'TransactionType'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true

@ObjectModel.semanticKey: 'TransactionType'
//@ObjectModel.representativeKey: 'ConsolidationUnit'
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #S

//@ObjectModel.usageType.serviceQuality: #C
//@ObjectModel.usageType.sizeCategory: #S
//@ObjectModel.usageType.dataClass: #CUSTOMIZING


define view /EY1/C_ADJUSTMENT_REASON_TEXT
  as select from dd07t           as A
    inner join   /ey1/trans_type as b on A.domvalue_l = b.rldnrassgnttype
{
        // @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.7 }
  key   A.domvalue_l as AdjustmentReason,
        //        @UI.lineItem:       [ { position: 10, importance: #HIGH}]
        @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8}
        // @ObjectModel.text.element:  [ 'AdjustmentReasonText' ]
  key   b.trtyp      as TransactionType,
        //        @Semantics.text: true
        @Search.defaultSearchElement: true
        @Search.fuzzinessThreshold: 0.8
        @Search.ranking: #HIGH
        //        @UI.lineItem:       [ { position: 30, importance: #HIGH}]
  key   b.blart      as JournalType,
        //@Semantics.text: true
        @Search.defaultSearchElement: true
        @Search.fuzzinessThreshold: 0.8
        @Search.ranking: #HIGH
        //        @UI.lineItem:       [ { position: 20, importance: #HIGH}]
        A.ddtext     as AdjustmentReasonText



}
where
  A.domname = 'ZRLDNR_ASSG_TYPE_DOM'

@AbapCatalog.sqlViewName: '/EY1/C_TTARVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'C-View for Transactiontype Adj Reason VH'

@VDM.viewType: #CONSUMPTION
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
@ObjectModel.representativeKey: 'TransType'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@OData.publish: true
define view /EY1/SAV_C_AdjReasn_VH
  as select from /EY1/SAV_I_Recon_Adj_Reason
{
      @UI.lineItem:       [ { position: 10, importance: #HIGH}]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @ObjectModel.text.element:  [ 'TransType' ]
  key TransType,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @UI.lineItem:       [ { position: 20, importance: #HIGH}]
  key AdjustmentReason,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @UI.lineItem:       [ { position: 30, importance: #HIGH}]
  key DocType
}

@AbapCatalog.sqlViewName: '/EY1/CTRANSACVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction Type Value Help'

@ObjectModel.dataCategory:#VALUE_HELP
@ObjectModel.representativeKey: 'TranTypeDomVal'
@VDM.viewType: #BASIC
@Search.searchable : true


define view /EY1/SAV_C_TransactionType_VH as select from /EY1/SAV_I_TransactionType_VH {
      @ObjectModel.text.element: ['Key']
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Key'
  key DebitCreditIndicatorDomVal,

      @Semantics.text:true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Description'
      DebitCreditIndicatorDomText
}

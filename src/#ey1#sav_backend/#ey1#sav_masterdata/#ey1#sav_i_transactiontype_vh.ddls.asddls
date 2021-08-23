@AbapCatalog.sqlViewName: '/EY1/ITRANSACVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction Type'
@ObjectModel.dataCategory:#VALUE_HELP
@ObjectModel.representativeKey: 'TranTypeDomVal'
@VDM.viewType: #BASIC
@Search.searchable : true

define view /EY1/SAV_I_TransactionType_VH
  as select from /EY1/SAV_I_ReadDomainFixedVal
{
      @ObjectModel.text.element: ['Key']
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Key'
  key /EY1/SAV_I_ReadDomainFixedVal.DomainValue as DebitCreditIndicatorDomVal,

      @Semantics.text:true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Description'
      /EY1/SAV_I_ReadDomainFixedVal.DomainText  as DebitCreditIndicatorDomText
}
where
      /EY1/SAV_I_ReadDomainFixedVal.SAPDataDictionaryDomain = 'SHKZG'
  and /EY1/SAV_I_ReadDomainFixedVal.LanguageCode            = $session.system_language

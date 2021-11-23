@AbapCatalog.sqlViewName: '/EY1/C_COMPCURVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Company Code Currency - Value Help'
define view /EY1/I_COMPCODECURR_VH as select from /EY1/I_COMPCURR_VH as a
 left outer join I_CurrencyText as b 
 on a.Currency = b.Currency{
 
 @Semantics.language: true
 key b.Language,
 
  @UI.lineItem:       [ { position: 10, importance: #HIGH}]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @ObjectModel.text.element:  [ 'CompanyCode' ] 
 key a.CompanyCode,
 
 @UI.lineItem:       [ { position: 20, importance: #HIGH}]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @ObjectModel.text.element:  [ 'CurrencyName' ] 
 key a.Currency,
 @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @UI.lineItem:       [ { position: 20, importance: #HIGH}]
 b.CurrencyName
} where b.Language = $session.system_language

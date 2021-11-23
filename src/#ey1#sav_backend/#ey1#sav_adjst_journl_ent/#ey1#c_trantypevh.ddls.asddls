@AbapCatalog.sqlViewName: '/EY1/CTRANTYP_VH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction Type Value Help'


@VDM.viewType: #CONSUMPTION
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
@ObjectModel.representativeKey: 'TransactionType'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@OData.publish: true

define view /EY1/C_TRANTYPEVH as select from t856x as a 
               left outer join t856y as b
               on a.rwgrp = b.rwgrp
               and a.mandt = b.mandt {    
    @Semantics.language: true
    key b.langu as Language,
    
    @UI.lineItem:       [ { position: 10, importance: #HIGH}]
    @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
    @ObjectModel.text.element:  [ 'TransactionType' ] 
    key a.rwgrp as TransactionType,
    
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    @UI.lineItem:       [ { position: 20, importance: #HIGH}]
    b.txt as TransactionTypeText
   
} where
b.langu = $session.system_language

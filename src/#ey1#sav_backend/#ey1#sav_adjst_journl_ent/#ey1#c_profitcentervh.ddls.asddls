@AbapCatalog.sqlViewName: '/EY1/C_PROFCTRVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center - Value Help'


@VDM.viewType: #CONSUMPTION
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
@ObjectModel.representativeKey: 'ProfitCenter'

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@OData.publish: true

define view /EY1/C_ProfitCenterVH as select from tka02 as a
inner join cepc as b
on a.kokrs = b.kokrs 
inner join cepct as c
on b.kokrs = c.kokrs {
    
    @UI.lineItem:       [ { position: 10, importance: #HIGH}]
    @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
    @ObjectModel.text.element:  [ 'CompanyCode' ] 
    key a.bukrs as CompanyCode,
    
    
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    @UI.lineItem:       [ { position: 20, importance: #HIGH}]
    key b.prctr as ProfitCenter,
    
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    @UI.lineItem:       [ { position: 30, importance: #HIGH}]
    c.ktext as ProfitCenterText
}

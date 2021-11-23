@AbapCatalog.sqlViewName: '/EY1/CCOMPCODEVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C - view for Company Code VH'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true


@ObjectModel.semanticKey: 'CompanyCode'
@ObjectModel.representativeKey: 'CompanyCode'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.dataCategory:#VALUE_HELP

define view /EY1/SAV_C_CompCodeVH
  as select from I_CompanyCode
{
      @ObjectModel.text.element:  [ 'CompanyCodeName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key CompanyCode,
      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      CompanyCodeName,
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      Company
}

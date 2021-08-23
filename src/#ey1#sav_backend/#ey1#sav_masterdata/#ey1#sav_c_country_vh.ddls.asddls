@AbapCatalog.sqlViewName: '/EY1/SAVCCNTRYVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View Country VH'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_Country_VH
  as select from /EY1/SAV_I_COUNTRY
{
      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
  key CountryCode,

      @Search: {defaultSearchElement: true, fuzzinessThreshold: 0.8, ranking: #HIGH}
      Description,
      Nation,
      Currency
}

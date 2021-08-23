@AbapCatalog.sqlViewName: '/EY1/SAVCNSCOVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C view for consolidation unit and country'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_CnsldCountryVH
  as select from I_CnsldtnUnit_2 as Cnsld
  association [0..1] to /EY1/SAV_C_Country_VH as _Country on $projection.Country = _Country.CountryCode

{
      //Cnsld
  key ConsolidationDimension,
  key ConsolidationUnit,
      DocumentEntryIsInGroupCurrency,
      Country,
      /* Associations */
      //Cnsld
      _Country.Description as Description, 
      _Country.Nation as Nation,
      _Country.Currency as Currency
      //_Dimension,
      //_Text
      //_UnitHierNode
}
where Country != ''

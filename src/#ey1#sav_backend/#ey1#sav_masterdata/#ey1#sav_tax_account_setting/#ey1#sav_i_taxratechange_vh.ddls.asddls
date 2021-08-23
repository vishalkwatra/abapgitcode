@AbapCatalog.sqlViewName: '/EY1/TRC_VH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Interface View for Tax Rate Change Value Help'
@Search.searchable : true

define view /EY1/SAV_I_TaxRateChange_VH
  as select from /ey1/taxrate_vh
{ ///ey1/taxrate_vh
      @Search.defaultSearchElement: true
  key tax_rate_change as TaxRateChange
}


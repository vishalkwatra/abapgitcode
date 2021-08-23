@AbapCatalog.sqlViewName: '/EY1/DTIE_VH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Interface View for DT Intracompany Elimination Value Help'
@Search.searchable : true

define view /EY1/SAV_I_DTICElimination_VH
  as select from /ey1/dtice_vh
{ ///ey1/dtice_vh
      @Search.defaultSearchElement: true
  key dtice as DTIntracompanyElimination
}


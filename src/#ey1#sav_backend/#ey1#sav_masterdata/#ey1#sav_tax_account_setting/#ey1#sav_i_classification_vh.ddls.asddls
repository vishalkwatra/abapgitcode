@AbapCatalog.sqlViewName: '/EY1/CLASSIVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Interface View for Value Help of GAAP Classification'
@Search.searchable : true

define view /EY1/SAV_I_CLASSIFICATION_VH
  as select from /ey1/class_vh
{ ///ey1/class_vh
      @Search.defaultSearchElement: true
  key classification as Classification
}


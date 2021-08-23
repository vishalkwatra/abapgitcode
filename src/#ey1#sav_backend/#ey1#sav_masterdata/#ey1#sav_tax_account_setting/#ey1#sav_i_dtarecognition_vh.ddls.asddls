@AbapCatalog.sqlViewName: '/EY1/DTARECOG_VH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.resultSet.sizeCategory: #XS
@EndUserText.label: 'Interface View for DTA Recognition Value Help'
@Search.searchable : true

define view /EY1/SAV_I_DTARecognition_VH
  as select from /ey1/dtareco_vh
{ ///ey1/dtareco_vh
      @Search.defaultSearchElement: true
  key dta_recognition as DTARecognition
}


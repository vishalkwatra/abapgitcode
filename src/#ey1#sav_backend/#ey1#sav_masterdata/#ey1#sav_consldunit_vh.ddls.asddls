@AbapCatalog.sqlViewName: '/EY1/CONSUNITVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory:#VALUE_HELP
@VDM.viewType: #BASIC
@Search.searchable : true
@EndUserText.label: 'VH for Consld Unit'

define view /EY1/SAV_CONSLDUNIT_VH
  as select from A_CnsldtnUnitT
{
      //A_CnsldtnUnit
      @ObjectModel.text.element: ['ConsolidationUnitText']
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Reporting Type'
  key ConsolidationUnit,

      @Semantics.text:true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Type Name'
      ConsolidationUnitText

}
where
  A_CnsldtnUnitT.Language = $session.system_language

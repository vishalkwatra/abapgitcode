@AbapCatalog.sqlViewName: '/EY1/RTYPEVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory:#VALUE_HELP
@VDM.viewType: #BASIC
@Search.searchable : true
@ObjectModel.usageType: { dataClass: #CUSTOMIZING,
                          serviceQuality: #C,
                          sizeCategory: #M }
@EndUserText.label: 'VH for Reporting type'

define view /EY1/SAV_REPORTINGTYPE_VH
  as select from /ey1/report_type
{
      ///ey1/sav_Reportingtype_VH
      @ObjectModel.text.element: ['type_name']
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Reporting Type'
  key reporting_type,

      @Semantics.text:true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Type Name'
      type_name

}

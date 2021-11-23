@AbapCatalog.sqlViewName: '/EY1/CRINTENTVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View for Reading Intention Value'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ReadIntentVH
  as select from /EY1/SAV_I_ReadIntentVH
{
      //ZEY_SAV_I_ReadIntentVH
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key Intent,
  
  key SerialNumber,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      IntentDescription,
      
      PeriodTo,
      TaxIntention,
      AnalyticsPeriodTo
//      SpecialPeriod
}

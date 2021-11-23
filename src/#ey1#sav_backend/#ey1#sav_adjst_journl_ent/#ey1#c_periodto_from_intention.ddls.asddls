@AbapCatalog.sqlViewName: '/EY1/CPER4INTN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Fetch Period To from Intention'

@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/C_PERIODTO_FROM_INTENTION as select from /ey1/intention {
 
 @Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.7
 @Consumption.filter.multipleSelections
 key intent as Intention,
 
 @Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.7
 description as IntentionDescription,
 
 analyticsperiodto as PeriodTo
    
}

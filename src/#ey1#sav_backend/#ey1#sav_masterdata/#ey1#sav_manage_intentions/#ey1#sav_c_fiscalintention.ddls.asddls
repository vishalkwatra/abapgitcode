//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View for Intention Management App'
@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
define root view entity /EY1/SAV_C_FiscalIntention 
as projection on /EY1/SAV_I_FiscalIntention {
    key Guid,
    key FiscalYear,
    Intention,
    SerialNumber,
    PeriodTo,
    CreatedBy,
    CreatedOn,
    ChangedBy,
    ChangedOn
    
}

@AbapCatalog.sqlViewName: '/EY1/IRINTENTVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Reading Intention Value'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_ReadIntentVH
  as select from /ey1/intention
{
  key intent            as Intent,
  key seqnr_flb         as SerialNumber,
      description       as IntentDescription,
      periodto          as PeriodTo,
      taxintention      as TaxIntention,
//      specialperiod     as SpecialPeriod,
      analyticsperiodto as AnalyticsPeriodTo
}

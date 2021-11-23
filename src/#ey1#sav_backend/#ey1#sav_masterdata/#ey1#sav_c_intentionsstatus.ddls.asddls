@AbapCatalog.sqlViewName: '/EY1/CINTSN_STAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@VDM.viewType: #CONSUMPTION
@EndUserText.label: 'Intention Values with Status'
define view /EY1/SAV_C_IntentionsStatus with parameters
@Environment.systemField: #CLIENT
@Consumption.hidden: true
 p_mandt: abap.clnt,
 p_bunit: fc_bunit
 as select from /EY1/SAV_I_ReadIntentVH as A
left outer join /EY1/INTENTIONV_TF( p_mandt:$parameters.p_mandt,p_bunit:$parameters.p_bunit) as b
on A.Intent = b.intent {
         //ZEY_SAV_I_ReadIntentVH
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
  key A.Intent as Intention,
  key b.gjahr as Gjahr,
  key A.SerialNumber,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      IntentDescription,
      
      A.PeriodTo,
      A.TaxIntention,
      b.curropenperiod as CurrOpenPeriod,
      b.status,
      b.isSelected
      
}

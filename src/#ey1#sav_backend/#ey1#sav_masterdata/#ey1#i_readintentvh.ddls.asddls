@AbapCatalog.sqlViewName: '/EY1/IREADINTNVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for reading intention values'
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'IntentionDomVal'
@VDM.viewType: #BASIC
@Search.searchable: true
define view /EY1/I_ReadIntentVH
  as select from /EY1/SAV_I_ReadIntentVH
{
      @ObjectModel.text.element: ['Key']
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Key'
  key /EY1/SAV_I_ReadIntentVH.Intent            as IntentionDomVal,

      @Semantics.text:true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Description'
      /EY1/SAV_I_ReadIntentVH.IntentDescription as IntentionDomText
}
where
  (
       /EY1/SAV_I_ReadIntentVH.Intent = 'Q1'
    or /EY1/SAV_I_ReadIntentVH.Intent = 'Q2'
    or /EY1/SAV_I_ReadIntentVH.Intent = 'Q3'
    or /EY1/SAV_I_ReadIntentVH.Intent = 'TXP'
  )

@AbapCatalog.sqlViewName: '/EY1/SAVCCECA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C- view for Cost Element based onControlling Area'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_CostElement
  as select from /EY1/SAV_I_CostElement
{
  key ControllingArea,
  key GLAccount,
      CostElementCat
}

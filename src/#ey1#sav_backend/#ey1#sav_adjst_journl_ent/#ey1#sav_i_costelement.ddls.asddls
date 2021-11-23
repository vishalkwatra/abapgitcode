@AbapCatalog.sqlViewName: '/EY1/SAVICECA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - view for Cost Element based onControlling Area'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_CostElement
  as select from cskb
{
  key kokrs as ControllingArea,
  key kstar as GLAccount,
      katyp as CostElementCat
}

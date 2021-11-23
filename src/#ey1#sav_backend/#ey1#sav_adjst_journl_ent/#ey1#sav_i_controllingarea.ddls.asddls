@AbapCatalog.sqlViewName: '/EY1/SAVICAA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - view for Controlling Area Assignment'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ControllingArea
  as select from tka02
{
  key bukrs as CompanyCode,
      kokrs as ControllingArea
}

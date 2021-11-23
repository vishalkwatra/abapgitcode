@AbapCatalog.sqlViewName: '/EY1/SAVCCAA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C - view for Controlling Area Assignment'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ControllingArea
  as select from /EY1/SAV_I_ControllingArea
{
  key CompanyCode,
      ControllingArea
}

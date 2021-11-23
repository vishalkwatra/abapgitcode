@AbapCatalog.sqlViewName: '/EY1/SAVCCEBCA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C- view for Cost Element based onControlling Area'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_CostElmntContrArea
  as select from /EY1/SAV_I_CostElmntContrArea
{
  key ControllingArea,
  key GLAccount,
  key CompanyCode,
      CostElementCat
}

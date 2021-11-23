@AbapCatalog.sqlViewName: '/EY1/SAVICEBCA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - view for Cost Element based onControlling Area'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_CostElmntContrArea
  as select from    tka02 as ContrAreaAsgn
    left outer join cskb  as CostElem on CostElem.kokrs = ContrAreaAsgn.kokrs
{
  key CostElem.kokrs      as ControllingArea,
  key CostElem.kstar      as GLAccount,
  key ContrAreaAsgn.bukrs as CompanyCode,
      CostElem.katyp      as CostElementCat

}

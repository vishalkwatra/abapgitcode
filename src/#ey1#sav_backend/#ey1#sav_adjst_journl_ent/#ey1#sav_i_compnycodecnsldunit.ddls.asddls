@AbapCatalog.sqlViewName: '/EY1/SAVICCCU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - view for Company Code based on Consolidation Unit'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_CompnyCodeCnsldUnit
  as select from tfin010 as ConsUnit
    inner join   t001    as CompCode on ConsUnit.rcomp = CompCode.rcomp
{
  key CompCode.bukrs as CompanyCode,
  key ConsUnit.bunit as ConsolidationUnit,
      CompCode.rcomp as CompanyName
}

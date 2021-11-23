@AbapCatalog.sqlViewName: '/EY1/SAVCCCCU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C - view for Company Code based on Consolidation Unit'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_CompnyCodeCnsldUnit
  as select from /EY1/SAV_I_CompnyCodeCnsldUnit
{
  key CompanyCode,
  key ConsolidationUnit,
      CompanyName
}

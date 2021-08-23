@AbapCatalog.sqlViewName: '/EY1/SAVFSITEMMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Financial Statement Items'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_FinancialStatItem
  as select from /ey1/fs_item
{
  key account_classcode,
  key itclg,
  key item
}

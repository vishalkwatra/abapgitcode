@AbapCatalog.sqlViewName: '/EY1/CLCGCVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View Local & Group Currency VH'

@VDM.viewType: #CONSUMPTION


define view /EY1/SAV_C_CurrLocalGroupVH
  as select from /EY1/SAV_I_CurrLocalGroupVH
{
      ///EY1/SAV_I_CurrLocalGroupVH
  key ConsolidationUnit,
  key CurrencyType,
  key Currency,
      Country,
      ConsolidationUnitDescription
}



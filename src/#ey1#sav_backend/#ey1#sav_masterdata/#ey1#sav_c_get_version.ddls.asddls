@AbapCatalog.sqlViewName: '/EY1/CGETVERSION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch Consolidation Version'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_Get_Version
  with parameters
    p_congr : fc_congr
  as select from /EY1/SAV_I_Get_Version
                 ( p_congr: $parameters.p_congr)

{ ///EY1/SAV_I_Get_Version
  key ConsolidationVersion,
  key ConsolidationGroup,
  key FiscalYear,
      ConsolidationLedger
}

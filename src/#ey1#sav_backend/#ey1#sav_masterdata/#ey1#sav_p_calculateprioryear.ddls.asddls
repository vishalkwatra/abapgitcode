@AbapCatalog.sqlViewName: '/EY1/PPRIORYEAR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Private View to get Prior year Entry'
@VDM.viewType: #BASIC

define view /EY1/SAV_P_CalculatePriorYear
  with parameters
    p_ryear : gjahr
    // Table name not given as dummy. 
    // No data is being used from this table
    // Table is given as view expects 1 data source
  as select distinct from /ey1/reconledger
{
  cast(cast(:p_ryear as abap.dec( 4, 0 )) - 1 as abap.char( 7 )) as PriorYear
}

@AbapCatalog.sqlViewName: '/EY1/CTAXRATEVAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View - Fetch Tax Rate Values'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_Fetch_Tax_Rates
  with parameters
    p_toperiod    : poper,
    p_ryear       : gjahr
  as select from /EY1/SAV_I_Validate_Tax_Rates
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear )
{
  key ConsolidationUnit,
  key FiscalYear,
      GaapOBDTRate,
      GaapCBDTRate,
      StatOBDTRate,
      StatCBDTRate,
      CurrentTaxRate
}

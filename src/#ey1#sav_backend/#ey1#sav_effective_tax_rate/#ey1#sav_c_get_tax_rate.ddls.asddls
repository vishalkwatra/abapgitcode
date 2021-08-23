@AbapCatalog.sqlViewName: '/EY1/CGETTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to get tax rates'
define view /EY1/SAV_C_Get_Tax_Rate
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr,
    p_rbunit   : fc_bunit
  as select from /EY1/SAV_I_Get_Tax_Rate(  p_toperiod:$parameters.p_toperiod ,
                   p_ryear:$parameters.p_ryear, p_rbunit:  $parameters.p_rbunit)
{
      ///EY1/SAV_I_Get_Tax_Rate
  key ConsolidationUnit,
  key FiscalYear,
  key Intention,
      CurrentTaxRate,
      GaapOBDTRate,
      GaapCBDTRate,
      StatOBDTRate,
      StatCBDTRate
}

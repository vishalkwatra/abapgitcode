@AbapCatalog.sqlViewName: '/EY1/IVALTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Validate Tax Rates'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Validate_Tax_Rates
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr
  as select from /EY1/SAV_P_Fetch_Tax_Rates
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear )

  association [0..1] to A_CnsldtnUnit as _CnsldtnUnit on $projection.ConsolidationUnit = _CnsldtnUnit.ConsolidationUnit
{
  key ConsolidationUnit,
  key FiscalYear,
  key Intention,
  
      case when GaapOBDTRate is null then GaapOBRateTXP else GaapOBDTRate end         as GaapOBDTRate,
      case when GaapCBDTRate is null then GaapCBRateTXP else GaapCBDTRate end         as GaapCBDTRate,
      case when StatOBDTRate is null then StatOBRateTXP else StatOBDTRate end         as StatOBDTRate,
      case when StatCBDTRate is null then StatCBRateTXP else StatCBDTRate end         as StatCBDTRate,


      case when CurrentTaxRate is null then CurrentTaxRateTXP else CurrentTaxRate end as CurrentTaxRate,

      fltp_to_dec( 0.01 as abap.dec(2,2) )                                            as MultiFactor,

      _CnsldtnUnit.Country
}

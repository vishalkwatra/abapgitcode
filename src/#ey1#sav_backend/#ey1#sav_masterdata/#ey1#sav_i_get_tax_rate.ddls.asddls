@AbapCatalog.sqlViewName: '/EY1/IGETTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View to get tax rates'

define view /EY1/SAV_I_Get_Tax_Rate
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr,
    p_rbunit   : fc_bunit
  as select from /EY1/SAV_P_Get_Tax_Rate(  p_toperiod:$parameters.p_toperiod ,
                                           p_ryear:$parameters.p_ryear, 
                                           p_rbunit:  $parameters.p_rbunit)
{
      ///EY1/SAV_P_Get_Tax_Rate
  key rbunit                                                              as ConsolidationUnit,
  key gjahr                                                               as FiscalYear,
  key intention                                                           as Intention,

      case when current_tax_rate is null then 0 else current_tax_rate end as CurrentTaxRate,
      case when gaap_ob_dt_rate is null then 0 else gaap_ob_dt_rate end   as GaapOBDTRate,
      case when gaap_cb_dt_rate is null then 0 else gaap_cb_dt_rate end   as GaapCBDTRate,
      case when stat_ob_dt_rate is null then 0 else stat_ob_dt_rate end   as StatOBDTRate,
      case when stat_cb_dt_rate is null then 0 else stat_cb_dt_rate end   as StatCBDTRate,

      fltp_to_dec( 0.01 as abap.dec(2,2) )                                as MultiFactor

}

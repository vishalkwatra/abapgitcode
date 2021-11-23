@AbapCatalog.sqlViewName: '/EY1/ETRCRSPYTOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ETR RS PYA DTRF PL Total'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RS_PYATotal
  with parameters
    p_fromperiod   : poper,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit
  as select from /EY1/SAV_I_ETR_RS_PYADTRPL
                 ( p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,p_ryear: $parameters.p_ryear,
                 p_switch: $parameters.p_switch, p_taxintention: $parameters.p_taxintention, p_rbunit: $parameters.p_rbunit)
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key FiscalYear,
      MainCurrency,

      sum(Tax)        as Tax,
      sum(Percentage) as Percentage,

      CurrencyType,
      ReportingType
}
group by
  ConsolidationChartofAccounts,
  ChartOfAccounts,
  ConsolidationUnit,
  FiscalYear,
  MainCurrency,
  CurrencyType,
  ReportingType

@AbapCatalog.sqlViewName: '/EY1/ETRPTATOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-PTA Total'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_PTA_Total
  with parameters
    p_fromperiod    : poper,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_rbunit        : fc_bunit,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_intention     : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_PTA_Mvmnt( p_fromperiod:$parameters.p_fromperiod ,
                 p_ryear:$parameters.p_ryear
                 , p_toperiod: $parameters.p_toperiod,
                 p_rbunit: $parameters.p_rbunit,
                 p_switch: $parameters.p_switch,
                 p_taxintention:$parameters.p_taxintention,
                 p_intention: $parameters.p_intention)
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationDimension,
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
  ConsolidationDimension,
  FiscalYear,
  MainCurrency,
  CurrencyType,
  ReportingType

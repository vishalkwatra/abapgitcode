@AbapCatalog.sqlViewName: '/EY1/CETRPTATOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View-ETR-PTA Total'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ETR_PTA_Total
  with parameters
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit,
    p_intention     : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_PTA_Total( p_fromperiod: $parameters.p_fromperiod,
                 p_ryear: $parameters.p_ryear,
                 p_toperiod: $parameters.p_toperiod,
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

      @Semantics.currencyCode: true
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Tax,
      Percentage,
      CurrencyType,
      ReportingType
}

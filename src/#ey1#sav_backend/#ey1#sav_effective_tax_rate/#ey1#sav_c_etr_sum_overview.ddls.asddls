@AbapCatalog.sqlViewName: '/EY1/CETRSUMOVRV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View- ETR- Summary- Overview'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION
define view /EY1/SAV_C_ETR_SUM_Overview
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_intention     : /ey1/sav_intent,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit
  as select from /EY1/SAV_I_ETR_SUM_Overview
                 ( p_cntry: $parameters.p_cntry, 
                   p_ryear: $parameters.p_ryear,
                   p_fromperiod: $parameters.p_fromperiod, 
                   p_toperiod: $parameters.p_toperiod, 
                   p_intention: $parameters.p_intention,
                   p_switch: $parameters.p_switch, 
                   p_taxintention: $parameters.p_taxintention,
                   p_rbunit: $parameters.p_rbunit)
{
  key ConsolidationChartofAccounts,  
  key ChartOfAccounts,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key ConsolidationUnit,
  key ConsolidationDimension,
  key FiscalYear,

      @Semantics.currencyCode: true
      @EndUserText.label: 'CCY'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Amount,

      Rate,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Tax,

      Percentage,

      ReportingType,
      CurrencyType,
      SerialNo
}

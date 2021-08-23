@AbapCatalog.sqlViewName: '/EY1/ETRRSETEB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- Summary- Expectd Tax Expense Benefit'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_ExpTaxEB
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit
  as select from /EY1/SAV_I_ETR_RS_SUM_ExpTaxEB
                 ( p_ryear:$parameters.p_ryear,
                 p_fromperiod:$parameters.p_fromperiod,
                 p_toperiod:$parameters.p_toperiod,
                 p_switch:$parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention,
                 p_rbunit: $parameters.p_rbunit )
{
      ///EY1/SAV_I_ETR_RS_SUM_ExpTaxEB
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      ConsolidationLedger,
      MainCurrency,
      PBT,
      CurrType,
      CurrentTaxRate,
      Tax,
      Percentage,
      ReportingType
}

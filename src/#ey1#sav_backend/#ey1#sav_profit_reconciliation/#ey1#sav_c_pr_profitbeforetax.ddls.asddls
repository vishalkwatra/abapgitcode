@AbapCatalog.sqlViewName: '/EY1/CPRSECPBT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View- ProfitRecon- Profit Before Tax'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_PR_ProfitBeforeTax
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_ProfitBeforeTax
                 ( p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      GAAPIncomeLossCY,

      CurrencyType,
      cast ('' as abap.char( 3 )) as PeriodFrom,
      cast ('' as abap.char( 3 )) as PeriodTo,
      cast (' ' as abap.char(4))  as Intention
}

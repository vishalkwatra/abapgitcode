@AbapCatalog.sqlViewName: '/EY1/ERS2TTOTAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER Stat2Tax Total of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2TTotal
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_Stat2Tax(p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key ConsolidationDimension,
  key FiscalYear,


      @Semantics.currencyCode: 'true'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(S2TAdjustAmt)         as SumS2TAdjustAmt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(S2TPYA)               as SumS2TPYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(PlYearBalance)        as SumPlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(PmtYearBalance)       as SumPmtYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(S2TCYABalance)        as SumS2TCYABalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(EqTotalYearBalance)   as SumEqTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(OthrTotalYearBalance) as SumOthrTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(S2TCTA)               as SumS2TCTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(CBYearBalance)        as SumCBYearBalance,

      CurrencyType
}
group by
  ChartOfAccounts,
  ConsolidationUnit,
  ConsolidationChartofAccounts,
  FiscalYear,
  ConsolidationDimension,
  MainCurrency,
  CurrencyType

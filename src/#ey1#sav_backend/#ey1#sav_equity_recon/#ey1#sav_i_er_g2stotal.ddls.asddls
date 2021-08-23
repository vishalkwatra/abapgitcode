@AbapCatalog.sqlViewName: '/EY1/ERG2STOTAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER Gaap2Stat Total of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2STotal
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_Gaap2Stat(p_toperiod:$parameters.p_toperiod,
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
      sum(G2SAdjustAmt)         as SumG2SAdjustAmt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(G2SPYA)               as SumG2SPYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(PlYearBalance)        as SumPlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(PmtYearBalance)       as SumPmtYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(G2SCYABalance)        as SumG2SCYABalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(EqTotalYearBalance)   as SumEqTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(OthrTotalYearBalance) as SumOthrTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(G2SCTA)               as SumG2SCTA,

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

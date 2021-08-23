@AbapCatalog.sqlViewName: '/EY1/CERG2STOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch  Total of ER Gaap2Stat Values'
@VDM.viewType:  #CONSUMPTION

define view /EY1/SAV_C_ER_Gaap2Stat_Total
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
    
  as select from /EY1/SAV_I_ER_G2STotal(p_toperiod:$parameters.p_toperiod,
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
      SumG2SAdjustAmt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumG2SPYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumPlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumPmtYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumG2SCYABalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumEqTotalYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumOthrTotalYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumG2SCTA,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumCBYearBalance,

      CurrencyType
}

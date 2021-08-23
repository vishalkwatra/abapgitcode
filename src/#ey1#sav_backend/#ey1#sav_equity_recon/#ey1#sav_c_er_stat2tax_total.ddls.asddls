@AbapCatalog.sqlViewName: '/EY1/CERS2TTOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch  Total of ER Stat2Tax Values'
@VDM.viewType:  #CONSUMPTION

define view /EY1/SAV_C_ER_Stat2Tax_Total
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_S2TTotal(p_toperiod:$parameters.p_toperiod,
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
      SumS2TAdjustAmt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumS2TPYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumPlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumPmtYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      SumS2TCYABalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumEqTotalYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumOthrTotalYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumS2TCTA,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumCBYearBalance,

      CurrencyType
}

@AbapCatalog.sqlViewName: '/EY1/ERGAAPEQSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch the GAAP EQ Footer Sum Values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_Total
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_GAAP_Equity(p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention)
{
      ///EY1/SAV_I_ER_GAAP_Equity
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  
      ConsolidationDimension,
      
      @Semantics.currencyCode: 'true'
      MainCurrency,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(GaapOpeningBalance) as SumGaapOB,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(GaapMvmnt)          as SumGaapYB,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(GaapEQ)             as SumGaapEQ,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(GaapCTA)            as SumGaapCTA,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(GaapClosingBalance) as SumGaapCB,
      
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

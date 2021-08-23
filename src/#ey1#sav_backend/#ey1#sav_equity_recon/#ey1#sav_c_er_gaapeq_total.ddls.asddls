@AbapCatalog.sqlViewName: '/EY1/CERGEQSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch the GAAP EQ Footer Sum Values'
@VDM.viewType:  #CONSUMPTION

define view /EY1/SAV_C_ER_GAAPEQ_Total
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention
    
  as select from /EY1/SAV_I_ER_GAAPEQ_Total(p_ryear:$parameters.p_ryear,
                                            p_fromperiod:$parameters.p_fromperiod,
                                            p_toperiod:$parameters.p_toperiod,
                                            p_taxintention: $parameters.p_taxintention)
{ ///EY1/SAV_I_ER_GAAPEQ_Total
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  
      ConsolidationDimension,
      
      @Semantics.currencyCode: 'true'
      MainCurrency,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumGaapOB,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumGaapYB,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumGaapEQ,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumGaapCTA,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      SumGaapCB,
      
      CurrencyType
}

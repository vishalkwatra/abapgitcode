@AbapCatalog.sqlViewName: '/EY1/ERGQLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch LC-GC values of Gaap EQ section of ER'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_LCGCUnion
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_GAAPEQ_LC(p_ryear:$parameters.p_ryear,
                                              p_fromperiod:$parameters.p_fromperiod,
                                              p_toperiod:$parameters.p_toperiod,
                                              p_taxintention: $parameters.p_taxintention)
{
      ///EY1/SAV_I_ER_GAAPEQ_LC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  key AccountClassCode,
  key GLAccount,
      
      ConsolidationDimension,
      FinancialStatementItem,
      
      @Semantics.currencyCode: true
      LocalCurrency as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapMvmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapEQ,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapCTA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapClosingBalance,

      CurrencyType
}
union all select from /EY1/SAV_I_ER_GAAPEQ_GC(p_ryear:$parameters.p_ryear,
                                              p_fromperiod:$parameters.p_fromperiod,
                                              p_toperiod:$parameters.p_toperiod,
                                              p_taxintention: $parameters.p_taxintention)
{ ///EY1/SAV_I_ER_GAAPEQ_GC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  key AccountClassCode,
  key GLAccount,
      
      ConsolidationDimension,
      FinancialStatementItem,
      
      @Semantics.currencyCode: true
      GroupCurrency as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapOpeningBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapMvmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapEQ,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapCTA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapClosingBalance,

      CurrencyType
}

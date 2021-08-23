@AbapCatalog.sqlViewName: '/EY1/ERGEQUITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch values of Gaap Equity section of ER'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAP_Equity
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_GAAPEQ_LCGCUnion(p_ryear:$parameters.p_ryear,
                                              p_fromperiod:$parameters.p_fromperiod,
                                              p_toperiod:$parameters.p_toperiod,
                                              p_taxintention: $parameters.p_taxintention)
{ ///EY1/SAV_I_ER_GAAPEQ_LCGCUnion

  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  key AccountClassCode,
  key GLAccount,

      ConsolidationDimension,
      FinancialStatementItem,

      @Semantics.currencyCode: true
      MainCurrency,

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
where
     GaapOpeningBalance != 0
  or GaapMvmnt != 0
  or GaapEQ != 0
  or GaapCTA != 0
  or GaapClosingBalance != 0

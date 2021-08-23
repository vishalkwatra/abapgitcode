@AbapCatalog.sqlViewName: '/EY1/PRG2SYB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- G2S - Year Mvmnt'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_G2S_Mvmnt
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_G2S_YB_LCGC
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
      ///EY1/SAV_I_PR_G2S_YB_LCGC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  key GLAccount,
  key AccountClassCode,
      ConsolidationDimension,
      @Semantics.currencyCode: true
      MainCurrency,
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPLYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPmntYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TransactionTotal,
      CurrencyType
}
where 
G2SPLYearBalance != 0
or G2SPmntYearBalance != 0
or TransactionTotal != 0

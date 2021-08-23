@AbapCatalog.sqlViewName: '/EY1/PROTAYB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA - Year Mvmnt'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_Mvmnt
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_OTA_YB_LCGC
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
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
      OTATransactionsPL,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OTATransactionsPmnt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TransactionTotal,
      CurrencyType
}
where OTATransactionsPL != 0
or OTATransactionsPmnt != 0
or TransactionTotal != 0

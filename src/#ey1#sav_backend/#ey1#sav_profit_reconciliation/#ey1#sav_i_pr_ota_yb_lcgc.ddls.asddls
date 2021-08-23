@AbapCatalog.sqlViewName: '/EY1/PROTAYBLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA - Year Mvmnt LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_YB_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_OTA_YB_LC
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
      LocalCurrency                 as MainCurrency,
      OTATransactionsPL,
      OTATransactionsPmnt,
      TransactionTotal,
      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_OTA_YB_GC
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
      GroupCurrency                 as MainCurrency,
      OTATransactionsPL,
      OTATransactionsPmnt,
      TransactionTotal,
      cast('Group' as abap.char(5)) as CurrencyType
}

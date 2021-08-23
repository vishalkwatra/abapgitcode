@AbapCatalog.sqlViewName: '/EY1/PRG2SYBLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- G2S - Year Mvmnt LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_G2S_YB_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_G2S_YB_LC
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
      G2SPLYearBalance,
      G2SPmntYearBalance,
      TransactionTotal,
      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_G2S_YB_GC
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
      G2SPLYearBalance,
      G2SPmntYearBalance,
      TransactionTotal,
      cast('Group' as abap.char(5)) as CurrencyType
}

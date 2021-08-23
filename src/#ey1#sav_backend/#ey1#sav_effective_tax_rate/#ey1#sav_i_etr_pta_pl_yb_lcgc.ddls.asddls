@AbapCatalog.sqlViewName: '/EY1/ETRPLYBLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-PTA PL Movement LCGC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_PTA_PL_YB_LCGC
  with parameters
    p_ryear    : gjahr,
    p_toperiod : poper,
    p_rbunit   : fc_bunit,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ETR_PTA_PL_YB_LC( p_ryear:$parameters.p_ryear ,
                 p_toperiod:$parameters.p_toperiod ,
                 p_rbunit:$parameters.p_rbunit,
                 p_taxintention:$parameters.p_taxintention )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,
      LocalCurrency as MainCurrency,
      BsEqPl,
      ProfitBeforeTax,
      PTAAmount,
      Rate,
      MultiFactor,
      'Local'       as CurrencyType
}
union all select from /EY1/SAV_I_ETR_PTA_PL_YB_GC( p_ryear:$parameters.p_ryear ,
                      p_toperiod: $parameters.p_toperiod,
                      p_rbunit:$parameters.p_rbunit,
                      p_taxintention:$parameters.p_taxintention )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,
      GroupCurrency as MainCurrency,
      BsEqPl,
      ProfitBeforeTax,
      PTAAmount,
      Rate,
      MultiFactor,
      'Group'       as CurrencyType
}

@AbapCatalog.sqlViewName: '/EY1/ETRSGDDYB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- SGAAP- Diff Deferred & CTR- TempDiff YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_DDCTRTDYB
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit
  as select from /EY1/SAV_I_ETR_SG_DDCTRTDYB_LC( p_toperiod:$parameters.p_toperiod , p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention , p_rbunit:$parameters.p_rbunit )
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
      TaxEffected,

      PlYearBalance,
      Rate,

      CurrentTaxRate,
      GaapOBDTRate,
      MultiFactor,

      'Local'       as CurrencyType
}
union all select from /EY1/SAV_I_ETR_SG_DDCTRTDYB_GC( p_toperiod:$parameters.p_toperiod , p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention , p_rbunit:$parameters.p_rbunit )
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
      TaxEffected,

      PlYearBalance,
      Rate,

      CurrentTaxRate,
      GaapOBDTRate,
      MultiFactor,

      'Group'       as CurrencyType
}

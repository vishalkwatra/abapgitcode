@AbapCatalog.sqlViewName: '/EY1/ETRSPYADT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ETR SGaap PYA DTRF PL'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_PYA_DTRPL
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit
  as select from /EY1/SAV_I_ETR_SG_PYA_DTRPL_LC( p_toperiod:$parameters.p_toperiod , p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention , p_rbunit:$parameters.p_rbunit )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,
      LocalCurrency as MainCurrency,

      BsEqPl,
      TaxEffected,

      TaxAmount,
      MultiFactor,

      'Local'       as CurrencyType
}
union all select from /EY1/SAV_I_ETR_SG_PYA_DTRPL_GC( p_toperiod:$parameters.p_toperiod , p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention , p_rbunit:$parameters.p_rbunit )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,
      GroupCurrency as MainCurrency,

      BsEqPl,
      TaxEffected,

      TaxAmount,
      MultiFactor,

      'Group'       as CurrencyType
}

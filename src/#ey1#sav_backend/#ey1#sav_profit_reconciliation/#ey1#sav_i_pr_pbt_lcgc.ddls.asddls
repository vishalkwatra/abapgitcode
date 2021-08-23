@AbapCatalog.sqlViewName: '/EY1/PRPBTLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - Profit Recon - PBT LC GC Union'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_PBT_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_PBT_LC
                 ( p_toperiod:$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention:$parameters.p_taxintention)
{
      ///EY1/SAV_I_PR_Section_PBT_LC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,
      LocalCurrency as MainCurrency,
      GAAPIncomeLossCY,
      
      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_PBT_GC
                      ( p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention:$parameters.p_taxintention)
{
      ///EY1/SAV_I_PR_Section_PBT_GC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,
      GroupCurrency as MainCurrency,
      GAAPIncomeLossCY,
      
      cast('Group' as abap.char(5)) as CurrencyType
}

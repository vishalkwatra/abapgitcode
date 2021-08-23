@AbapCatalog.sqlViewName: '/EY1/ETRSUMPBT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP- Summary Section- PBT LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RG_SUM_PBT_LCGC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ETR_RG_SUM_PBT_LC
                 ( p_ryear:$parameters.p_ryear,
                  p_fromperiod:$parameters.p_fromperiod,
                  p_toperiod:$parameters.p_toperiod,
                  p_taxintention: $parameters.p_taxintention )
{
      ///EY1/SAV_I_ETR_RG_SUM_PBT_LC
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      ConsolidationLedger,
      LocalCurrency                                                               as MainCurrency,
      case when PBT is null then cast(1 as abap.curr(23,2)) else (PBT * (-1)) end as PBT,

      'Local'                                                                     as CurrType
}
union all select from /EY1/SAV_I_ETR_RG_SUM_PBT_GC
                      ( p_ryear:$parameters.p_ryear,
                      p_fromperiod:$parameters.p_fromperiod,
                      p_toperiod:$parameters.p_toperiod,
                      p_switch:$parameters.p_switch,
                      p_taxintention: $parameters.p_taxintention )
{
      ///EY1/SAV_I_ETR_RG_SUM_PBT_LC
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      ConsolidationLedger,
      GroupCurrency                                                               as MainCurrency,
      case when PBT is null then cast(1 as abap.curr(23,2)) else (PBT * (-1)) end as PBT,

      'Group'                                                                     as CurrType
}

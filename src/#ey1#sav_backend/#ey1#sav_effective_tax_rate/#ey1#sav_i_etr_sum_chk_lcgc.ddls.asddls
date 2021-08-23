@AbapCatalog.sqlViewName: '/EY1/ETRSUMCHK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP- Summary- Check LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_Chk_LCGC
  with parameters
    p_ryear : gjahr

  as select distinct from /EY1/SAV_I_GlAcc_ETR_MD( p_ryear:$parameters.p_ryear )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      LocalCurrency                         as MainCurrency,

      cast (0 as abap.curr(23,2))           as Amount,
      cast (0 as /ey1/sav_current_tax_rate) as Rate,
      cast (0 as /ey1/sav_amount)           as Tax,
      cast (0 as /ey1/sav_rate)             as Percentage,

      'Local'                               as CurrType,
      'RGAAP'                               as ReportingType
}
union all select distinct from /EY1/SAV_I_GlAcc_ETR_MD( p_ryear:$parameters.p_ryear )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      LocalCurrency                         as MainCurrency,

      cast (0 as abap.curr(23,2))           as Amount,
      cast (0 as /ey1/sav_current_tax_rate) as Rate,
      cast (0 as /ey1/sav_amount)           as Tax,
      cast (0 as /ey1/sav_rate)             as Percentage,

      'Local'                               as CurrType,
      'SGAAP'                               as ReportingType
}
union all select distinct from /EY1/SAV_I_GlAcc_ETR_MD( p_ryear:$parameters.p_ryear )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      GroupCurrency                         as MainCurrency,

      cast (0 as abap.curr(23,2))           as Amount,
      cast (0 as /ey1/sav_current_tax_rate) as Rate,
      cast (0 as /ey1/sav_amount)           as Tax,
      cast (0 as /ey1/sav_rate)             as Percentage,

      'Group'                               as CurrType,
      'RGAAP'                               as ReportingType
}
union all select distinct from /EY1/SAV_I_GlAcc_ETR_MD( p_ryear:$parameters.p_ryear )
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      GroupCurrency                         as MainCurrency,

      cast (0 as abap.curr(23,2))           as Amount,
      cast (0 as /ey1/sav_current_tax_rate) as Rate,
      cast (0 as /ey1/sav_amount)           as Tax,
      cast (0 as /ey1/sav_rate)             as Percentage,

      'Group'                               as CurrType,
      'SGAAP'                               as ReportingType
}

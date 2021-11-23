@AbapCatalog.sqlViewName: '/EY1/ETRRSUNETEB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP SGAAP- Summary- Expectd Tax Exp Benefit'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RS_SUM_ExpTaxEB
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit,
    p_intention     : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_RG_SUM_ExpTaxEB
                 ( p_ryear:$parameters.p_ryear,
                 p_fromperiod:$parameters.p_fromperiod,
                 p_toperiod:$parameters.p_toperiod,
                 p_switch:$parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention,
                 p_rbunit: $parameters.p_rbunit )
{
      ///EY1/SAV_I_ETR_RG_SUM_ExpTaxEB
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      ConsolidationLedger,
      MainCurrency,
      PBT,
      CurrType,
      CurrentTaxRate,

      case when Tax is null then cast(0 as /ey1/sav_amount) else Tax end as Tax,
      fltp_to_dec(Percentage as /ey1/sav_rate)                           as Percentage,

      'RGAAP'                                                            as ReportingType
}
union all select from /EY1/SAV_I_ETR_SG_SUM_ExpTaxEB
                      ( p_ryear:$parameters.p_ryear,
                      p_fromperiod:$parameters.p_fromperiod,
                      p_toperiod:$parameters.p_toperiod,
                      p_switch:$parameters.p_switch,
                      p_taxintention: $parameters.p_taxintention,
                      p_rbunit: $parameters.p_rbunit,
                      p_intention: $parameters.p_intention )
{
      ///EY1/SAV_I_ETR_SG_SUM_ExpTaxEB
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationUnit,
      ConsolidationLedger,
      MainCurrency,
      PBT,
      CurrType,
      CurrentTaxRate,

      case when Tax is null then cast(0 as /ey1/sav_amount) else Tax end as Tax,
      fltp_to_dec(Percentage as /ey1/sav_rate)                           as Percentage,

      'SGAAP'                                                            as ReportingType
}

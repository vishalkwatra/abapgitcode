@AbapCatalog.sqlViewName: '/EY1/ETRRSDDCTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP SGAAP- Diff Deferred & CTR- TempDiff'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RS_DDCTRTD
  with parameters
    p_fromperiod   : poper,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit,
    p_intention    : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_RG_DDCTRTD( p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,
                 p_ryear: $parameters.p_ryear, p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention, p_rbunit: $parameters.p_rbunit)
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,

      MainCurrency,
      ConsolidationLedger,

      Amount,
      Rate,
      Tax,
      Percentage,

      BsEqPl,
      TaxEffected,
      CurrencyType,
      'RGAAP' as ReportingType
}
union all select from /EY1/SAV_I_ETR_SG_DDCTRTD( p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,
                      p_ryear: $parameters.p_ryear, p_switch: $parameters.p_switch,
                      p_taxintention: $parameters.p_taxintention, p_rbunit: $parameters.p_rbunit,
                      p_intention: $parameters.p_intention)
{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,

      MainCurrency,
      ConsolidationLedger,

      Amount,
      Rate,
      Tax,
      Percentage,

      BsEqPl,
      TaxEffected,
      CurrencyType,
      'SGAAP' as ReportingType
}

@AbapCatalog.sqlViewName: '/EY1/ETRPTARSYB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-PTA PL Movement RS'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_PTA_PL_RS_YB
  with parameters
    p_fromperiod    : poper,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_rbunit        : fc_bunit,
    p_switch        : char1,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ETR_PTA_RG_PL_YB( p_fromperiod: $parameters.p_fromperiod,
                  p_ryear: $parameters.p_ryear,p_toperiod: $parameters.p_toperiod,
                  p_rbunit: $parameters.p_rbunit,p_switch: $parameters.p_switch,
                  p_taxintention: $parameters.p_taxintention)
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

      PTAAmount,
      Rate,
      Tax,
      Percentage,

      BsEqPl,
      CurrencyType,
      'RGAAP' as ReportingType
}
union all select from /EY1/SAV_I_ETR_PTA_SG_PL_YB(p_fromperiod: $parameters.p_fromperiod,
                      p_ryear: $parameters.p_ryear,p_toperiod: $parameters.p_toperiod,
                      p_rbunit: $parameters.p_rbunit,p_switch: $parameters.p_switch,
                      p_taxintention: $parameters.p_taxintention)
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

      PTAAmount,
      Rate,
      Tax,
      Percentage,

      BsEqPl,
      CurrencyType,
      'SGAAP' as ReportingType
}
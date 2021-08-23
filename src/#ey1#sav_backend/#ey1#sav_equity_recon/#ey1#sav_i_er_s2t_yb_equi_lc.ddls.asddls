@AbapCatalog.sqlViewName: '/EY1/ERSTYBEQULC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB Equity Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_YB_Equi_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_S2T_YB_EqBETP_LC(
                 p_toperiod:$parameters.p_toperiod ,
                 p_ryear: $parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqTotalYearBalance,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected

}
union all select from /EY1/SAV_I_ER_S2T_YB_PPETot_LC(
                      p_toperiod:$parameters.p_toperiod ,
                      p_ryear:$parameters.p_ryear ,
                      p_taxintention: $parameters.p_taxintention)
{


  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqTotalYearBalance,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected
}

union all select from /EY1/SAV_I_ER_S2T_YB_RE_LC(
                      p_toperiod: $parameters.p_toperiod,
                      p_ryear: $parameters.p_ryear,
                      p_taxintention: $parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqTotalYearBalance,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected
}

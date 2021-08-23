@AbapCatalog.sqlViewName: '/EY1/ERG2SOYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB Othr  Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_Othr_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_G2S_YB_OPPEToLC(
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
      OthrTotalYearBalance,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected

}

union all select from /EY1/SAV_I_ER_G2S_YB_ORE_LC(
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
      OthrTotalYearBalance,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected
}

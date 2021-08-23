@AbapCatalog.sqlViewName: '/EY1/ERGSYBORSLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB Othr RE Sum Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_ORESum_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_G2S_YB_OPPERToLC(p_toperiod:$parameters.p_toperiod,
                                                p_ryear:$parameters.p_ryear,
                                                p_taxintention: $parameters.p_taxintention) as GLAcc

{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.ConsolidationDimension,
      GLAcc.FiscalYear,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(OthrTotalYearBalance) as OthrTotalYearBalance,

      @Semantics.currencyCode: true
      GLAcc.LocalCurrency,

      GLAcc.BsEqPl,
      GLAcc.TaxEffected
}
group by
  GLAcc.ChartOfAccounts,
  GLAcc.ConsolidationUnit,
  GLAcc.ConsolidationChartofAccounts,
  GLAcc.ConsolidationDimension,
  GLAcc.FiscalYear,
  GLAcc.LocalCurrency,
  GLAcc.BsEqPl,
  GLAcc.TaxEffected

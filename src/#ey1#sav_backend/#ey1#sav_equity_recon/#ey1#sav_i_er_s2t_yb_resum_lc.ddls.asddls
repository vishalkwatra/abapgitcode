@AbapCatalog.sqlViewName: '/EY1/ERS2TYBRSLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T YB RE Sum  Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_YB_RESum_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from  /EY1/SAV_I_ER_S2T_YB_PPERTo_LC(
                    p_toperiod:$parameters.p_toperiod ,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention )              as GLAcc

{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.ConsolidationDimension,
      GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(EqTotalYearBalance) as EqTotalYearBalance,
      @Semantics.currencyCode: true

      GLAcc.LocalCurrency,
      //S2T.GLAccount,
      //GLAcc.AccountClassCode,
      GLAcc.BsEqPl,
      // S2T.ConsolidationUnit
      //      BsEqPl,
      GLAcc.TaxEffected
}

group by
  GLAcc.ChartOfAccounts,
  GLAcc.ConsolidationUnit,
  GLAcc.ConsolidationChartofAccounts,
  // AccountClassCode,
  GLAcc.ConsolidationDimension,
  GLAcc.FiscalYear,
  GLAcc.LocalCurrency,
  //S2T.GLAccount,
  GLAcc.BsEqPl,
  GLAcc.TaxEffected


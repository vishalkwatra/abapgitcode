@AbapCatalog.sqlViewName: '/EY1/ERG2SYBRSGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB RE Sum  Values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_RESum_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from  /EY1/SAV_I_ER_G2S_YB_PPERTo_GC(
                    p_toperiod:$parameters.p_toperiod ,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention )              as GLAcc

{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.ConsolidationDimension,
      GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(EqTotalYearBalance) as EqTotalYearBalance,
      @Semantics.currencyCode: true

      GLAcc.GroupCurrency,
      //g2s.GLAccount,
      //GLAcc.AccountClassCode,
      GLAcc.BsEqPl,
      // g2s.ConsolidationUnit
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
  GLAcc.GroupCurrency,
  //g2s.GLAccount,
  GLAcc.BsEqPl,
  GLAcc.TaxEffected


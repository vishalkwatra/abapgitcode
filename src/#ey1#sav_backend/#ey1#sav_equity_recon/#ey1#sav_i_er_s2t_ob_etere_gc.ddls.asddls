@AbapCatalog.sqlViewName: '/EY1/ERS2TETEGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T OB EQ TE Sum Values for RE GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_ETERE_GC
  with parameters
    p_ryear         : gjahr,
    //    p_fromperiod    : poper,
    //    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc
    left outer join /EY1/SAV_I_ER_S2T_OB_EQ_GC( p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention )              as S2T on  S2T.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                      and S2T.GLAccount                    = GLAcc.GLAccount
                                                                                      and S2T.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                      and S2T.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                      
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key ConsolidationDimension,
      GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(S2TAdjustmentAmount) as S2TAdjustAmt,
      @Semantics.currencyCode: true
      GLAcc.GroupCurrency,
      //S2T.GLAccount,
      //GLAcc.AccountClassCode,
      GLAcc.BsEqPl,
      // S2T.ConsolidationUnit
      //      BsEqPl,
      GLAcc.TaxEffected
}
where
      BsEqPl      = 'EQ'
  and TaxEffected = 'X'

//
group by
  GLAcc.ChartOfAccounts,
  GLAcc.ConsolidationUnit,
  GLAcc.ConsolidationChartofAccounts,
  // AccountClassCode,
  ConsolidationDimension,
  GLAcc.FiscalYear,
  GLAcc.GroupCurrency,
  //S2T.GLAccount,
  GLAcc.BsEqPl,
  GLAcc.TaxEffected


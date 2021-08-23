@AbapCatalog.sqlViewName: '/EY1/ERS2TOBRELC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T OB Sum Values for RE LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_RE_LC
  with parameters
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc
    left outer join /EY1/SAV_I_ER_S2T_OB_ETERE_LC( p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention )              as S2T on  S2T.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                      and S2T.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                      and S2T.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                      and AccountClassCode                 = 'RE'
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key GLAcc.AccountClassCode,
  key GLAcc.ConsolidationDimension,
  key GLAcc.FiscalYear,
      S2TAdjustAmt * -1 as S2TAdjustAmt,
      GLAcc.LocalCurrency,
      GLAcc.BsEqPl,
      GLAcc.TaxEffected
}
where
  AccountClassCode = 'RE'

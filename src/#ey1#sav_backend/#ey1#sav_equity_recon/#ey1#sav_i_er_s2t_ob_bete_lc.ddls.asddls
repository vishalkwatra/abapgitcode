@AbapCatalog.sqlViewName: '/EY1/ERSTOBBETLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T OB EQ TE and BS Sum Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_BETE_LC
  with parameters
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc
    left outer join /EY1/SAV_I_ER_S2T_OB_EQ_LC( p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention )              as S2T on  S2T.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                      and S2T.GLAccount                    = GLAcc.GLAccount
                                                                                      and S2T.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                      and S2T.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                      and S2T.LocalCurrency                = GLAcc.LocalCurrency
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,
      S2TAdjustmentAmount * -1 as S2TAdjustAmt,
      GLAcc.LocalCurrency,
      BsEqPl,
      TaxEffected
}
where
  AccountClassCode != 'RE'

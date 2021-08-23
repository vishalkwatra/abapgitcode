@AbapCatalog.sqlViewName: '/EY1/ERGSOBBETLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S OB EQ TE and BS Sum Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_OB_BETE_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD(p_ryear:$parameters.p_ryear)              as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_OB_EQ_LC(p_ryear:$parameters.p_ryear ,
                                               p_taxintention: $parameters.p_taxintention) as g2s on  g2s.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                  and g2s.GLAccount                    = GLAcc.GLAccount
                                                                                                  and g2s.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                  and g2s.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                  and g2s.LocalCurrency                = GLAcc.LocalCurrency
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,

      G2SAdjustmentAmount * -1 as G2SAdjustAmt,
      GLAcc.LocalCurrency,
      BsEqPl,
      TaxEffected
}
where
  AccountClassCode != 'RE'

@AbapCatalog.sqlViewName: '/EY1/ERG2SOBRELC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S OB Sum Values for RE LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_OB_RE_LC
  with parameters
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD(p_ryear:$parameters.p_ryear)                 as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_OB_ETERE_LC(p_ryear:$parameters.p_ryear,
                                                  p_taxintention: $parameters.p_taxintention) as g2s on  g2s.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                     and g2s.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                     and g2s.ChartOfAccounts              = GLAcc.ChartOfAccounts
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key GLAcc.AccountClassCode,
  key GLAcc.ConsolidationDimension,
  key GLAcc.FiscalYear,

      G2SAdjustAmt * -1 as G2SAdjustAmt,
      GLAcc.LocalCurrency,
      GLAcc.BsEqPl,
      GLAcc.TaxEffected
}
where
  AccountClassCode = 'RE'

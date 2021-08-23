@AbapCatalog.sqlViewName: '/EY1/ERGSPTBETGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB Pmt BS, EQ, TE and PBT GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_PmBETP_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD( p_ryear:$parameters.p_ryear) as GLAcc
    left outer join /EY1/SAV_I_ER_G2S_YB_Pmt_GC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)               as g2s on  g2s.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                      and g2s.GLAccount                    = GLAcc.GLAccount
                                                                                      and g2s.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                      and g2s.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                      and g2s.GroupCurrency                = GLAcc.GroupCurrency
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmtYearBalance * -1 as PmtYearBalance,
      @Semantics.currencyCode: true
      GLAcc.GroupCurrency,
      BsEqPl,
      TaxEffected,
      PBT
}
where
  (

        BsEqPl      = 'EQ'
    and TaxEffected = 'X'
    and PBT         = 'X'
  )
  or(
        BsEqPl      = 'BS'
  )

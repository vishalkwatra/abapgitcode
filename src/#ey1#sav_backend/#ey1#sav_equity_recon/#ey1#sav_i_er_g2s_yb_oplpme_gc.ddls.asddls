@AbapCatalog.sqlViewName: '/EY1/ERGSYOPPEGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB Other PL Pmt and Eq Values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_OPLPmE_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_BSEQTERE_MD(p_ryear:$parameters.p_ryear)                 as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_YB_OPL_GC(p_toperiod:$parameters.p_toperiod,
                                                p_ryear:$parameters.p_ryear ,
                                                p_taxintention: $parameters.p_taxintention)   as G2SOPl   on  G2SOPl.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                          and G2SOPl.GLAccount                    = GLAcc.GLAccount
                                                                                                          and G2SOPl.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                          and G2SOPl.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                          and G2SOPl.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_G2S_YB_OPmt_GC(p_toperiod:$parameters.p_toperiod,
                                                 p_ryear:$parameters.p_ryear ,
                                                 p_taxintention: $parameters.p_taxintention)  as G2SOPmnt on  G2SOPmnt.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                          and G2SOPmnt.GLAccount                    = GLAcc.GLAccount
                                                                                                          and G2SOPmnt.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                          and G2SOPmnt.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                          and G2SOPmnt.GroupCurrency                = GLAcc.GroupCurrency
    left outer join /EY1/SAV_I_ER_G2S_YB_OEqui_GC(p_toperiod:$parameters.p_toperiod,
                                                  p_ryear:$parameters.p_ryear ,
                                                  p_taxintention: $parameters.p_taxintention) as G2SOEq   on  G2SOEq.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                          and G2SOEq.GLAccount                    = GLAcc.GLAccount
                                                                                                          and G2SOEq.ConsolidationChartOfAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                          and G2SOEq.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                          and G2SOEq.GroupCurrency                = GLAcc.GroupCurrency
{
  key GLAcc.ChartOfAccounts,
  key GLAcc.ConsolidationUnit,
  key GLAcc.ConsolidationChartofAccounts,
  key GLAcc.GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key GLAcc.FiscalYear,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      GLAcc.GroupCurrency,

      BsEqPl,
      TaxEffected,
      PBT,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when oPlYearBalance is null then cast (0 as abap.curr( 23, 2))
      else oPlYearBalance *-1 end as OPlYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when oPmtYearBalance is null then cast (0 as abap.curr( 23, 2))
      else oPmtYearBalance*-1 end as OPmtYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when oEqYearBalance is null then cast (0 as abap.curr( 23, 2))
      else oEqYearBalance*-1 end  as OEqYearBalance
}
where
  (
        BsEqPl      = 'EQ'
    and TaxEffected = 'X'
  )
  or(
        BsEqPl      = 'BS'
  )

@AbapCatalog.sqlViewName: '/EY1/ERG2SCBRCLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S CB Reconciliation Check of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_CB_RChk_LC
  with parameters
    p_ryear        : gjahr,
    p_toyb         : poper,
    p_fromyb       : poper,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_PL_EQ_MD(p_ryear: $parameters.p_ryear) as GLAccnt

    left outer join /EY1/SAV_I_Rec_STAT_OB_YB_LC( p_ryear:$parameters.p_ryear ,
                    p_toyb: $parameters.p_toyb,
                    p_fromyb: $parameters.p_fromyb,
                    p_taxintention: $parameters.p_taxintention,
                    p_intention: $parameters.p_intention)                   as StatCB on  StatCB.GLAccount         = GLAccnt.GLAccount
                                                                                      and StatCB.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and StatCB.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                      and StatCB.LocalCurrency     = GLAccnt.LocalCurrency
                                                                                      and StatCB.ChartOfAccounts   = GLAccnt.ChartOfAccounts


{
  key GLAccnt.GLAccount,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,
      GLAccnt.ConsolidationChartofAccounts,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      StatClosingBalance as CBClosingBalance
      //sum(StatClosingBalance) as CBClosingBalance
}
//group by
//  GLAccnt.ConsolidationDimension,
//  GLAccnt.FiscalYear,
//  GLAccnt.ChartOfAccounts,
//  GLAccnt.ConsolidationUnit,
//  GLAccnt.LocalCurrency,
//  GLAccnt.ConsolidationChartofAccounts

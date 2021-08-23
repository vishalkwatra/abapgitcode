@AbapCatalog.sqlViewName: '/EY1/ERG2SYBRCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S YB Reconciliation Check of values GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_RChk_GC
  with parameters
    p_ryear         : gjahr,
    p_fromyb        : poper,
    p_toyb          : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_PL_MD(p_ryear: $parameters.p_ryear) as GLAccnt

    left outer join /EY1/SAV_I_Rec_STAT_OB_YB_GC( p_ryear:$parameters.p_ryear ,
                    p_fromyb: $parameters.p_fromyb,
                    p_toyb: $parameters.p_toyb,
                    p_switch: $parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention)        as StatCB on  StatCB.GLAccount         = GLAccnt.GLAccount
                                                                                   and StatCB.FiscalYear        = GLAccnt.FiscalYear
                                                                                   and StatCB.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                   and StatCB.GroupCurrency     = GLAccnt.GroupCurrency
                                                                                   and StatCB.ChartOfAccounts   = GLAccnt.ChartOfAccounts


{
  key GLAccnt.GLAccount,
      //      key GLAccnt.AccountClassCode,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,
      //key StatCB.ConsolidationLedger,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,
      GLAccnt.ConsolidationChartofAccounts,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      StatClosingBalance as YBClosingBalance
      // sum(StatOpeningBalance) as StatOpeningBalance
      //GLAccnt.BsEqPl,
      //GLAccnt.TaxEffected
}
//group by
//  GLAccnt.ConsolidationDimension,
//  GLAccnt.FiscalYear,
//  GLAccnt.ChartOfAccounts,
//  GLAccnt.ConsolidationUnit,
//  GLAccnt.GroupCurrency,
//  GLAccnt.ConsolidationChartofAccounts
//GLAccnt.AccountClassCode

@AbapCatalog.sqlViewName: '/EY1/ERS2TOBRKGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER S2T OB Reconciliation Check of values GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_RChk_GC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention,
    p_toyb         : poper
  as select from    /EY1/SAV_I_GlAcc_EQ_MD(p_ryear: $parameters.p_ryear) as GLAccnt

    left outer join /EY1/SAV_I_Rec_TAX_OBNR_GC( p_ryear:$parameters.p_ryear ,
                    p_periodto:$parameters.p_toyb ,
                    p_taxintention:$parameters.p_taxintention,
                    p_intention:$parameters.p_intention )                as TaxOB on  TaxOB.GLAccount         = GLAccnt.GLAccount
                                                                                  and TaxOB.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and TaxOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                  and TaxOB.GroupCurrency     = GLAccnt.GroupCurrency
                                                                                  and TaxOB.ChartOfAccounts   = GLAccnt.ChartOfAccounts


{
  key GLAccnt.GLAccount,
      //key GLAccnt.AccountClassCode,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,
      //key TaxOB.ConsolidationLedger,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,
      GLAccnt.ConsolidationChartofAccounts,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      TaxOpeningBalance as TaxOpeningBalance
      //GLAccnt.BsEqPl,
      //GLAccnt.TaxEffected
}
//group by
//GLAccnt.ConsolidationDimension,
//GLAccnt.FiscalYear,
//GLAccnt.ChartOfAccounts,
//GLAccnt.ConsolidationUnit,
//GLAccnt.GroupCurrency,
//GLAccnt.ConsolidationChartofAccounts
//GLAccnt.AccountClassCode

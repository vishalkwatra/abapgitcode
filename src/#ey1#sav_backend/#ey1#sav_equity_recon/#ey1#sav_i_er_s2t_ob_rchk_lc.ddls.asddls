@AbapCatalog.sqlViewName: '/EY1/ERS2TOBRKLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER S2T OB Reconciliation Check of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_RChk_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention,
    p_toyb         : poper
  as select from    /EY1/SAV_I_GlAcc_EQ_MD(p_ryear: $parameters.p_ryear) as GLAccnt

    left outer join /EY1/SAV_I_Rec_TAX_OBNR_LC( p_ryear:$parameters.p_ryear ,
                    p_periodto:$parameters.p_toyb ,
                    p_taxintention:$parameters.p_taxintention,
                    p_intention:$parameters.p_intention )                as TAXOB on  TAXOB.GLAccount         = GLAccnt.GLAccount
                                                                                  and TAXOB.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and TAXOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                  and TAXOB.LocalCurrency     = GLAccnt.LocalCurrency
                                                                                  and TAXOB.ChartOfAccounts   = GLAccnt.ChartOfAccounts


{
  key GLAccnt.GLAccount,
      //key GLAccnt.AccountClassCode,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,
      //key TAXOB.ConsolidationLedger,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,
      GLAccnt.ConsolidationChartofAccounts,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      TaxOpeningBalance as TAXOpeningBalance
      //GLAccnt.BsEqPl,
      //GLAccnt.TaxEffected
}
//group by
//GLAccnt.ConsolidationDimension,
//GLAccnt.FiscalYear,
//GLAccnt.ChartOfAccounts,
//GLAccnt.ConsolidationUnit,
//GLAccnt.LocalCurrency,
//GLAccnt.ConsolidationChartofAccounts
//GLAccnt.AccountClassCode

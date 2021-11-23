@AbapCatalog.sqlViewName: '/EY1/ERS2TCBRCLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER S2T CB Reconciliation Check of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_CB_RChk_LC
  with parameters
    p_ryear        : gjahr,
    p_toyb         : poper,
    p_fromyb       : poper,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_PL_EQ_MD(p_ryear: $parameters.p_ryear) as GLAccnt

    left outer join /EY1/SAV_I_Rec_TAX_OB_YB_LC( p_ryear:$parameters.p_ryear ,
                    p_fromyb: $parameters.p_fromyb,
                    p_toyb: $parameters.p_toyb,
                    p_taxintention: $parameters.p_taxintention,
                    p_intention: $parameters.p_intention)                   as TAXCB on  TAXCB.GLAccount         = GLAccnt.GLAccount
                                                                                     and TAXCB.FiscalYear        = GLAccnt.FiscalYear
                                                                                     and TAXCB.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                     and TAXCB.LocalCurrency     = GLAccnt.LocalCurrency
                                                                                     and TAXCB.ChartOfAccounts   = GLAccnt.ChartOfAccounts


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
      TaxClosingBalance as CBClosingBalance
      //sum(TAXClosingBalance) as CBClosingBalance
}
//group by
//  GLAccnt.ConsolidationDimension,
//  GLAccnt.FiscalYear,
//  GLAccnt.ChartOfAccounts,
//  GLAccnt.ConsolidationUnit,
//  GLAccnt.LocalCurrency,
//  GLAccnt.ConsolidationChartofAccounts

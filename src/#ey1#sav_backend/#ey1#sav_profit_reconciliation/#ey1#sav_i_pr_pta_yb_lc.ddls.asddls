@AbapCatalog.sqlViewName: '/EY1/PRPTAYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- PTA Mvmnt LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_PTA_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
   
    
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                 as GLAccnt
                 
    left outer join /EY1/SAV_I_PR_PTA_Pmnt_YB_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
             p_taxintention:$parameters.p_taxintention) as PTAPmntYBLC on  PTAPmntYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                and PTAPmntYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and PTAPmntYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                and GLAccnt.ProfitBeforeTax       = 'X'
                                                                                and BsEqPl                        = 'P&L'
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.FiscalYear,
  key GLAccnt.GLAccount,
  key AccountClassCode,
      GLAccnt.ConsolidationDimension,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast(0 as abap.curr( 23, 2 )) as PTATransactionsPL,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PTATransactionsPmnt           as PTATransactionsPmnt,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PTATransactionsPmnt           as TransactionTotal
}
where
      GLAccnt.ProfitBeforeTax = 'X'
  and BsEqPl                  = 'P&L'

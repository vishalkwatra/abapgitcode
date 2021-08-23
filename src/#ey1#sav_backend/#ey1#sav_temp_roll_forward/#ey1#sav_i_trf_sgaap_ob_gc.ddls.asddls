@AbapCatalog.sqlViewName: '/EY1/ISGOBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd SGAAP OB Temp Diff-GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_OB_GC
  with parameters
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention  
  as select from /EY1/SAV_I_TRF_SGAAP_OB_NRM_GC
                 (p_ryear:$parameters.p_ryear,
                 p_taxintention :$parameters.p_taxintention ) as GLAccnt
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      //      GLAccnt.AccountClassCode,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlOpeningBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmntOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqOpeningBalance + PlOpeningBalance + PmntOpeningBalance as TempDiffOpeningBalance
}

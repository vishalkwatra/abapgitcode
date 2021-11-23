@AbapCatalog.sqlViewName: '/EY1/IRGPYAGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP PYA GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_PYA_GC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
     p_toperiod     : poper
  as select from /EY1/SAV_I_TRF_RGAAP_PYA_NR_GC
                 (p_ryear:$parameters.p_ryear,
                  p_taxintention :$parameters.p_taxintention,
                  p_toperiod :$parameters.p_toperiod  ) as GLAccnt

{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAPLAmount                   as PYAPl,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAPmnt,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOpl,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOpmnt,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOeq,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAPLAmount + PYAPmnt + PYAEq as PYABal,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOpl + PYAOpmnt + PYAOeq    as PYAOBal
}

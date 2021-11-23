@AbapCatalog.sqlViewName: '/EY1/IRGPYALC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP PYA LC'

@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_PYA_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select from /EY1/SAV_I_TRF_RGAAP_PYA_NR_LC
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
      GLAccnt.LocalCurrency,


      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPLAmount                   as PYAPl,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPmnt,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAEq,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpl,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpmnt,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOeq,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPLAmount + PYAPmnt + PYAEq as PYABal,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpl + PYAOpmnt + PYAOeq    as PYAOBal
}

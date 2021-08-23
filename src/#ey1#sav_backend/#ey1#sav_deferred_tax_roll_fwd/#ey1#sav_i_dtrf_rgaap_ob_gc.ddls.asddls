@AbapCatalog.sqlViewName: '/EY1/DTRFROBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward OB GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_RGAAP_OB_GC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention

  as select from /EY1/SAV_I_DTRF_RGAAP_OB_NRMGC
                  (p_rbunit :$parameters.p_rbunit,
                   p_toperiod :$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention :$parameters.p_taxintention ) as GLAccnt

{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      GaapOBRate,
      GaapCBRate,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when EqOpeningBalance is null then cast(0 as abap.curr( 23, 2 ))
      else EqOpeningBalance end    as EqOpeningBalance,


      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when  PlOpeningBalance is null then cast(0 as abap.curr( 23, 2 ))
      else ( PlOpeningBalance) end as PlOpeningBalance
}
where
  ConsolidationUnit = $parameters.p_rbunit

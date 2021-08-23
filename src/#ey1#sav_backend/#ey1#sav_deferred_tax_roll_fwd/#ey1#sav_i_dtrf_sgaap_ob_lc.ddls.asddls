@AbapCatalog.sqlViewName: '/EY1/DTRFSOBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for DTRF SGAAP OB - LC'
@VDM.viewType: #COMPOSITE
  
define view /EY1/SAV_I_DTRF_SGAAP_OB_LC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_DTRF_SGAAP_OB_NRMLC
                 (p_rbunit:$parameters.p_rbunit,
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
      GLAccnt.LocalCurrency,

      StatOBRate,
      StatCBRate,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      //      EqOpeningBalance,
      case when EqOpeningBalance is null then cast(0 as abap.curr( 23, 2 ))
      else EqOpeningBalance end    as EqOpeningBalance,


      @Semantics.amount.currencyCode: 'LocalCurrency'
      //      PlOpeningBalance
      case when  PlOpeningBalance is null then cast(0 as abap.curr( 23, 2 ))
      else ( PlOpeningBalance) end as PlOpeningBalance

}

@AbapCatalog.sqlViewName: '/EY1/DTRFSYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View DTRF SGAAP YB -LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_SGAAP_YB_LC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_DTRF_SGAAP_YB_NRMLC
                   (p_rbunit:$parameters.p_rbunit,
                   p_toperiod :$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention :$parameters.p_taxintention ) as GLAccnt

{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      StatOBRate,
      StatCBRate,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      //      PlYB * GaapOBRate * MultiFactor as PlYearBalance,
      case when PlYearBalance is null then cast(0 as abap.curr( 23, 2 ))
            else PlYearBalance end  as PlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      //      EqYB * GaapOBRate * MultiFactor as EqYearBalance,
      case when EqYearBalance is null then cast(0 as abap.curr( 23, 2 ))
            else EqYearBalance end  as EqYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      //      OPlYB * GaapOBRate * MultiFactor as OPlYearBalance,
      case when OPlYearBalance is null then cast(0 as abap.curr( 23, 2 ))
            else OPlYearBalance end as OPlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      //      OEqYB * GaapOBRate * MultiFactor as OEqYearBalance
      case when OEqYearBalance is null then cast(0 as abap.curr( 23, 2 ))
            else OEqYearBalance end as OEqYearBalance
}

@AbapCatalog.sqlViewName: '/EY1/ISGYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP CY Mvmnt - GC'

@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_YB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention
  as select from /EY1/SAV_I_TRF_SGAAP_YB_NRM_GC( p_toperiod:$parameters.p_toperiod,
                                             p_ryear:$parameters.p_ryear,
                                             p_taxintention:$parameters.p_taxintention )
{ ///EY1/SAV_I_SGAAP_YB_NMR_GC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,

      ConsolidationDimension,
      FinancialStatementItem,
      @Semantics.currencyCode: true
      GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmntYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OPmntYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OEqYearBalance,

      //Tax Rates
//      GaapOBRate,
//      GaapCBRate,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance + PmntYearBalance + EqYearBalance    as TempTransType,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      OPlYearBalance + OPmntYearBalance + OEqYearBalance as TempOtherTransType
}

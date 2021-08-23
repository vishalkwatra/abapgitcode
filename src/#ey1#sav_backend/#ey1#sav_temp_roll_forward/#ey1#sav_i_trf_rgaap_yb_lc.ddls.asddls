@AbapCatalog.sqlViewName: '/EY1/IRGYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP CY Mvmnt - LC'

@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention    
     as select from /EY1/SAV_I_TRF_RGAAP_YB_NRM_LC( p_toperiod:$parameters.p_toperiod,
                                             p_ryear:$parameters.p_ryear,
                                             p_taxintention:$parameters.p_taxintention )
{ ///EY1/SAV_I_RGAAP_YB_NMR_LC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,

      ConsolidationDimension,
      FinancialStatementItem,
      @Semantics.currencyCode: true
      LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmntYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPmntYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OEqYearBalance,

//      //Tax Rates
//      GaapOBRate,
//      GaapCBRate,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance + PmntYearBalance + EqYearBalance    as TempTransType,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYearBalance + OPmntYearBalance + OEqYearBalance as TempOtherTransType
}
    

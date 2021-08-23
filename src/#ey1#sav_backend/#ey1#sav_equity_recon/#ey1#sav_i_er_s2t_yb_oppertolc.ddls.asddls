@AbapCatalog.sqlViewName: '/EY1/ERSTOPPERTL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T YB Othr RE Total Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_YB_OPPERToLC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_S2T_YB_OPPERE_LC(
                 p_toperiod:$parameters.p_toperiod ,
                 p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention )
{


  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      LocalCurrency,
      BsEqPl,
      TaxEffected,
      PBT,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPmtYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OEqYearBalance,
      OPlYearBalance+OPmtYearBalance+OEqYearBalance as OthrTotalYearBalance

}

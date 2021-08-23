@AbapCatalog.sqlViewName: '/EY1/ERS2TCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T CB Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_CB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_S2T_CB_NRM_LC(
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

      @Semantics.currencyCode: 'true'
      LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      S2TAdjustAmt,

      S2TPYA,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance,


      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmtYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqTotalYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      OthrTotalYearBalance,

      S2TCTA,

      BsEqPl,
      TaxEffected,
      PBT,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      S2TAdjustAmt+S2TPYA+PlYearBalance+PmtYearBalance+EqTotalYearBalance+OthrTotalYearBalance+S2TCTA as CBYearBalance
}
where
     S2TAdjustAmt != 0
  or S2TPYA != 0
  or PlYearBalance != 0
  or PmtYearBalance != 0
  or EqTotalYearBalance != 0
  or OthrTotalYearBalance != 0
  or S2TCTA != 0

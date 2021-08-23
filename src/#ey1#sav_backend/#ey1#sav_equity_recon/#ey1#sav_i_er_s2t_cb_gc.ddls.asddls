@AbapCatalog.sqlViewName: '/EY1/ERS2TCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize  ER S2T CB Values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_CB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_S2T_CB_NRM_GC(
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
      GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      S2TAdjustAmt,

      S2TPYA,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance,


      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmtYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqTotalYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      OthrTotalYearBalance,

      S2TCTA,

      BsEqPl,
      TaxEffected,
      PBT,
      @Semantics.amount.currencyCode: 'GroupCurrency'
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

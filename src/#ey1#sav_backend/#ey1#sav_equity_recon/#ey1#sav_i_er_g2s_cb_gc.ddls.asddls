@AbapCatalog.sqlViewName: '/EY1/ERG2SCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize  ER G2S CB Values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_CB_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_G2S_CB_NRM_GC(p_toperiod:$parameters.p_toperiod ,
                                             p_ryear:$parameters.p_ryear ,
                                             p_taxintention: $parameters.p_taxintention )
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
      G2SAdjustAmt,

      G2SPYA,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmtYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqTotalYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      OthrTotalYearBalance,

      G2SCTA,
      BsEqPl,
      TaxEffected,
      PBT,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      G2SAdjustAmt+G2SPYA+PlYearBalance+PmtYearBalance+EqTotalYearBalance+OthrTotalYearBalance+G2SCTA as CBYearBalance
}
where
     G2SAdjustAmt != 0
  or G2SPYA != 0
  or PlYearBalance != 0
  or PmtYearBalance != 0
  or EqTotalYearBalance != 0
  or OthrTotalYearBalance != 0
  or G2SCTA != 0

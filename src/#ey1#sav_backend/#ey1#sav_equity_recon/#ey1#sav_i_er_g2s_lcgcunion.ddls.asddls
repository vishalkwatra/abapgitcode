@AbapCatalog.sqlViewName: '/EY1/ERG2SLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER G2S LCGC Union values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_LCGCUnion
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_G2S_LC(p_toperiod:$parameters.p_toperiod,
                                      p_ryear:$parameters.p_ryear,
                                      p_taxintention: $parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,

      @Semantics.currencyCode: true
      LocalCurrency as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SAdjustAmt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      PmtYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SCYABalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      EqTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OthrTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SCTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      CBYearBalance,

      CurrencyType
}

union all select from /EY1/SAV_I_ER_G2S_GC(p_toperiod:$parameters.p_toperiod,
                                           p_ryear:$parameters.p_ryear,
                                           p_taxintention: $parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,

      @Semantics.currencyCode: true
      GroupCurrency as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SAdjustAmt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPYA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      PmtYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SCYABalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      EqTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OthrTotalYearBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SCTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      CBYearBalance,

      CurrencyType
}

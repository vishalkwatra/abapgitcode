@AbapCatalog.sqlViewName: '/EY1/ERS2TLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER S2T LCGC Union values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_LCGCUnion
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_S2T_LC(p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)
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
      S2TAdjustAmt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TPYA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmtYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TCYABalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqTotalYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OthrTotalYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TCTA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CBYearBalance,

      CurrencyType
}
union all select from /EY1/SAV_I_ER_S2T_GC(p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention)
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
      S2TAdjustAmt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TPYA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmtYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TCYABalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqTotalYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OthrTotalYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TCTA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CBYearBalance,

      CurrencyType
}

@AbapCatalog.sqlViewName: '/EY1/ERS2T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER Gaap2Stat'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_Stat2Tax
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_S2T_LCGCUnion(p_toperiod:$parameters.p_toperiod,
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
      MainCurrency,

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
where
     S2TAdjustAmt != 0
  or S2TPYA != 0
  or PlYearBalance != 0
  or PmtYearBalance != 0
  or EqTotalYearBalance != 0
  or OthrTotalYearBalance != 0
  or S2TCTA != 0
  or CBYearBalance != 0
  or AccountClassCode='RE'

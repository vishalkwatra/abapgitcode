@AbapCatalog.sqlViewName: '/EY1/ERG2S'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch  ER Gaap2Stat'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_Gaap2Stat
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_G2S_LCGCUnion(p_toperiod:$parameters.p_toperiod,
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
where
     G2SAdjustAmt != 0
  or G2SPYA != 0
  or PlYearBalance != 0
  or PmtYearBalance != 0
  or EqTotalYearBalance != 0
  or OthrTotalYearBalance != 0
  or G2SCTA != 0
  or CBYearBalance != 0
  or AccountClassCode='RE'

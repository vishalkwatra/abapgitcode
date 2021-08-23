@AbapCatalog.sqlViewName: '/EY1/CETRITCTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View- ETR- Summary- Inc Taxed at Different Current Tax Rate'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ETR_SUM_ITDCTR
  with parameters
    p_rbunit        : fc_bunit,
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_currtype      : /ey1/sav_currency_type,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_ETR_SUM_ITDCTR
                 (p_rbunit:$parameters.p_rbunit,
                 p_ryear: $parameters.p_ryear,
                 p_fromperiod: $parameters.p_fromperiod,
                 p_toperiod: $parameters.p_toperiod,
                 p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention,
                 p_currtype: $parameters.p_currtype,
                 p_intention: $parameters.p_intention) as ETR
{
  key CountryKey,
  key FiscalYear,
  key Intention,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key Sequence,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TierAmountLC,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TierAmountGC,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Amount,

      Tax,
      Percentage,

      @Semantics.currencyCode: true
      @EndUserText.label: 'CCY'
      MainCurrency,

      Rate,

      // Exposed for Virtual Element - Fields should be same as in Virtual Element class.
      CurrentTaxRate,
      LocalCurrency,
      Period,
      SPeriod,
      CurrencyType,

      FromPeriod,
      Switch

}

@AbapCatalog.sqlViewName: '/EY1/CPRCTE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to Fetch CTE Details'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_PR_CTE_Details
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention,
    p_currtype      : /ey1/sav_currency_type,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_CTE_Details( p_cntry:$parameters.p_cntry,
                                              p_ryear:$parameters.p_ryear,
                                              p_toperiod:$parameters.p_toperiod,
                                              p_taxintention:$parameters.p_taxintention,
                                              p_currtype:$parameters.p_currtype,
                                             p_intention:$parameters.p_intention)
{
  key CountryKey,
  key FiscalYear,
  key Intention,
  key Sequence,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      LocalCurrency,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      MainCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      TierAmountLC,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TierAmountGC,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Amount,
      TaxRate,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Tax,
      Period,
      SPeriod,
      CurrencyType
}

@AbapCatalog.sqlViewName: '/EY1/ETRSUMITCTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP- Summary- Inc Taxed at Current Tax Rate'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_ITDCTR
  with parameters
    p_rbunit        : fc_bunit,
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_currtype      : /ey1/sav_currency_type,
    p_intention     : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_SUM_TierAmount
                 (p_rbunit:$parameters.p_rbunit,
                  p_ryear: $parameters.p_ryear,
                  p_toperiod: $parameters.p_toperiod,
                  p_taxintention: $parameters.p_taxintention,
                  p_currtype: $parameters.p_currtype,
                  p_intention: $parameters.p_intention) as Tiers
{
      //Tiers
  key CountryKey,
  key FiscalYear,
  key Intention,
  key Sequence,
      TierAmountLC,
      TierAmountGC,
      Amount,
      Tax,
      Percentage,
      MainCurrency,
      Rate,
      CurrentTaxRate,
      LocalCurrency,
      Period,
      SPeriod,
      CurrencyType,

      $parameters.p_fromperiod as FromPeriod,
      $parameters.p_switch     as Switch

}

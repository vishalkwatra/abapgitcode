@AbapCatalog.sqlViewName: '/EY1/CCTETOTAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C View to fetch sum value of CTE Tax'
@VDM.viewType: #CONSUMPTION
define view /EY1/SAV_C_PR_CTE_Total
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention,
    p_currtype      : /ey1/sav_currency_type,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_CTE_Total ( p_cntry:$parameters.p_cntry,
                                           p_ryear:$parameters.p_ryear,
                                           p_toperiod:$parameters.p_toperiod,
                                           p_taxintention:$parameters.p_taxintention,
                                           p_currtype:$parameters.p_currtype,
                                           p_intention:$parameters.p_intention)
{ ///EY1/SAV_I_PR_CTE_Total
  key CountryKey,
  key FiscalYear,
  key Intention,
  key Sequence,

      TierAmountLC,
      TierAmountGC,
      Amount,
      TaxRate,
      Tax,
      SumTax,
      OtherTaxCredit,
      TotalCurrentCorpIncTaxExp,
      CorpIncTaxReceivable,
      WitholdingTaxCredit,
      CorpIncTaxPayCY,
      TransferInOut,
      SubTotal,
      CTA,
      CorpIncReceivable,
      Period,
      SPeriod,
      CurrencyType,
      LocalCurrency
}

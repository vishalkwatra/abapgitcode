@AbapCatalog.sqlViewName: '/EY1/ISTRTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - View to fetch Stat Tax Rate Difference Tax Value'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CTE_StatTaxRate
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_STR_Amount_Cal
                 ( p_toperiod:$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention:$parameters.p_taxintention,
                   p_intention :$parameters.p_intention)

{ ///EY1/SAV_I_PR_STR_Amount_Cal
  key ConsolidationUnit,
  key CountryKey,
  key FiscalYear,

      ConsolidationDimension,
      TaxRate,
      TierAmount,
      TierAmountCurrency,
      TempTaxValue,
      TaxCurrency,

      AmountLC,
      StatutoryTaxLC,
      
      AmountGC,
      StatutoryTaxGC,

      CurrencyType,

      Period,
      SPeriod,
      Intention
}

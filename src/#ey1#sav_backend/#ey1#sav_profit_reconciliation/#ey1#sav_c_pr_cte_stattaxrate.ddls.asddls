@AbapCatalog.sqlViewName: '/EY1/CSTRTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Stat Tax Rate Calculation'
@VDM.viewType: #CONSUMPTION
define view /EY1/SAV_C_PR_CTE_StatTaxRate
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_CTE_StatTaxRate
                 ( p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention,
                 p_intention :$parameters.p_intention)

{ ///EY1/SAV_I_PR_CTE_StatTaxRate
  key ConsolidationUnit,
  key CountryKey,
  key FiscalYear,

      ConsolidationDimension,
      TempTaxValue,
      TaxCurrency,
      TaxRate,
      TierAmount,
      TierAmountCurrency,
      AmountLC,
      StatutoryTaxLC,
      AmountGC,
      StatutoryTaxGC,
      CurrencyType,
      Period,
      SPeriod,
      Intention
}

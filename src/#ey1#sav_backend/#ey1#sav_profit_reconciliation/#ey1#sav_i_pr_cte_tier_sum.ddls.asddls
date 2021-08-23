@AbapCatalog.sqlViewName: '/EY1/ITIERSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I view to fetch the sum of all tiers'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CTE_TIER_SUM
  as select from /EY1/SAV_I_TIERS
{ ///EY1/SAV_I_TIERS
  key CountryKey,
  key FiscalYear,
  key Intention,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(TierAmount) as TierAmount,
      LocalCurrency
}
group by
  CountryKey,
  FiscalYear,
  Intention,
  LocalCurrency

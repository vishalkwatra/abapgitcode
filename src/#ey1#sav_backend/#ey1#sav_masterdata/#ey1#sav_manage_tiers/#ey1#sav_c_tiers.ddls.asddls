@AbapCatalog.sqlViewName: '/EY1/SAVCTIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to Fetch Tier Details'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_TIERS
  as select from /EY1/SAV_I_TIERS

{ ///EY1/SAV_I_TIERS
  key     CountryKey,
  key     FiscalYear,
  key     Intention,
  key     Sequence,

          @Semantics.amount.currencyCode: 'LocalCurrency'
          TierAmount,
          TaxRate,

          @Semantics.currencyCode: true
          LocalCurrency
}

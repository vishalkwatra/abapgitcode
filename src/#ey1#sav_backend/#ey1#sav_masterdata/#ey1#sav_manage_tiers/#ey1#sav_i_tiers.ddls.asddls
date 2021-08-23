@AbapCatalog.sqlViewName: '/EY1/SAVITIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to Fetch Tier Details'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_TIERS
  as select from /ey1/manage_tier
{ ///EY1/MANAGE_TIER
  key land1          as CountryKey,
  key ryear          as FiscalYear,
  key intention      as Intention,
  key seqnr_flb      as Sequence,

      tier_amount    as TierAmount,

      tax_rate       as TaxRate,
      local_currency as LocalCurrency
}

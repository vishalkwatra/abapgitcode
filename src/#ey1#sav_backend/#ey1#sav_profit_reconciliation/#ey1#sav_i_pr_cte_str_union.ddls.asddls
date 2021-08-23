@AbapCatalog.sqlViewName: '/EY1/IPRCTESTRU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View to fetch details of Manage Tiers & Stat Tax Rate'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_CTE_STR_Union
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention,
    p_intention     : /ey1/sav_intent

  as select distinct from /EY1/SAV_I_PR_CTE_TIER_SUM                         as TierSum

    left outer join       /EY1/SAV_I_PR_TaxIncLoss_Sign
                    ( p_toperiod:$parameters.p_toperiod,
                                p_ryear:$parameters.p_ryear,
                                p_taxintention:$parameters.p_taxintention) as TaxInc  on  TaxInc.Country    = TierSum.CountryKey
                                                                                        and TaxInc.FiscalYear = TierSum.FiscalYear

    left outer join       /EY1/SAV_I_CTR_Tax_Rate                            as TaxRate on  TaxInc.ConsolidationUnit = TaxRate.rbunit
                                                                                        and TaxInc.FiscalYear        = TaxRate.gjahr
                                                                                        and TaxRate.intention        = $parameters.p_intention

{ //Tiers
  key CountryKey,
  key TierSum.FiscalYear,
  key TierSum.Intention,

  key cast( '' as abap.char(2) ) as Sequence,
      cast(0 as abap.curr(23,2)) as TierAmount,

      TaxRate.current_tax_rate   as TaxRate,

      LocalCurrency
}
where
      CountryKey         = $parameters.p_cntry
  and TierSum.FiscalYear = $parameters.p_ryear
  and TierSum.Intention  = $parameters.p_intention

union all select from /EY1/SAV_I_TIERS as Tiers
{ ///EY1/SAV_I_TIERS
  key Tiers.CountryKey,
  key Tiers.FiscalYear,
  key Tiers.Intention,
  key Sequence,

      TierAmount,
      TaxRate,
      LocalCurrency
}
where
      Tiers.CountryKey = $parameters.p_cntry
  and Tiers.FiscalYear = $parameters.p_ryear
  and Tiers.Intention  = $parameters.p_intention

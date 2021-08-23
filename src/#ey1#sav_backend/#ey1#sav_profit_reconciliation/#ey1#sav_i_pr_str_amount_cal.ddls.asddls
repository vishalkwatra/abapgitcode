@AbapCatalog.sqlViewName: '/EY1/IFETCHSTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - View to fetch Stat Tax Rate Amount value'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_STR_Amount_Cal
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_CTE_STR_AMT_LCGC
                 ( p_toperiod:$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention:$parameters.p_taxintention,
                   p_intention:$parameters.p_intention) as STRAmt
{ //STRAmt
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
      TaxRate * AmountLC * MultiFactor as StatutoryTaxLC,
      
      AmountGC,
      StatutoryTaxGC,

      MultiFactor,
      CurrencyType,

      Period,
      SPeriod,
      Intention
}

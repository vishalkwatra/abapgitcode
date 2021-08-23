@AbapCatalog.sqlViewName: '/EY1/ICTE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - Current Tax Expense/Benefits'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CTE_Details
  with parameters
    p_cntry        : land1,
    p_ryear        : gjahr,
    p_toperiod     : poper,
    p_taxintention : zz1_taxintention,
    p_currtype     : /ey1/sav_currency_type,
    p_intention    : /ey1/sav_intent

  as select from    /EY1/SAV_I_PR_CTE_STR_Union
                 ( p_cntry:$parameters.p_cntry,
                    p_ryear:$parameters.p_ryear,
                    p_toperiod:$parameters.p_toperiod,
                    p_taxintention:$parameters.p_taxintention,
                    p_intention:$parameters.p_intention) as Tiers

    left outer join /EY1/SAV_I_Fetch_Tax_Rate_TXP
                    ( p_ryear:$parameters.p_ryear )      as TaxRateTXP on  TaxRateTXP.ConsolidationUnit = ConsolidationUnit
                                                                       and TaxRateTXP.FiscalYear        = Tiers.FiscalYear

{ ///EY1/SAV_I_TIERS
  key CountryKey,
  key Tiers.FiscalYear,
  key Tiers.Intention,

  key Sequence,

      TierAmount                  as TierAmountLC,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CurrentTaxExp'
      cast( 0 as wertv12)         as TierAmountGC,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CurrentTaxExp'
      cast( 0 as wertv12)         as Amount,

      case
      when TaxRate is null then TaxRateTXP.CurrentTaxRate
      else TaxRate end            as TaxRate,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CurrentTaxExp'
      cast( 0 as wertv12)         as Tax,

      $parameters.p_toperiod      as Period,
      $parameters.p_taxintention  as SPeriod,
      $parameters.p_currtype      as CurrencyType,

      LocalCurrency,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CurrentTaxExp'
      cast( '' as abap.cuky( 5 )) as MainCurrency
}
//where
//      CountryKey       = $parameters.p_cntry
//  and Tiers.FiscalYear = $parameters.p_ryear

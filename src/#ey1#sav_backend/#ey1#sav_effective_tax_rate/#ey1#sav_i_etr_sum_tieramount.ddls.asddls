@AbapCatalog.sqlViewName: '/EY1/ETRSUMTRAMT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- Summary- Calc Tier Amount'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_TierAmount
  with parameters
    p_rbunit        : fc_bunit,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention,
    p_currtype      : /ey1/sav_currency_type,
    p_intention     : /ey1/sav_intent
  as select from    /EY1/SAV_I_TIERS                as Tiers
    left outer join A_CnsldtnUnit                   as Country  on Country.ConsolidationUnit = $parameters.p_rbunit

    left outer join /EY1/SAV_I_Get_Tax_Rate( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_rbunit: $parameters.p_rbunit) as TaxRates on  TaxRates.ConsolidationUnit = $parameters.p_rbunit
                                                                and Country.Country            = Tiers.CountryKey
                                                                and TaxRates.FiscalYear        = Tiers.FiscalYear
  //            and TaxRates.Intention         = Tiers.Intention

{
  key CountryKey,
  key Tiers.FiscalYear,
  key Tiers.Intention,
  key Sequence,

      // Tier Amount in Local Currency - Used in Local Currency Calculation
      TierAmount                  as TierAmountLC,

      // Tier Amount in Group Currency - Used in Group Currency Calculation
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_ETR_INCTAXEDATCTR'
      cast(0 as wertv12)          as TierAmountGC,

      // Splitted Amount
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_ETR_INCTAXEDATCTR'
      cast(0 as wertv12)          as Amount,

      // TAX = 'Rate' % of Amounnt
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_ETR_INCTAXEDATCTR'
      cast(0 as wertv12)          as Tax,

      //   Percentage = (Tax / PBT) * 100
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_ETR_INCTAXEDATCTR'
      cast(0 as /ey1/sav_rate)    as Percentage,

      // Group Currency maintained to corresponding Consolidation Unit
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_ETR_INCTAXEDATCTR'
      cast( '' as abap.cuky( 5 )) as MainCurrency,

      //    Rate = TierRate - Current Tax Rate
      case
        when TaxRate  is null
        then 0 - CurrentTaxRate

        when CurrentTaxRate  is null
        then TaxRate - 0

        else TaxRate - CurrentTaxRate
      end                         as Rate,
      //      cast(TaxRate as /ey1/sav_tax_rate) - cast(CurrentTaxRate as /ey1/sav_current_tax_rate) as Rate,

      TaxRate,
      // Used for caluclation in virtual element
      CurrentTaxRate,

      // Local Currency maintained in Manage Tiers
      LocalCurrency,



      $parameters.p_toperiod      as Period,
      $parameters.p_taxintention as SPeriod,
      $parameters.p_currtype      as CurrencyType
}
where
      Tiers.CountryKey = Country.Country
  and Tiers.FiscalYear = $parameters.p_ryear
  and Tiers.Intention  = $parameters.p_intention

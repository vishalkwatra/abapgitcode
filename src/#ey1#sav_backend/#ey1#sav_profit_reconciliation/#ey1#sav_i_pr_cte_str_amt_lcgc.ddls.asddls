@AbapCatalog.sqlViewName: '/EY1/STRAMTLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - View to fetch sum of tier amout for LC & GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CTE_STR_AMT_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_TaxIncLoss_Sign
                 ( p_toperiod:$parameters.p_toperiod,
                     p_ryear:$parameters.p_ryear,
                     p_taxintention:$parameters.p_taxintention) as TaxInc

    inner join   /EY1/SAV_I_PR_CTE_TIER_SUM                       as TierSum on  TaxInc.Country    = TierSum.CountryKey
                                                                             and TaxInc.FiscalYear = TierSum.FiscalYear

    inner join   /EY1/SAV_I_CTR_Tax_Rate                          as TaxRate on  TaxInc.ConsolidationUnit = TaxRate.rbunit
                                                                             and TaxInc.FiscalYear        = TaxRate.gjahr
                                                                             and TaxRate.intention        = $parameters.p_intention
{ //TaxInc
  key ConsolidationUnit,
  key CountryKey,
  key TierSum.FiscalYear,
        
      ConsolidationDimension,
      TempTaxValue,
      
      @Semantics.currencyCode: true
      MainCurrency as TaxCurrency,
      
      TaxRate.current_tax_rate                                       as TaxRate,

      TierAmount                                                     as TierAmount,

      cast(case when TempTaxValue > TierAmount
      then TempTaxValue - TierAmount
      else cast(0 as abap.curr( 23, 2 ))  end as abap.curr( 23, 2 )) as AmountLC,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_StatTaxRate'
      cast( 0 as wertv12)                                            as AmountGC,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_StatTaxRate'
      cast( 0 as wertv12)                                            as StatutoryTaxGC,

      //Built-in function FLTP_TO_DEC allows to convert an argument of type FLTP to DEC, CURR, QUAN with given length or decimals.
      fltp_to_dec( 0.01 as abap.dec(2,2) )                           as MultiFactor,

      CurrencyType,

      $parameters.p_toperiod                                         as Period,
      $parameters.p_taxintention                                    as SPeriod,
      $parameters.p_intention                                        as Intention,
      
      LocalCurrency as TierAmountCurrency
}

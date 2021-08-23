@AbapCatalog.sqlViewName: '/EY1/ICTETOTAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View to fetch sum value of CTE Tax'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_CTE_Total
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention,
    p_currtype      : /ey1/sav_currency_type,
    p_intention     : /ey1/sav_intent

  as select from /EY1/SAV_I_PR_CTE_Details ( p_cntry:$parameters.p_cntry,
                                             p_ryear:$parameters.p_ryear,
                                             p_toperiod:$parameters.p_toperiod,
                                             p_taxintention:$parameters.p_taxintention,
                                             p_currtype:$parameters.p_currtype,
                                             p_intention:$parameters.p_intention)
{ ///EY1/SAV_I_TIERS
  key CountryKey,
  key FiscalYear,
  key Intention,
  key Sequence,

      TierAmountLC,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as TierAmountGC,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as Amount,

      TaxRate,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as Tax,

      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as SumTax,
      
      cast( 0 as wertv12)         as OtherTaxCredit,                                //PlaceHolder
      
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as TotalCurrentCorpIncTaxExp,
      
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as CorpIncTaxReceivable,
      
      cast( 0 as wertv12)         as WitholdingTaxCredit,                           //PlaceHolder
      cast( 0 as wertv12)         as CorpIncTaxPayCY,                               //PlaceHolder
      cast( 0 as wertv12)         as TransferInOut,                                 //PlaceHolder
      
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as SubTotal,                                      
      
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'
      cast( 0 as wertv12)         as CTA,   
      
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: '/EY1/SAV_CL_PR_CTE_SUM'  
      cast( 0 as wertv12)         as CorpIncReceivable,                                        
      
      $parameters.p_toperiod      as Period,
      $parameters.p_taxintention  as SPeriod,
      $parameters.p_currtype      as CurrencyType,

      LocalCurrency
}
//where
//      CountryKey = $parameters.p_cntry
//  and FiscalYear = $parameters.p_ryear

@AbapCatalog.sqlViewName: '/EY1/ITAXINCLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I view Union -  Tax inc. Loss'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_TILBCL_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_PR_OTA_TILBCL_LC
                 ( p_toperiod:$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention:$parameters.p_taxintention) as TaxIncLC
{ //TaxIncLC
  key ConsolidationUnit,
  key FiscalYear,
  
      ConsolidationDimension,
      @Semantics.currencyCode: true
      LocalCurrency                   as MainCurrency,
      Country,
      TaxableIncLossBCL,

      cast( 'Local' as abap.char(5) ) as CurrencyType

}
union all select from /EY1/SAV_I_PR_OTA_TILBCL_GC
                      ( p_toperiod:$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention:$parameters.p_taxintention) as TaxIncGC
{ //TaxIncGC
  key ConsolidationUnit,
  key FiscalYear,
      
      ConsolidationDimension,
      @Semantics.currencyCode: true
      GroupCurrency                   as MainCurrency,
      Country,
      TaxableIncLossBCL,

      cast( 'Group' as abap.char(5) ) as CurrencyType
}

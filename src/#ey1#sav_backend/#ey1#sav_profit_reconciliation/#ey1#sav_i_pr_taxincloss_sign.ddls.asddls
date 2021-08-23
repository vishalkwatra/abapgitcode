@AbapCatalog.sqlViewName: '/EY1/ITILSIGN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I view to fetch positive Values for Tax inc. Loss value'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_TaxIncLoss_Sign
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_PR_OTA_TILBCL_LCGC
                 ( p_toperiod:$parameters.p_toperiod,
                   p_ryear:$parameters.p_ryear,
                   p_taxintention:$parameters.p_taxintention) as TaxIncLC
{ //TaxIncLC
  key ConsolidationUnit,
  key FiscalYear,

      Country,
      ConsolidationDimension,

      TaxableIncLossBCL,

      @Semantics.currencyCode: true
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast( case when TaxableIncLossBCL < 0
                 then TaxableIncLossBCL * ( -1 )
      else  cast(0 as abap.curr(23,2) ) end  as abap.curr(23,2) ) as TempTaxValue,

      CurrencyType
}

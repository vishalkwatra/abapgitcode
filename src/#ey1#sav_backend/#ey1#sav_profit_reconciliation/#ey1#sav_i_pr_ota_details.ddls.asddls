@AbapCatalog.sqlViewName: '/EY1/PROTADETAIL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA - Details'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_Details
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_OTA_Detail_LCGC
                 ( p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxableIncLoss,

      CurrencyType
}

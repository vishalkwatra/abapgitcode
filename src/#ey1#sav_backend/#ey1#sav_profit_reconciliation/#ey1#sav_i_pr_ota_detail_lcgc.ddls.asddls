@AbapCatalog.sqlViewName: '/EY1/PROTADLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA - Details LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_Detail_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  //  -------------------- Total Row LC   ---------------------
  as select from /EY1/SAV_I_PR_OTA_Total_LC
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Local' as abap.char(5)) as CurrencyType
}

//  -------------------- Total Row GC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_Total_GC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Group' as abap.char(5)) as CurrencyType
}

//  -------------------- Taxable Income Loss Before Compensation of Losses -  Row LC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TILBCL_LC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Local' as abap.char(5)) as CurrencyType
}

//  -------------------- Taxable Income Loss Before Compensation of Losses -  Row GC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TILBCL_GC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Group' as abap.char(5)) as CurrencyType
}
//  -------------------- Transfer In/Out -  Row LC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TIO_LU
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TransferInOutLC               as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Local' as abap.char(5)) as CurrencyType
}
//  -------------------- Transfer In/Out -  Row GC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TIO_LU
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TransferInOutGC               as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Group' as abap.char(5)) as CurrencyType
}
//  -------------------- Losses utilized -  Row LC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TIO_LU
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      LossesUtilizedLC              as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Local' as abap.char(5)) as CurrencyType
}
//  -------------------- Losses utilized -  Row GC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TIO_LU
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      LossesUtilizedGC              as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLoss,

      cast('Group' as abap.char(5)) as CurrencyType
}
//  -------------------- Taxable Income Loss -  Row LC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TaxableIL_LC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxableIncLoss,

      cast('Local' as abap.char(5)) as CurrencyType
}
//  -------------------- Taxable Income Loss -  Row GC   ---------------------
union all select from /EY1/SAV_I_PR_OTA_TaxableIL_GC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalOTA,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TaxableIncLossBCL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TransferInOut,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as LossesUtilized,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxableIncLoss,

      cast('Group' as abap.char(5)) as CurrencyType
}

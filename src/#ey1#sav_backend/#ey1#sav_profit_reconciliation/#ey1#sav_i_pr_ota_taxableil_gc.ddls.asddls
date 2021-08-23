@AbapCatalog.sqlViewName: '/EY1/PROTATILGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA Taxable Inc/Loss GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_TaxableIL_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_OTA_TILBCL_GC
                 ( p_toperiod:$parameters.p_toperiod,
                       p_ryear:$parameters.p_ryear,
                       p_taxintention:$parameters.p_taxintention) as TaxableIncLossBCLOTA
    left outer join /EY1/SAV_I_PR_OTA_TIO_LU
                    ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                       p_taxintention:$parameters.p_taxintention) as TransferInOutAndLossUtilized on  TaxableIncLossBCLOTA.ChartOfAccounts              = TransferInOutAndLossUtilized.ChartOfAccounts
                                                                                                    and TaxableIncLossBCLOTA.ConsolidationChartofAccounts = TransferInOutAndLossUtilized.ConsolidationChartofAccounts
                                                                                                    and TaxableIncLossBCLOTA.ConsolidationUnit            = TransferInOutAndLossUtilized.ConsolidationUnit
                                                                                                    and TaxableIncLossBCLOTA.FiscalYear                   = TransferInOutAndLossUtilized.FiscalYear

{
  key TaxableIncLossBCLOTA.ChartOfAccounts,
  key TaxableIncLossBCLOTA.ConsolidationUnit,
  key TaxableIncLossBCLOTA.ConsolidationChartofAccounts,
  key TaxableIncLossBCLOTA.FiscalYear,
      TaxableIncLossBCLOTA.ConsolidationDimension,
      @Semantics.currencyCode: true
      TaxableIncLossBCLOTA.GroupCurrency,

      TaxableIncLossBCL,
      TransferInOutGC,
      LossesUtilizedGC,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast (case when TaxableIncLossBCL is null then cast( case
                                                     when TransferInOutGC is null then LossesUtilizedGC
                                                     when LossesUtilizedGC is null then TransferInOutGC
                                                     else LossesUtilizedGC + TransferInOutGC end as abap.curr(23,2))
           when TransferInOutGC is null then cast(case
                                                       when TaxableIncLossBCL is null then LossesUtilizedGC
                                                       when LossesUtilizedGC is null then TaxableIncLossBCL
                                                       else LossesUtilizedGC + TaxableIncLossBCL end as abap.curr(23,2))
           when LossesUtilizedGC is null then cast(case
                                              when TaxableIncLossBCL is null then TransferInOutGC
                                              when TransferInOutGC is null then TaxableIncLossBCL
                                              else TransferInOutGC + TaxableIncLossBCL end as abap.curr(23,2))
           else TaxableIncLossBCL + TransferInOutGC + LossesUtilizedGC end as abap.curr( 23, 2 )) as TaxableIncLoss
}

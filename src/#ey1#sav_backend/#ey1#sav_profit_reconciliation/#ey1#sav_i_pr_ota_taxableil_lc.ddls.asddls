@AbapCatalog.sqlViewName: '/EY1/PROTATILLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA Taxable Inc/Loss LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_TaxableIL_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_OTA_TILBCL_LC
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
      TaxableIncLossBCLOTA.LocalCurrency,

      TaxableIncLossBCL,
      TransferInOutLC,
      LossesUtilizedLC,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when TaxableIncLossBCL is null then cast( case
                                                     when TransferInOutLC is null then LossesUtilizedLC
                                                     when LossesUtilizedLC is null then TransferInOutLC
                                                     else LossesUtilizedLC + TransferInOutLC end as abap.curr(23,2))
           when TransferInOutLC is null then cast(case
                                                       when TaxableIncLossBCL is null then LossesUtilizedLC
                                                       when LossesUtilizedLC is null then TaxableIncLossBCL
                                                       else LossesUtilizedLC + TaxableIncLossBCL end as abap.curr(23,2))
           when LossesUtilizedLC is null then cast(case
                                              when TaxableIncLossBCL is null then TransferInOutLC
                                              when TransferInOutLC is null then TaxableIncLossBCL
                                              else TransferInOutLC + TaxableIncLossBCL end as abap.curr(23,2))
           else TaxableIncLossBCL + TransferInOutLC + LossesUtilizedLC end as abap.curr( 23, 2 )) as TaxableIncLoss
}

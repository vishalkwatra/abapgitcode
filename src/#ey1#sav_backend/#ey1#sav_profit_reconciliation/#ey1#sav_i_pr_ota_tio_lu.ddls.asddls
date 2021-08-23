@AbapCatalog.sqlViewName: '/EY1/PROTATRANS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA Transfer In/Out & Losses Utilized'
@VDM.viewType: #BASIC
// --------------------------------------   Dummy view for Placeholder values
define view /EY1/SAV_I_PR_OTA_TIO_LU
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select distinct from /EY1/SAV_I_PR_OTA_YB_LC
                          ( p_toperiod:$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention:$parameters.p_taxintention) as OTALC
    left outer join       /EY1/SAV_I_PR_OTA_YB_GC
                    ( p_toperiod:$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention:$parameters.p_taxintention) as OTAGC on  OTALC.ChartOfAccounts              = OTAGC.ChartOfAccounts
                                                                                and OTALC.ConsolidationUnit            = OTAGC.ConsolidationUnit
                                                                                and OTALC.ConsolidationChartofAccounts = OTAGC.ConsolidationChartofAccounts
                                                                                and OTALC.FiscalYear                   = OTAGC.FiscalYear
                                                                                and OTALC.ConsolidationDimension       = OTAGC.ConsolidationDimension
{
  key OTALC.ChartOfAccounts,
  key OTALC.ConsolidationUnit,
  key OTALC.ConsolidationChartofAccounts,
  key OTALC.FiscalYear,
      OTALC.ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency,

      @Semantics.currencyCode: true
      GroupCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast(0 as abap.curr(23,2)) as TransferInOutLC,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast(0 as abap.curr(23,2)) as LossesUtilizedLC,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast(0 as abap.curr(23,2)) as TransferInOutGC,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast(0 as abap.curr(23,2)) as LossesUtilizedGC
}

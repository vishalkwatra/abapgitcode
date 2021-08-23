@AbapCatalog.sqlViewName: '/EY1/PROTATBCLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-PR-OTA Taxable Inc/Loss Before Compensation Losses'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_TILBCL_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_S2T_FPLBT_LC
                 ( p_toperiod:$parameters.p_toperiod,
                       p_ryear:$parameters.p_ryear,
                       p_taxintention:$parameters.p_taxintention)      as TaxableProfitLossBeforeTaxS2T

    left outer join /EY1/SAV_I_PR_PTA_Total_LC
                    ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention)     as TotalPTA on  TaxableProfitLossBeforeTaxS2T.ChartOfAccounts              = TotalPTA.ChartOfAccounts
                                                                                     and TaxableProfitLossBeforeTaxS2T.ConsolidationChartofAccounts = TotalPTA.ConsolidationChartofAccounts
                                                                                     and TaxableProfitLossBeforeTaxS2T.ConsolidationUnit            = TotalPTA.ConsolidationUnit
                                                                                     and TaxableProfitLossBeforeTaxS2T.FiscalYear                   = TotalPTA.FiscalYear
    left outer join /EY1/SAV_I_PR_OTA_Total_LC
                    ( p_toperiod:$parameters.p_toperiod,
                            p_ryear:$parameters.p_ryear,
                            p_taxintention:$parameters.p_taxintention) as TotalOTA on  TaxableProfitLossBeforeTaxS2T.ChartOfAccounts              = TotalOTA.ChartOfAccounts
                                                                                     and TaxableProfitLossBeforeTaxS2T.ConsolidationChartofAccounts = TotalOTA.ConsolidationChartofAccounts
                                                                                     and TaxableProfitLossBeforeTaxS2T.ConsolidationUnit            = TotalOTA.ConsolidationUnit
                                                                                     and TaxableProfitLossBeforeTaxS2T.FiscalYear                   = TotalOTA.FiscalYear

  association [0..1] to /EY1/SAV_C_CurrLocalGroupVH as _Cntry on  TaxableProfitLossBeforeTaxS2T.ConsolidationUnit = _Cntry.ConsolidationUnit
                                                              and TaxableProfitLossBeforeTaxS2T.LocalCurrency     = _Cntry.Currency
{
  key TotalPTA.ChartOfAccounts,
  key TotalPTA.ConsolidationUnit,
  key TotalPTA.ConsolidationChartofAccounts,
  key TotalPTA.FiscalYear,
      TotalPTA.ConsolidationDimension,

      @Semantics.currencyCode: true
      TotalPTA.LocalCurrency,

      _Cntry.Country,

      FiscalIncomeLossBT,

      TotalPTA,
      TotalOTA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when FiscalIncomeLossBT is null then cast( case when TotalPTA is null then TotalOTA
                                                                 when TotalOTA is null then TotalPTA
                                                                 else TotalPTA + TotalOTA end as abap.curr(23,2))
           when TotalPTA is null then cast(case when FiscalIncomeLossBT is null then TotalOTA
                                                when TotalOTA is null then FiscalIncomeLossBT
                                                else TotalOTA + FiscalIncomeLossBT end as abap.curr(23,2))
           when TotalOTA is null then cast(case when FiscalIncomeLossBT is null then TotalPTA
                                                when TotalPTA is null then FiscalIncomeLossBT
                                                else FiscalIncomeLossBT + TotalPTA end as abap.curr(23,2))
           else FiscalIncomeLossBT + TotalPTA + TotalOTA end as abap.curr( 23, 2 )) as TaxableIncLossBCL

}

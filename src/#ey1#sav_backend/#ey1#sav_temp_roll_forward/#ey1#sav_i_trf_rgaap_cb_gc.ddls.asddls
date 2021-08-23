@AbapCatalog.sqlViewName: '/EY1/IRGCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd RGAAP CB- GC'

@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_CB_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                    ( p_ryear:$parameters.p_ryear )                as GLAccnt

    left outer join /EY1/SAV_I_TRF_RGAAP_CB_PL_GC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )   as RGaapCBPlGC   on  RGaapCBPlGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCBPlGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCBPlGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CB_PMT_GC
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as RGaapCBPmntGC on  RGaapCBPmntGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCBPmntGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCBPmntGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CB_EQ_GC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )   as RGaapCBEqGC   on  RGaapCBEqGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCBEqGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCBEqGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,
      //key AccountClassCode,
      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: 'true'
      GLAccnt.GroupCurrency,

      //RGaapCBPlGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlClosingBalance,

      //RGaapCBPmntGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmntClosingBalance,

      //RGaapCBEqGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqClosingBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqClosingBalance + PlClosingBalance + PmntClosingBalance as ClosingBalance

}

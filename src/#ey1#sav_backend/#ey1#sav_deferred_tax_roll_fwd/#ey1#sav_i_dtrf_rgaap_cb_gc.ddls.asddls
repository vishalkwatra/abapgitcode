@AbapCatalog.sqlViewName: '/EY1/DTRFRCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward Closing Balance - GC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_RGAAP_CB_GC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                          ( p_ryear:$parameters.p_ryear )          as GLAccnt

    left outer join /EY1/SAV_I_DTRF_RGAAP_CB_PL_GC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapCBPlGC on  RGaapCBPlGC.GLAccount         = GLAccnt.GLAccount
                                                                                  and RGaapCBPlGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and RGaapCBPlGC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_RGAAP_CB_EQ_GC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapCBEqGC on  RGaapCBEqGC.GLAccount         = GLAccnt.GLAccount
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

      //RGaapCBEqGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      EqClosingBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlClosingBalance + EqClosingBalance as ClosingBalanceDTADTL
}

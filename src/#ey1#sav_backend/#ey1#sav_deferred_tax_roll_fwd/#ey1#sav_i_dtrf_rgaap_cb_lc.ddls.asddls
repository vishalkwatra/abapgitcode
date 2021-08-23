@AbapCatalog.sqlViewName: '/EY1/DTRFRCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward Closing Balance - LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_RGAAP_CB_LC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                   as GLAccnt

    left outer join /EY1/SAV_I_DTRF_RGAAP_CB_PL_LC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapCBPlLC on  RGaapCBPlLC.GLAccount         = GLAccnt.GLAccount
                                                                                  and RGaapCBPlLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and RGaapCBPlLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_DTRF_RGAAP_CB_EQ_LC
                    ( p_rbunit :$parameters.p_rbunit,
                    p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention ) as RGaapCBEqLC on  RGaapCBEqLC.GLAccount         = GLAccnt.GLAccount
                                                                                  and RGaapCBEqLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and RGaapCBEqLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
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

      //@Semantics.currencyCode: 'true'
      GLAccnt.LocalCurrency,

      //RGaapCBPlLC
      //@Semantics.amount.currencyCode: 'LocalCurrency'
      PlClosingBalance,

      //RGaapCBEqLC
      //@Semantics.amount.currencyCode: 'LocalCurrency'
      EqClosingBalance,

      //@Semantics.amount.currencyCode: 'LocalCurrency'
      PlClosingBalance + EqClosingBalance as ClosingBalanceDTADTL

}

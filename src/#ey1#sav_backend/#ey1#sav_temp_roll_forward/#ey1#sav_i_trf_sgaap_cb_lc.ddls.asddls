@AbapCatalog.sqlViewName: '/EY1/ISGCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP CB - LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_CB_LC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention  //  as select distinct from /EY1/SAV_I_GlAcc_TRF_MD
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )               as GLAccnt

    left outer join /EY1/SAV_I_TRF_SGAAP_CB_PL_LC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention  )   as SGaapCBPlLC   on  SGaapCBPlLC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapCBPlLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapCBPlLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_CB_PMT_LC
                    ( p_toperiod :$parameters.p_toperiod,
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapCBPmntLC on  SGaapCBPmntLC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapCBPmntLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapCBPmntLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_TRF_SGAAP_CB_EQ_LC
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention :$parameters.p_taxintention )   as SGaapCBEqLC   on  SGaapCBEqLC.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapCBEqLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                and SGaapCBEqLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,

      @Semantics.currencyCode: 'true'
      GLAccnt.LocalCurrency,

      //RGaapCBPlLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlClosingBalance,

      //RGaapCBPmntLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmntClosingBalance,

      //RGaapCBEqLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqClosingBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqClosingBalance + PlClosingBalance + PmntClosingBalance as ClosingBalance
      //      cast (case when EqClosingBalance is null then cast( case when PlClosingBalance is null then PmntClosingBalance
      //                                                                       when PmntClosingBalance is null then PlClosingBalance
      //                                                                       else PlClosingBalance + PmntClosingBalance end as abap.curr(23,2))
      //
      //                       when PlClosingBalance is null then cast( case when PmntClosingBalance is null then EqClosingBalance
      //                                                                    when EqClosingBalance is null then PmntClosingBalance
      //                                                                    else PmntClosingBalance + EqClosingBalance  end as abap.curr(23,2))
      //
      //                       when PmntClosingBalance is null then cast(case when EqClosingBalance is null then PlClosingBalance
      //                                                                    when PlClosingBalance is null then EqClosingBalance
      //                                                                    else EqClosingBalance + PlClosingBalance  end as abap.curr(23,2))
      //
      //                       else EqClosingBalance + PlClosingBalance + PmntClosingBalance  end as abap.curr( 23, 2 )) as ClosingBalance
}

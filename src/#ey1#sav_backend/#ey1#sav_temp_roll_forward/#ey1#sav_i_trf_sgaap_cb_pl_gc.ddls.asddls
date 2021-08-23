@AbapCatalog.sqlViewName: '/EY1/ISGCBPLGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP Closing Balance for P&L - GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_CB_PL_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                         as GLAccnt

    left outer join /EY1/SAV_I_TRF_SGAAP_OB_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as SGaapOBGC on  SGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_YB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as SGaapYBGC on  SGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and SGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_PYA
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear )                  as SGaapPYA  on  SGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and SGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                        as SGaapCTA  on  SGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                      and SGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                      and SGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,
      //  key AccountClassCode,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: 'true'
      GLAccnt.GroupCurrency,

      //RGaapOBGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlOpeningBalance,

      //RGaapYBGC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OPlYearBalance,

      //RGaapPYA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAPl,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOpl,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      CTAPl,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      PlYearBalance + PlOpeningBalance + OPlYearBalance + PYAPl + PYAOpl + CTAPl as PlClosingBalance

      //      cast (case when PlYearBalance is null then cast( case when PlOpeningBalance is null then OPlYearBalance + PYAPl + PYAOpl + CTAPl
      //                                                            when OPlYearBalance is null then PlOpeningBalance + PYAPl + PYAOpl + CTAPl
      //                                                            else PlOpeningBalance + OPlYearBalance + PYAPl + PYAOpl + CTAPl end as abap.curr(23,2))
      //
      //                 when PlOpeningBalance is null then cast( case when OPlYearBalance is null then PlYearBalance + PYAPl + PYAOpl + CTAPl
      //                                                               when PlYearBalance is null then OPlYearBalance + PYAPl + PYAOpl + CTAPl
      //                                                               else OPlYearBalance + PlYearBalance + PYAPl + PYAOpl + CTAPl end as abap.curr(23,2))
      //
      //                 when OPlYearBalance is null then cast(case when PlYearBalance is null then PlOpeningBalance + PYAPl + PYAOpl + CTAPl
      //                                                            when PlOpeningBalance is null then PlYearBalance + PYAPl + PYAOpl + CTAPl
      //                                                            else PlYearBalance + PlOpeningBalance + PYAPl + PYAOpl + CTAPl end as abap.curr(23,2))
      //
      //                 else PlYearBalance + PlOpeningBalance + OPlYearBalance + PYAPl + PYAOpl + CTAPl end as abap.curr( 23, 2 )) as PlClosingBalance
}

@AbapCatalog.sqlViewName: '/EY1/ISGCBPMTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd SGAAP CB for PMNT-LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_CB_PMT_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                         as GLAccnt

    left outer join /EY1/SAV_I_TRF_SGAAP_OB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as SGaapOBLC on SGaapOBLC.GLAccount = GLAccnt.GLAccount
                                                                                      and SGaapOBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_YB_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as SGaapYBLC on  SGaapYBLC.GLAccount  = GLAccnt.GLAccount
                                                                                      and SGaapYBLC.FiscalYear = GLAccnt.FiscalYear
                                                                                      and SGaapYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_PYA
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear )                  as SGaapPYA  on  SGaapPYA.GLAccount  = GLAccnt.GLAccount
                                                                                      and SGaapPYA.FiscalYear = GLAccnt.FiscalYear
                                                                                      and SGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_SGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                        as SGaapCTA  on  SGaapCTA.GLAccount  = GLAccnt.GLAccount
                                                                                      and SGaapCTA.FiscalYear = GLAccnt.FiscalYear
                                                                                      and SGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit

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

      //RGaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmntOpeningBalance,

      //RGaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmntYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPmntYearBalance,

      //RGaapPYA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPmnt,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpmnt,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      CTAPmnt,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmntOpeningBalance + PmntYearBalance + OPmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt as PmntClosingBalance
//      cast (case when PmntOpeningBalance is null then cast( case when PmntYearBalance is null then OPmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt
//                                                                 when OPmntYearBalance is null then PmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt
//                                                                 else PmntYearBalance + OPmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt end as abap.curr(23,2))
//
//                 when PmntYearBalance is null then cast( case when OPmntYearBalance is null then PmntOpeningBalance + PYAPmnt + PYAOpmnt + CTAPmnt
//                                                              when PmntOpeningBalance is null then OPmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt
//                                                              else OPmntYearBalance + PmntOpeningBalance + PYAPmnt + PYAOpmnt + CTAPmnt end as abap.curr(23,2))
//
//                 when OPmntYearBalance is null then cast(case when PmntOpeningBalance is null then PmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt
//                                                              when PmntYearBalance is null then PmntOpeningBalance + PYAPmnt + PYAOpmnt + CTAPmnt
//                                                              else PmntOpeningBalance + PmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt end as abap.curr(23,2))
//
//                 else PmntOpeningBalance + PmntYearBalance + OPmntYearBalance + PYAPmnt + PYAOpmnt + CTAPmnt end as abap.curr( 23, 2 )) as PmntClosingBalance
}

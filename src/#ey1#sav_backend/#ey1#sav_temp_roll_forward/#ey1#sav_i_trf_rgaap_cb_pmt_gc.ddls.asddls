@AbapCatalog.sqlViewName: '/EY1/IRGPMNTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd RGAAP CB PMNT-GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_CB_PMT_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_TRF_MD
                 ( p_ryear:$parameters.p_ryear )                       as GLAccnt

    left outer join /EY1/SAV_I_TRF_RGAAP_OB_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                           p_toperiod :$parameters.p_toperiod )        as RGaapOBGC on  RGaapOBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapOBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_YB_GC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention ) as RGaapYBGC on  RGaapYBGC.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapYBGC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapYBGC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_PYA_GC
                    (  p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )         as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                      as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                    and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit

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

      //RGaapOBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmntOpeningBalance,

      //RGaapYBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PmntYearBalance,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      OPmntYearBalance,

      //RGaapPYA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAPmnt,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      PYAOpmnt,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      CTAPmnt,

      @Semantics.amount.currencyCode: 'GroupCurrency'
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

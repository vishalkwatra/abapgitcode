@AbapCatalog.sqlViewName: '/EY1/IRECONGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I- View Reconciliation GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention

  as select distinct from /EY1/SAV_I_GlAcc_MD
                          ( p_ryear:$parameters.p_ryear ) as GlAccnt

    left outer join       /EY1/SAV_I_Rec_GAAP_OB_YB_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_fromyb: $parameters.p_fromyb, p_toyb: $parameters.p_toyb,
                          p_switch: $parameters.p_switch,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as GaapOBGC             on  GaapOBGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and GaapOBGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and GaapOBGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_STAT_OB_YB_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_fromyb:$parameters.p_fromyb, p_toyb:$parameters.p_toyb ,
                          p_switch: $parameters.p_switch,
                          p_taxintention: $parameters.p_taxintention,
                          p_intention: $parameters.p_intention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           )                              as StatOBGC             on  StatOBGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and StatOBGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and StatOBGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_TAX_OB_YB_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_fromyb:$parameters.p_fromyb , p_toyb:$parameters.p_toyb,
                          p_switch: $parameters.p_switch,
                          p_taxintention: $parameters.p_taxintention,
                          p_intention: $parameters.p_intention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           )                              as TaxOBGC              on  TaxOBGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and TaxOBGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and TaxOBGC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_PL_GC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           )                              as Gaap2StatPLGC        on  Gaap2StatPLGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Gaap2StatPLGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Gaap2StatPLGC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_Pmnt_GC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                            )                             as Gaap2StatPmntGC      on  Gaap2StatPmntGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Gaap2StatPmntGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Gaap2StatPmntGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_G2S_Equity_GC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Gaap2StatEQGC        on  Gaap2StatEQGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Gaap2StatEQGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Gaap2StatEQGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_G2S_OthrPL_GC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           )                              as Gaap2StatOtherPLGC   on  Gaap2StatOtherPLGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Gaap2StatOtherPLGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Gaap2StatOtherPLGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_G2S_OthrPmt_GC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Gaap2StatOtherPmntGC on  Gaap2StatOtherPmntGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Gaap2StatOtherPmntGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Gaap2StatOtherPmntGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_G2S_OthrEq_GC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Gaap2StatOtherEQGC   on  Gaap2StatOtherEQGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Gaap2StatOtherEQGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Gaap2StatOtherEQGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_S2T_PL_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Stat2TaxPLGC         on  Stat2TaxPLGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Stat2TaxPLGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Stat2TaxPLGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_S2T_Pmnt_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Stat2TaxPmntGC       on  Stat2TaxPmntGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Stat2TaxPmntGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Stat2TaxPmntGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_S2T_Equity_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           )                              as Stat2TaxEQGC         on  Stat2TaxEQGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Stat2TaxEQGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Stat2TaxEQGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_S2T_OthrPL_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Stat2TaxOtherPLGC    on  Stat2TaxOtherPLGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Stat2TaxOtherPLGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Stat2TaxOtherPLGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_S2T_OthrPmnt_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Stat2TaxOtherPmntGC  on  Stat2TaxOtherPmntGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Stat2TaxOtherPmntGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Stat2TaxOtherPmntGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_S2T_OthrEq_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                               as Stat2TaxOtherEQGC    on  Stat2TaxOtherEQGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and Stat2TaxOtherEQGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and Stat2TaxOtherEQGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_TAX_PTA_GC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                            )                             as TaxPTAGC             on  TaxPTAGC.GLAccount         = GlAccnt.GLAccount
                                                                                  and TaxPTAGC.FiscalYear        = GlAccnt.FiscalYear
                                                                                  and TaxPTAGC.ConsolidationUnit = GlAccnt.ConsolidationUnit

{
  key GlAccnt.GLAccount,
  key GlAccnt.FinancialStatementItem,
  key GlAccnt.AccountClassCode,
  key GlAccnt.FiscalYear,
  key GlAccnt.ConsolidationChartofAccounts,
  key GlAccnt.ChartOfAccounts,
      GlAccnt.ConsolidationUnit,
      GlAccnt.GroupCurrency,

      //GAAP
      GaapOpeningBalance,
      GaapYearBalance,
      GaapOBGC.GaapCTA,

      //Adding GAAP CTA to GAAP Closing Balance here, because switch case was complicated in previous view
      cast (case
        when GaapOBGC.GaapCTA is null then GaapClosingBalance
        when GaapClosingBalance is null then GaapOBGC.GaapCTA
        else GaapClosingBalance + GaapOBGC.GaapCTA end as abap.curr( 23, 2 )) as GaapClosingBalance,

      //GAAP TO STAT
      Gaap2StatPLGC.GaapToStatPL,
      Gaap2StatPmntGC.GaapToStatPmnt,
      Gaap2StatEQGC.GaapToStatEQ,
      Gaap2StatOtherPLGC.GaapToStatOtherPL,
      Gaap2StatOtherPmntGC.GaapToStatOtherPmnt,
      Gaap2StatOtherEQGC.GaapToStatOtherEQ,

      StatOBGC.StatCTA - GaapOBGC.GaapCTA                                     as G2SCTA,

      //STAT
      StatOpeningBalance,
      StatOBGC.StatPYA,
      StatYearBalance,
      StatOBGC.StatCTA,

      //Adding STAT CTA to STAT Closing Balance here, because switch case was complicated in previous view
      cast (case
        when StatOBGC.StatCTA is null then StatClosingBalance
        when StatClosingBalance is null then StatOBGC.StatCTA
        else StatClosingBalance + StatOBGC.StatCTA end as abap.curr( 23, 2 )) as StatClosingBalance,

      //STAT TO TAX
      Stat2TaxPLGC.StatToTaxPL,
      Stat2TaxPmntGC.StatToTaxPmnt,
      Stat2TaxEQGC.StatToTaxEQ,
      Stat2TaxOtherPLGC.StatToTaxOtherPL,
      Stat2TaxOtherPmntGC.StatToTaxOtherPmnt,
      Stat2TaxOtherEQGC.StatToTaxOtherEQ,

      TaxOBGC.TaxCTA - StatOBGC.StatCTA                                       as S2TCTA,

      //TAX
      TaxOpeningBalance,
      TaxOBGC.TaxPYA,
      TaxYearBalance,
      TaxOBGC.TaxCTA,

      //Adding TAX CTA to TAX Closing Balance here, because switch case was complicated in previous view
      cast (case
        when TaxOBGC.TaxCTA is null then TaxClosingBalance
        when TaxClosingBalance is null then TaxOBGC.TaxCTA
        else TaxClosingBalance + TaxOBGC.TaxCTA end as abap.curr( 23, 2 ))    as TaxClosingBalance,

      // PTA
      TaxPTAGC.AmountInGroupCurrency                                          as TaxPTA,

      GlAccnt.BsEqPl,

      // Property for binding smart filter bar
      cast ('Group' as abap.char(5))                                          as CurrType,
      cast (' ' as abap.char(4))                                              as Period
}

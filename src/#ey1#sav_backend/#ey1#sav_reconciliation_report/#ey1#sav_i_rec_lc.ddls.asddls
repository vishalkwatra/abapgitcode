@AbapCatalog.sqlViewName: '/EY1/CRECONILC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I- View Reconciliation LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_LC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select distinct from /EY1/SAV_I_GlAcc_MD( p_ryear:$parameters.p_ryear ) as GlAccnt

    left outer join       /EY1/SAV_I_Rec_GAAP_OB_YB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb: $parameters.p_fromyb,
                          p_toyb: $parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod

                           )                                                 as GaapOBLC             on  GaapOBLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and GaapOBLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and GaapOBLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_STAT_OB_YB_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toyb:$parameters.p_toyb ,
                          p_fromyb:$parameters.p_fromyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                                                  as StatOBLC             on  StatOBLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and StatOBLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and StatOBLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_TAX_OB_YB_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_fromyb:$parameters.p_fromyb ,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod

                          )                                                  as TaxOBLC              on  TaxOBLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and TaxOBLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and TaxOBLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_PL_LC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod

                          )                                                  as Gaap2StatPLLC        on  Gaap2StatPLLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Gaap2StatPLLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Gaap2StatPLLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_Pmnt_LC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           )                                                 as Gaap2StatPmntLC      on  Gaap2StatPmntLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Gaap2StatPmntLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Gaap2StatPmntLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_Equity_LC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod

                           )                                                 as Gaap2StatEQLC        on  Gaap2StatEQLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Gaap2StatEQLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Gaap2StatEQLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_OthrPL_LC
                    ( p_toperiod:$parameters.p_toyb ,
                           p_ryear:$parameters.p_ryear,
                           p_taxintention: $parameters.p_taxintention
                          //                           p_specialperiod: $parameters.p_specialperiod

                            )                                                as Gaap2StatOtherPLLC   on  Gaap2StatOtherPLLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Gaap2StatOtherPLLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Gaap2StatOtherPLLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_OthrPmt_LC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod

                          )                                                  as Gaap2StatOtherPmntLC on  Gaap2StatOtherPmntLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Gaap2StatOtherPmntLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Gaap2StatOtherPmntLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_G2S_OthrEq_LC
                    ( p_toperiod:$parameters.p_toyb ,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           //
                           )                                                 as Gaap2StatOtherEQLC   on  Gaap2StatOtherEQLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Gaap2StatOtherEQLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Gaap2StatOtherEQLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_S2T_PL_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                                                  as Stat2TaxPLLC         on  Stat2TaxPLLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Stat2TaxPLLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Stat2TaxPLLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_S2T_Pmnt_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           //
                           )                                                 as Stat2TaxPmntLC       on  Stat2TaxPmntLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Stat2TaxPmntLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Stat2TaxPmntLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_S2T_Equity_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           //
                            )                                                as Stat2TaxEQLC         on  Stat2TaxEQLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Stat2TaxEQLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Stat2TaxEQLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_S2T_OthrPL_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                                                  as Stat2TaxOtherPLLC    on  Stat2TaxOtherPLLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Stat2TaxOtherPLLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Stat2TaxOtherPLLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_S2T_OthrPmnt_LC
                    ( p_ryear:$parameters.p_ryear ,
                           p_toperiod:$parameters.p_toyb,
                           p_taxintention: $parameters.p_taxintention
                          //                           p_specialperiod: $parameters.p_specialperiod
                            //
                           )                                                 as Stat2TaxOtherPmntLC  on  Stat2TaxOtherPmntLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Stat2TaxOtherPmntLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Stat2TaxOtherPmntLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_S2T_OthrEq_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                           p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           //
                          )                                                  as Stat2TaxOtherEQLC    on  Stat2TaxOtherEQLC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and Stat2TaxOtherEQLC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and Stat2TaxOtherEQLC.ConsolidationUnit = GlAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_TAX_PTA_LC
                    ( p_ryear:$parameters.p_ryear ,
                          p_toperiod:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                           //
                          )                                                  as TaxPTALC             on  TaxPTALC.GLAccount         = GlAccnt.GLAccount
                                                                                                     and TaxPTALC.FiscalYear        = GlAccnt.FiscalYear
                                                                                                     and TaxPTALC.ConsolidationUnit = GlAccnt.ConsolidationUnit
{
  key GlAccnt.GLAccount,
  key GlAccnt.FinancialStatementItem,
  key GlAccnt.AccountClassCode,
  key GlAccnt.FiscalYear,
  key GlAccnt.ConsolidationChartofAccounts,
  key GlAccnt.ChartOfAccounts,
      GlAccnt.ConsolidationUnit,
      GlAccnt.LocalCurrency,

      //Gaap Fields
      GaapOpeningBalance,
      GaapYearBalance,
      GaapOBLC.GaapCTA,
      GaapClosingBalance,

      //G2S Fields
      Gaap2StatPLLC.GaapToStatPL,
      Gaap2StatPmntLC.GaapToStatPmnt,
      Gaap2StatEQLC.GaapToStatEQ,
      Gaap2StatOtherPLLC.GaapToStatOtherPL,
      Gaap2StatOtherPmntLC.GaapToStatOtherPmnt,
      Gaap2StatOtherEQLC.GaapToStatOtherEQ,

      cast (0 as abap.curr( 23, 2))  as G2SCTA,

      //Stat Fields
      StatOpeningBalance,
      StatOBLC.StatPYA,
      StatYearBalance,
      StatOBLC.StatCTA,
      StatClosingBalance,

      //S2T Fields
      Stat2TaxPLLC.StatToTaxPL,
      Stat2TaxPmntLC.StatToTaxPmnt,
      Stat2TaxEQLC.StatToTaxEQ,
      Stat2TaxOtherPLLC.StatToTaxOtherPL,
      Stat2TaxOtherPmntLC.StatToTaxOtherPmnt,
      Stat2TaxOtherEQLC.StatToTaxOtherEQ,

      cast (0 as abap.curr( 23, 2))  as S2TCTA,

      //Tax Fields
      TaxOpeningBalance,
      TaxOBLC.TaxPYA,
      TaxYearBalance,
      TaxOBLC.TaxCTA,
      TaxClosingBalance,
      TaxOBLC.ConsolidationLedger    as TaxLedger,

      // TAX PTA
      TaxPTALC.AmountInLocalCurrency as TaxPTA,

      // Account class code P&L indicator
      GlAccnt.BsEqPl,

      // Fields fro mapping in table smart filters
      cast ('Local' as abap.char(5)) as CurrType,
      cast (' ' as abap.char(4))     as Period
}

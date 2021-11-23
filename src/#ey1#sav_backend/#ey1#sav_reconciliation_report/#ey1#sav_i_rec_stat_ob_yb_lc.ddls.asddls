@AbapCatalog.sqlViewName: '/EY1/STATOBYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Accounts - STAT OB YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_STAT_OB_YB_LC
  with parameters
    p_ryear        : gjahr,
    p_toyb         : poper,
    p_fromyb       : poper,
    p_taxintention : zz1_taxintention,
    p_intention    : /ey1/sav_intent
  //    p_specialperiod : zz1_specialperiod

  as select from    /EY1/SAV_I_Rec_GlAccCUnit_STAT(p_ryear: $parameters.p_ryear)            as GLAccnt

    left outer join /EY1/SAV_I_Rec_STAT_OBNR_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_periodto: $parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention,
                          p_intention: $parameters.p_intention
                    //                    p_specialperiod : $parameters.p_specialperiod

                    )                                         as StatOB  on  StatOB.GLAccount         = GLAccnt.GLAccount
                                                                         and StatOB.FiscalYear        = GLAccnt.FiscalYear
                                                                         and StatOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_Rec_STAT_YB_LC
                    ( p_toyb: $parameters.p_toyb,
                    p_fromyb: $parameters.p_fromyb,
                    p_ryear: $parameters.p_ryear,
                    p_taxintention: $parameters.p_taxintention
                    //                    p_specialperiod: $parameters.p_specialperiod
                    )                                         as StatYB  on  StatYB.GLAccount         = GLAccnt.GLAccount
                                                                         and StatYB.FiscalYear        = GLAccnt.FiscalYear
                                                                         and StatYB.ConsolidationUnit = GLAccnt.ConsolidationUnit

  //    left outer join /EY1/SAV_I_Recon_Adj           as ReconAdj on  ReconAdj.racct = GLAccnt.GLAccount
  //                                                               and ReconAdj.ryear = GLAccnt.FiscalYear

  //
    left outer join /EY1/SAV_I_Rec_STAT_PYA_LC( p_toyb: $parameters.p_toyb,
                    p_fromyb: $parameters.p_fromyb,
                    p_ryear: $parameters.p_ryear,
                    p_taxintention: $parameters.p_intention ) as StatPYA on  StatPYA.GLAccount         = GLAccnt.GLAccount
                                                                         and StatPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                         and StatPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit



{
  key GLAccnt.GLAccount,
  key AccountClassCode,
  key GLAccnt.ConsolidationLedger,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,
      GLAccnt.FinancialStatementItem,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,

      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      StatOpeningBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      StatYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      StatPYALC                                                                                   as StatPYA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when StatYearBalance is null then cast( case when StatPYALC is null then StatOpeningBalance
                                                              when StatOpeningBalance is null then StatPYALC
                                                              else StatOpeningBalance + StatPYALC end as abap.curr(23,2))

                 when StatOpeningBalance is null then cast(case when StatPYALC is null then StatYearBalance
                                                                when StatYearBalance is null then StatPYALC
                                                                else StatYearBalance + StatPYALC end as abap.curr(23,2))

                 when StatPYALC is null then cast(case when StatYearBalance is null then StatOpeningBalance
                                                       when StatOpeningBalance is null then StatYearBalance
                                                       else StatOpeningBalance + StatYearBalance end as abap.curr(23,2))

                 else StatPYALC + StatOpeningBalance + StatYearBalance end as abap.curr( 23, 2 )) as StatClosingBalance,

      cast (0 as abap.curr( 23, 2))                                                               as StatCTA
}

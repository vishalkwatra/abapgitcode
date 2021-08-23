@AbapCatalog.sqlViewName: '/EY1/STATOBYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Accounts - STAT OB YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_STAT_OB_YB_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select distinct from /EY1/SAV_I_Rec_GlAccCUnit_STAT as GLAccnt

    inner join            /EY1/SAV_I_Accounts_Class      as AccountsClass on GLAccnt.AccountClassCode = AccountsClass.acc_class_code

    left outer join       /EY1/SAV_I_Rec_STAT_OB_GC
                    ( p_ryear: $parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod:$parameters.p_specialperiod
                          )                              as StatOB        on  StatOB.GLAccount         = GLAccnt.GLAccount
                                                                          and StatOB.FiscalYear        = GLAccnt.FiscalYear
                                                                          and StatOB.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_STAT_YB_Exc_GC
                    ( p_ryear:$parameters.p_ryear,
                           p_fromyb:$parameters.p_fromyb,
                           p_toyb:$parameters.p_toyb,
                           p_taxintention: $parameters.p_taxintention
                          //                           p_specialperiod: $parameters.p_specialperiod
                            )                            as StatExcCTA    on  StatExcCTA.GLAccount         = GLAccnt.GLAccount
                                                                          and StatExcCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                          and StatExcCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_STAT_YB_Inc_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                              as StatIncCTA    on  StatIncCTA.GLAccount         = GLAccnt.GLAccount
                                                                          and StatIncCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                          and StatIncCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_STAT_CTA_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                              as StatCTA       on  StatCTA.GLAccount         = GLAccnt.GLAccount
                                                                          and StatCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                          and StatCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Recon_Adj           as ReconAdj      on  ReconAdj.racct = GLAccnt.GLAccount
                                                                          and ReconAdj.ryear = GLAccnt.FiscalYear
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
      GLAccnt.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      StatOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      StatPYAGC                              as StatPYA,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case $parameters.p_switch
      when 'X' then StatIncCTA.StatMvmntIncCTA
      else StatExcCTA.StatMvmntExcCTA end    as StatYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case  $parameters.p_switch
      when 'X' then
      cast (case
            when StatIncCTA.StatMvmntIncCTA is null then cast( case when StatPYAGC is null then StatOpeningBalance
                                                                    when StatOpeningBalance is null then StatPYAGC
                                                                    else StatOpeningBalance + StatPYAGC end as abap.curr(23,2))

            when StatOpeningBalance is null then cast(case when StatPYAGC is null then StatIncCTA.StatMvmntIncCTA
                                                           when StatIncCTA.StatMvmntIncCTA is null then StatPYAGC
                                                           else StatIncCTA.StatMvmntIncCTA + StatPYAGC end as abap.curr(23,2))

            when StatPYAGC is null then cast(case when StatIncCTA.StatMvmntIncCTA is null then StatOpeningBalance
                                                  when StatOpeningBalance is null then StatIncCTA.StatMvmntIncCTA
                                                  else StatOpeningBalance + StatIncCTA.StatMvmntIncCTA end as abap.curr(23,2))

            else StatPYAGC + StatOpeningBalance + StatIncCTA.StatMvmntIncCTA end as abap.curr( 23, 2 ))

      else
      cast (case
            when StatExcCTA.StatMvmntExcCTA is null then cast( case when StatPYAGC is null then StatOpeningBalance
                                                                    when StatOpeningBalance is null then StatPYAGC
                                                                    else StatOpeningBalance + StatPYAGC end as abap.curr(23,2))

            when StatOpeningBalance is null then cast(case when StatPYAGC is null then StatExcCTA.StatMvmntExcCTA
                                                           when StatExcCTA.StatMvmntExcCTA is null then StatPYAGC
                                                           else StatExcCTA.StatMvmntExcCTA + StatPYAGC end as abap.curr(23,2))

            when StatPYAGC is null then cast(case when StatExcCTA.StatMvmntExcCTA is null then StatOpeningBalance
                                                  when StatOpeningBalance is null then StatExcCTA.StatMvmntExcCTA
                                                  else StatOpeningBalance + StatExcCTA.StatMvmntExcCTA end as abap.curr(23,2))

            else StatPYAGC + StatOpeningBalance + StatExcCTA.StatMvmntExcCTA end as abap.curr( 23, 2 ))

            end                              as StatClosingBalance,

      AccountsClass.bl_eq_pl                 as BsEqPl,

      case when AccountsClass.bl_eq_pl != 'P&L' then StatCTA.StatCTA
         else cast(0 as abap.curr(23,2)) end as StatCTA
}

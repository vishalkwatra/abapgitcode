@AbapCatalog.sqlViewName: '/EY1/GLOBYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Gaap OB YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_GAAP_OB_YB_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select distinct from /EY1/SAV_I_Rec_GlAcCUnit_GAAP as GLAccnt

    inner join            /EY1/SAV_I_Accounts_Class     as AccountsClass on GLAccnt.AccountClassCode = AccountsClass.acc_class_code

    left outer join       /EY1/SAV_I_Rec_GAAP_OB_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention:$parameters.p_taxintention
                          //                          p_specialperiod:$parameters.p_specialperiod

                          )                             as GaapOB        on  GaapOB.GLAccount         = GLAccnt.GLAccount
                                                                         and GaapOB.FiscalYear        = GLAccnt.FiscalYear
                                                                         and GaapOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_GAAP_YB_EXC_GC
                    ( p_ryear:$parameters.p_ryear,
                           p_fromyb:$parameters.p_fromyb,
                           p_toyb:$parameters.p_toyb,
                           p_taxintention:$parameters.p_taxintention
                          //                           p_specialperiod: $parameters.p_specialperiod
                           )                            as GaapExcCTA    on  GaapExcCTA.GLAccount         = GLAccnt.GLAccount
                                                                         and GaapExcCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                         and GaapExcCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_GAAP_YB_Inc_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention:$parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                             as GaapIncCTA    on  GaapIncCTA.GLAccount         = GLAccnt.GLAccount
                                                                         and GaapIncCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                         and GaapIncCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_GAAP_CTA_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention:$parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                             as GaapCTA       on  GaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                         and GaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                         and GaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
  key GLAccnt.GLAccount,
  key AccountClassCode,
  key GLAccnt.ConsolidationLedger,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,

      ConsolidationChartOfAccounts,
      GLAccnt.FinancialStatementItem,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,

      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case $parameters.p_switch
      when 'X' then GaapIncCTA.GaapMvmntIncCTA
      else GaapExcCTA.GaapMvmntExcCTA end    as GaapYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case  $parameters.p_switch
      when 'X' then  cast (case
            when GaapIncCTA.GaapMvmntIncCTA is null then GaapOpeningBalance
            when GaapOpeningBalance is null then GaapIncCTA.GaapMvmntIncCTA
            else GaapOpeningBalance +  GaapIncCTA.GaapMvmntIncCTA end as abap.curr( 23, 2 ))

      else
       cast (case
            when GaapExcCTA.GaapMvmntExcCTA is null then GaapOpeningBalance
            when GaapOpeningBalance is null then GaapExcCTA.GaapMvmntExcCTA
            else GaapOpeningBalance + GaapExcCTA.GaapMvmntExcCTA end as abap.curr( 23, 2 ))
           end                               as GaapClosingBalance,

      AccountsClass.bl_eq_pl                 as BsEqPl,

      case when AccountsClass.bl_eq_pl != 'P&L' then GaapCTA.GaapCTA
         else cast(0 as abap.curr(23,2)) end as GaapCTA
}

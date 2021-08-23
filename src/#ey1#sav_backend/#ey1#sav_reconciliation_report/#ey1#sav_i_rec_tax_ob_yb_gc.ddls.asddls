@AbapCatalog.sqlViewName: '/EY1/TAXOBYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Tax OB YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_OB_YB_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select distinct from /EY1/SAV_I_RecGlAccCUnit_TAX as GLAccnt

    inner join            /EY1/SAV_I_Accounts_Class    as AccountsClass on GLAccnt.AccountClassCode = AccountsClass.acc_class_code

    left outer join       /EY1/SAV_I_Rec_TAX_OB_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod:$parameters.p_specialperiod
                           )                           as TaxOB         on  TaxOB.GLAccount         = GLAccnt.GLAccount
                                                                        and TaxOB.FiscalYear        = GLAccnt.FiscalYear
                                                                        and TaxOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_TAX_YB_Exc_GC
                    ( p_ryear:$parameters.p_ryear,
                           p_fromyb:$parameters.p_fromyb,
                           p_toyb:$parameters.p_toyb,
                           p_taxintention: $parameters.p_taxintention
                          //                           p_specialperiod: $parameters.p_specialperiod
                            )                          as TaxExcCTA     on  TaxExcCTA.GLAccount         = GLAccnt.GLAccount
                                                                        and TaxExcCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                        and TaxExcCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_TAX_YB_Inc_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                            as TaxIncCTA     on  TaxIncCTA.GLAccount         = GLAccnt.GLAccount
                                                                        and TaxIncCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                        and TaxIncCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_TAX_CTA_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                             )                         as TaxCTA        on  TaxCTA.GLAccount         = GLAccnt.GLAccount
                                                                        and TaxCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                        and TaxCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Recon_Adj         as ReconAdj      on  ReconAdj.racct = GLAccnt.GLAccount
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
      TaxOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      TaxPYAGC                               as TaxPYA,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case $parameters.p_switch
      when 'X' then TaxIncCTA.TaxMvmntIncCTA
      else TaxExcCTA.TaxMvmntExcCTA end      as TaxYearBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case  $parameters.p_switch
      when 'X' then
      cast (case
            when TaxIncCTA.TaxMvmntIncCTA is null then cast( case when TaxPYAGC is null then TaxOpeningBalance
                                                                  when TaxOpeningBalance is null then TaxPYAGC
                                                                  else TaxOpeningBalance + TaxPYAGC end as abap.curr(23,2))

            when TaxOpeningBalance is null then cast(case when TaxPYAGC is null then TaxIncCTA.TaxMvmntIncCTA
                                                          when TaxIncCTA.TaxMvmntIncCTA is null then TaxPYAGC
                                                          else TaxIncCTA.TaxMvmntIncCTA + TaxPYAGC end as abap.curr(23,2))

            when TaxPYAGC is null then cast(case when TaxIncCTA.TaxMvmntIncCTA is null then TaxOpeningBalance
                                                 when TaxOpeningBalance is null then TaxIncCTA.TaxMvmntIncCTA
                                                 else TaxOpeningBalance + TaxIncCTA.TaxMvmntIncCTA end as abap.curr(23,2))

            else TaxPYAGC + TaxOpeningBalance + TaxIncCTA.TaxMvmntIncCTA end as abap.curr( 23, 2 ))

      else
      cast (case
            when TaxExcCTA.TaxMvmntExcCTA is null then cast( case when TaxPYAGC is null then TaxOpeningBalance
                                                                  when TaxOpeningBalance is null then TaxPYAGC
                                                                  else TaxOpeningBalance + TaxPYAGC end as abap.curr(23,2))

            when TaxOpeningBalance is null then cast(case when TaxPYAGC is null then TaxExcCTA.TaxMvmntExcCTA
                                                          when TaxExcCTA.TaxMvmntExcCTA is null then TaxPYAGC
                                                          else TaxExcCTA.TaxMvmntExcCTA + TaxPYAGC end as abap.curr(23,2))

            when TaxPYAGC is null then cast(case when TaxExcCTA.TaxMvmntExcCTA is null then TaxOpeningBalance
                                                 when TaxOpeningBalance is null then TaxExcCTA.TaxMvmntExcCTA
                                                 else TaxOpeningBalance + TaxExcCTA.TaxMvmntExcCTA end as abap.curr(23,2))

            else TaxPYAGC + TaxOpeningBalance + TaxExcCTA.TaxMvmntExcCTA end as abap.curr( 23, 2 ))

            end                              as TaxClosingBalance,

      AccountsClass.bl_eq_pl                 as BsEqPl,

      case when AccountsClass.bl_eq_pl != 'P&L' then TaxCTA.TaxCTA
         else cast(0 as abap.curr(23,2)) end as TaxCTA
}

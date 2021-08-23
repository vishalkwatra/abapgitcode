@AbapCatalog.sqlViewName: '/EY1/ERGEYBPLGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch ER GAAP YB P&L Sum values for GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_YB_PL_GC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_PL_MD( p_ryear: $parameters.p_ryear) as PLMD

    left outer join acdocu                                                              on  acdocu.rbunit = PLMD.ConsolidationUnit
                                                                                        and acdocu.racct  = PLMD.GLAccount
                                                                                        and acdocu.rdimen = PLMD.ConsolidationDimension
                                                                                        and acdocu.ryear  = PLMD.FiscalYear

    inner join      /ey1/reconledger                                                    on  acdocu.rbunit = /ey1/reconledger.bunit
                                                                                        and acdocu.rldnr  = /ey1/reconledger.gaap
    inner join      /EY1/SAV_I_Get_Cnsldtn_Version                        as GetVersion on  GetVersion.ConsolidationLedger = /ey1/reconledger.gaap
                                                                                        and acdocu.rvers                   = GetVersion.ConsolidationVersion

{
  key rldnr    as ConsolidationLedger,
  key ConsolidationDimension,
  key PLMD.FiscalYear,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(ksl) as GaapMvmnt,

      @Semantics.currencyCode: true
      rkcur    as GroupCurrency,

      ChartOfAccounts,
      ConsolidationUnit,
      ConsolidationChartofAccounts,
      BsEqPl,
      rvers    as ConsolidationVersion

}
where
       poper                 >= :p_fromperiod
  and  poper                 <= :p_toperiod
  and  ryear                 =  :p_ryear
  and(
       zz1_taxintention_cje <= :p_taxintention
    or zz1_taxintention_cje =  ''
  )
group by
  rldnr,
  ConsolidationDimension,
  PLMD.FiscalYear,
  rkcur,
  ChartOfAccounts,
  ConsolidationUnit,
  ConsolidationChartofAccounts,
  BsEqPl,
  rvers

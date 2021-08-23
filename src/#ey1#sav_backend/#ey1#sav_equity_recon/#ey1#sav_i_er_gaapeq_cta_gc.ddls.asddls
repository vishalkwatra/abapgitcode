@AbapCatalog.sqlViewName: '/EY1/ERGAAPCTAGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch ER GAAP EQ CTA'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_CTA_GC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD(p_ryear: $parameters.p_ryear) as EQMD

    left outer join acdocu           on  acdocu.rbunit = EQMD.ConsolidationUnit
                                     and acdocu.racct  = EQMD.GLAccount
                                     and acdocu.rdimen = EQMD.ConsolidationDimension
                                     and acdocu.ryear  = EQMD.FiscalYear

    inner join      /ey1/reconledger on  acdocu.rbunit = /ey1/reconledger.bunit
                                     and acdocu.rldnr  = /ey1/reconledger.gaap

{
  key rldnr    as ConsolidationLedger,
  key rdimen   as ConsolidationDimension,
  key ryear    as FiscalYear,
      racct    as GLAccount,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(ksl) as GaapCTA,
      ktopl    as ChartOfAccounts,
      rbunit   as ConsolidationUnit,
      @Semantics.currencyCode: true
      rkcur    as GroupCurrency
}

where
       poper                 >= :p_fromperiod
  and  poper                 <= :p_toperiod
  and  ryear                 =  :p_ryear
  and  subit                 =  '980'
  and(
       zz1_taxintention_cje <= :p_taxintention
    or zz1_taxintention_cje =  ''
  )

group by
  rbunit,
  racct,
  rldnr,
  rdimen,
  ktopl,
  ryear,
  rkcur

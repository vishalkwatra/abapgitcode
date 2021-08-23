@AbapCatalog.sqlViewName: '/EY1/ERGAAPEQLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch ER GAAP EQ for  LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_ER_GAAPEQ_Equity_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_GlAcc_EQ_MD(p_ryear: $parameters.p_ryear) as EQMD

    inner join   acdocu                                                              on  acdocu.rbunit = EQMD.ConsolidationUnit
                                                                                     and acdocu.racct  = EQMD.GLAccount
                                                                                     and acdocu.rdimen = EQMD.ConsolidationDimension
                                                                                     and acdocu.ryear  = EQMD.FiscalYear

    inner join   /ey1/reconledger                                     as ReconLedger on  acdocu.rbunit = ReconLedger.bunit
                                                                                     and acdocu.rldnr  = ReconLedger.gaap
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version                       as GetVersion  on  GetVersion.ConsolidationLedger = ReconLedger.gaap
                                                                                     and acdocu.rvers                   = GetVersion.ConsolidationVersion

{
  key rldnr    as ConsolidationLedger,
  key ryear    as FiscalYear,
      racct    as GLAccount,
      ritclg   as ConsolidationChartOfAccounts,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(hsl) as GaapEQ,
      ktopl    as ChartOfAccounts,
      rbunit   as ConsolidationUnit,
      @Semantics.currencyCode: true
      rhcur    as LocalCurrency,
      rvers    as ConsolidationVersion
}
where
  //  Do not consider Posting Period = 000, as its carry forward balance
       poper != '000'
  and  poper                 <= :p_toperiod
  and  ryear                 =  :p_ryear
  and(
       zz1_taxintention_cje <= :p_taxintention
    or zz1_taxintention_cje =  ''
  )

group by
  rbunit,
  racct,
  rldnr,
  ritclg,
  ktopl,
  ryear,
  rhcur,
  rvers,
  rldnr

@AbapCatalog.sqlViewName: '/EY1/IRGYBPMTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP YB PMNT - GC'

@VDM.viewType: #BASIC

define view /EY1/SAV_I_TRF_RGAAP_YB_PMT_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
//    p_specialperiod : zz1_specialperiod
     p_taxintention  : zz1_taxintention
  as select from acdocu
    inner join   /ey1/reconledger               as ReconLedger on acdocu.rbunit = ReconLedger.bunit
    inner join   /ey1/trans_type                as TransType   on  TransType.rldnrassgnttype = 'PERMANENT'
                                                               and acdocu.rmvct              = TransType.trtyp
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.g2s
         and acdocu.rvers               = GetVersion.ConsolidationVersion
       )
       or(
         GetVersion.ConsolidationLedger = ReconLedger.s2t
         and acdocu.rvers               = GetVersion.ConsolidationVersion
       )
     )
{
  key  ktopl    as ChartOfAccounts,
  key  rbunit   as ConsolidationUnit,
  key  ritclg   as ConsolidationChartOfAccounts,
  key  racct    as GLAccount,
  key  ryear    as FiscalYear,
       @Semantics.amount.currencyCode: 'GroupCurrency'
       sum(ksl) as PmntYearBalance,
       @Semantics.currencyCode: true
       rkcur    as GroupCurrency
       //       rvers    as ConsolidationVersion,
       //       rldnr    as ConsolidationLedger
}
where
  //  Do not consider Posting Period = 000, as its carry forward balance
          poper != '000'
  and     poper                 <= :p_toperiod
  and     ryear                 =  :p_ryear
  and(
          acdocu.rldnr          =  ReconLedger.g2s
    or(
          acdocu.rldnr          =  ReconLedger.s2t
      and zz1_ledgergroup_cje != 'G2S'
    )
  )
//  and(
//          zz1_specialperiod_cje <= :p_specialperiod
//    or    zz1_specialperiod_cje =  ''
//  )
  and(
       zz1_taxintention_cje  <= :p_taxintention
    or zz1_taxintention_cje  =  ''
  )
group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  ryear,
  rkcur
//  rvers,
//  rldnr

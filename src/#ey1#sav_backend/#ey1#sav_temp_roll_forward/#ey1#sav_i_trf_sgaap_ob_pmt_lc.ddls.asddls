@AbapCatalog.sqlViewName: '/EY1/ISGOBPMTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP OB PMNT - LC'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_TRF_SGAAP_OB_PMT_LC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from acdocu
    inner join   /ey1/reconledger               as ReconLedger on acdocu.rbunit = ReconLedger.bunit
    inner join   /EY1/I_TRANS_TYPE              as TransType   on acdocu.rmvct = TransType.trtyp
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on  GetVersion.ConsolidationLedger = ReconLedger.s2t
                                                               and acdocu.rvers                   = GetVersion.ConsolidationVersion

{
  key  ktopl    as ChartOfAccounts,
  key  rbunit   as ConsolidationUnit,
  key  ritclg   as ConsolidationChartOfAccounts,
  key  racct    as GLAccount,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(hsl) as PmntOpeningBalance,
       @Semantics.currencyCode: true
       rhcur    as LocalCurrency,
       rvers    as ConsolidationVersion,
       rldnr    as ConsolidationLedger
}
where
       poper != '000'
  and  poper                     <= '012'
  and  ryear                     <  :p_ryear
  and  acdocu.rldnr              =  ReconLedger.s2t
  and  zz1_ledgergroup_cje != 'G2S'
  and(
       TransType.rldnrassgnttype =  'PERMANENT'
    or TransType.rldnrassgnttype =  'OPERMANENT'
  )
  //  and(
  //       zz1_specialperiod_cje     <= :p_specialperiod
  //    or zz1_specialperiod_cje     =  ''
  //  )
  and(
       zz1_taxintention_cje      <= :p_taxintention
    or zz1_taxintention_cje      =  ''
  )
group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  rhcur,
  rvers,
  rldnr

@AbapCatalog.sqlViewName: '/EY1/ERG2SYBPTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER G2S YB Pmt LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_YB_Pmt_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from acdocu
    inner join   /ey1/reconledger               as ReconLedger on acdocu.rbunit = ReconLedger.bunit
    inner join   /ey1/trans_type                as TransType   on  TransType.rldnrassgnttype = 'PERMANENT'
                                                               and acdocu.rmvct              = TransType.trtyp
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on  GetVersion.ConsolidationLedger = ReconLedger.g2s
                                                               and acdocu.rvers                   = GetVersion.ConsolidationVersion


{
  key  ktopl    as ChartOfAccounts,
  key  rbunit   as ConsolidationUnit,
  key  ritclg   as ConsolidationChartOfAccounts,
  key  racct    as GLAccount,
  key  ryear    as FiscalYear,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(hsl) as PmtYearBalance,
       @Semantics.currencyCode: true
       rhcur    as LocalCurrency,
       rvers    as ConsolidationVersion,
       rldnr    as ConsolidationLedger

}
where
  //  Do not consider Posting Period = 000, as its carry forward balance
       poper != '000'
  and  poper                 <= :p_toperiod
  and  ryear                 =  :p_ryear
  and  acdocu.rldnr          =  ReconLedger.g2s

  and(
       zz1_taxintention_cje <= :p_taxintention
    or zz1_taxintention_cje =  ''
  )

group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  ryear,
  rhcur,
  rvers,
  rldnr

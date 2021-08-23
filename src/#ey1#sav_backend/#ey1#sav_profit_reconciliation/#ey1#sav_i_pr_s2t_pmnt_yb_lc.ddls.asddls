@AbapCatalog.sqlViewName: '/EY1/PRS2TPMYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T Pmnt Mvmnt LC'
@VDM.viewType: #BASIC
define view /EY1/SAV_I_PR_S2T_Pmnt_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from acdocu
    inner join   /ey1/reconledger               as ReconLedger on acdocu.rbunit = ReconLedger.bunit
    inner join   /ey1/trans_type                as TransType   on  TransType.rldnrassgnttype = 'PERMANENT'
                                                               and acdocu.rmvct              = TransType.trtyp
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on  GetVersion.ConsolidationLedger = ReconLedger.s2t
                                                               and acdocu.rvers                   = GetVersion.ConsolidationVersion


{
  key  ktopl    as ChartOfAccounts,
  key  rbunit   as ConsolidationUnit,
  key  ritclg   as ConsolidationChartOfAccounts,
  key  racct    as GLAccount,
  key  ryear    as FiscalYear,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(hsl) as S2TLedgerPmnt,
       @Semantics.currencyCode: true
       rhcur    as LocalCurrency,
       rvers    as ConsolidationVersion
}
where
      poper                 >= '001'
  and poper                 <= :p_toperiod
  and ryear                 =  :p_ryear
  and acdocu.rldnr          =  ReconLedger.s2t
  and zz1_taxintention_cje <= :p_taxintention
  and zz1_ledgergroup_cje != 'G2S'

group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  ryear,
  rhcur,
  rvers

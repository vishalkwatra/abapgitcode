@AbapCatalog.sqlViewName: '/EY1/PRGAAPYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- GAAP Ledger Year Mvmnt LC'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_PR_GAAP_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from acdocu
    inner join   /ey1/reconledger as ReconLedger on acdocu.rbunit = ReconLedger.bunit
     inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on  GetVersion.ConsolidationLedger = ReconLedger.gaap
                                                               and acdocu.rvers                   = GetVersion.ConsolidationVersion
    
{
  key  ktopl    as ChartOfAccounts,
  key  rbunit   as ConsolidationUnit,
  key  ritclg   as ConsolidationChartOfAccounts,
  key  racct    as GLAccount,
  key  ryear    as FiscalYear,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(hsl) as GAAPLedgerTransactions,
       @Semantics.currencyCode: true
       rhcur    as LocalCurrency,
      rvers    as ConsolidationVersion
}
where
      poper                 >= '001'
  and poper                 <= :p_toperiod
  and ryear                 =  :p_ryear
  and acdocu.rldnr          =  ReconLedger.gaap
  and zz1_taxintention_cje <= :p_taxintention

group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  ryear,
  rhcur,
  rvers

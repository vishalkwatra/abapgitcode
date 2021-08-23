@AbapCatalog.sqlViewName: '/EY1/IGTSEQGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - G2S Equity'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_G2S_Equity_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
  //    p_specialperiod : zz1_specialperiod
  as select from acdocu
    inner join   /ey1/reconledger               as ReconLedger on  acdocu.rbunit = ReconLedger.bunit
                                                               and acdocu.rldnr  = ReconLedger.g2s

    inner join   /ey1/trans_type                as TransType   on  TransType.rldnrassgnttype = 'EQ'
                                                               and acdocu.rmvct              = TransType.trtyp

    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on  GetVersion.ConsolidationLedger = ReconLedger.g2s
                                                               and acdocu.rvers                   = GetVersion.ConsolidationVersion
{
  key rldnr    as ConsolidationLedger,
  key ryear    as FiscalYear,
      racct    as GLAccount,
      ritclg   as ConsolidationChartOfAccounts,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      sum(ksl) as GaapToStatEQ,

      ktopl    as ChartOfAccounts,
      rbunit   as ConsolidationUnit,

      @Semantics.currencyCode: true
      rkcur    as GroupCurrency,

      rvers    as ConsolidationVersion
}
where
  //  Do not consider Posting Period = 000, as its carry forward balance
       poper != '000'
  and  poper                <= :p_toperiod
  and  ryear                =  :p_ryear
  and(
       zz1_taxintention_cje <= :p_taxintention
    or zz1_taxintention_cje =  ''
  )
//  and(
//       zz1_specialperiod_cje <= :p_specialperiod
//    or zz1_specialperiod_cje =  ''
//  )
group by
  rbunit,
  racct,
  rldnr,
  ritclg,
  ktopl,
  ryear,
  rkcur,
  rvers

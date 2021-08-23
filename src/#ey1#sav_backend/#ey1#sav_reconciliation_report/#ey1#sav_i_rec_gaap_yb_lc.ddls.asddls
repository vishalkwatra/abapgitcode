@AbapCatalog.sqlViewName: '/EY1/SAVGLYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Gaap YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_GAAP_YB_LC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_taxintention : zz1_taxintention
  //    p_specialperiod : zz1_specialperiod

  as select from acdocu
    inner join   /ey1/reconledger                             on  acdocu.rbunit = /ey1/reconledger.bunit
                                                              and acdocu.rldnr  = /ey1/reconledger.gaap

    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion on  GetVersion.ConsolidationLedger = /ey1/reconledger.gaap
                                                              and acdocu.rvers                   = GetVersion.ConsolidationVersion

{

  key rldnr    as ConsolidationLedger,
  key rdimen   as ConsolidationDimension,
  key ryear    as FiscalYear,
      racct    as GLAccount,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(hsl) as GaapYearBalance,

      ktopl    as ChartOfAccounts,
      rbunit   as ConsolidationUnit,

      @Semantics.currencyCode: true
      rhcur    as LocalCurrency,

      rvers    as ConsolidationVersion
}
where
       poper                >= :p_fromyb
  and  poper                <= :p_toyb
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
  rdimen,
  ktopl,
  ryear,
  rhcur,
  rvers

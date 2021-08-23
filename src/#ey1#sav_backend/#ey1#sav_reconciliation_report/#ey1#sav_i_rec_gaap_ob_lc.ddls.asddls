@AbapCatalog.sqlViewName: '/EY1/GLOBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Gaap OB'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Rec_GAAP_OB_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
  //    p_specialperiod : zz1_specialperiod

  as select from acdocu
    inner join   /ey1/reconledger                             on  acdocu.rbunit = /ey1/reconledger.bunit
                                                              and acdocu.rldnr  = /ey1/reconledger.gaap

    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion on  GetVersion.ConsolidationLedger = /ey1/reconledger.gaap
                                                              and acdocu.rvers                   = GetVersion.ConsolidationVersion

  //    inner join   /EY1/SAV_P_CalculatePriorYear
  //               (p_ryear:$parameters.p_ryear ) as PriorYear on acdocu.ryear = PriorYear.PriorYear
{
  key rldnr    as ConsolidationLedger,
  key rdimen   as ConsolidationDimension,
  key ryear    as FiscalYear,
      racct    as GLAccount,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(hsl) as GaapOpeningBalance,

      ktopl    as ChartOfAccounts,
      rbunit   as ConsolidationUnit,

      @Semantics.currencyCode: true
      rhcur    as LocalCurrency,

      rvers    as ConsolidationVersion
}
where
      poper                =  '000'
  and zz1_taxintention_cje <= :p_taxintention
//  and zz1_specialperiod_cje <= :p_specialperiod

//where
//  (
//        poper                 =  '000'
//    and ryear                 =  PriorYear.PriorYear
//  )
//  or(
//        poper                 >= '001'
//    and poper                 <= '012'
//    and ryear                 =  PriorYear.PriorYear
//    and zz1_specialperiod_cje <= :p_specialperiod
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

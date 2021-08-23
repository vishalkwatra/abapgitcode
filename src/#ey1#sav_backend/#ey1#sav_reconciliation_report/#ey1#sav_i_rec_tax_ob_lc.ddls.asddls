@AbapCatalog.sqlViewName: '/EY1/GLTAXOBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Tax OB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_OB_LC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select from acdocu
    inner join   /ey1/reconledger                             on  acdocu.rbunit = /ey1/reconledger.bunit
                                                              and acdocu.rldnr  = /ey1/reconledger.tax

    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion on  GetVersion.ConsolidationLedger = /ey1/reconledger.tax
                                                              and acdocu.rvers                   = GetVersion.ConsolidationVersion
{
  key rldnr    as ConsolidationLedger,
  key rdimen   as ConsolidationDimension,
  key ryear    as FiscalYear,
      racct    as GLAccount,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(hsl) as TaxOpeningBalance,

      ktopl    as ChartOfAccounts,
      rbunit   as ConsolidationUnit,

      @Semantics.currencyCode: true
      rhcur    as LocalCurrency,

      rvers    as ConsolidationVersion
}
where
      poper                =  '000'
  //  and zz1_specialperiod_cje <= :p_specialperiod
  and zz1_taxintention_cje <= :p_taxintention
group by
  rbunit,
  racct,
  rldnr,
  rdimen,
  ktopl,
  ryear,
  rhcur,
  rvers

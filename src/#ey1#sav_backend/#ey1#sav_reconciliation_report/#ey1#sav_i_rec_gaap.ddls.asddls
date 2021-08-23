@AbapCatalog.sqlViewName: '/EY1/IGAAPGLGAAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Accounts - Gaap'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Rec_GAAP
  as select distinct from acdocu
    right outer join      /ey1/reconledger                             on  /ey1/reconledger.bunit = acdocu.rbunit
                                                                       and acdocu.rldnr           = /ey1/reconledger.gaap

    inner join            /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion on  GetVersion.ConsolidationLedger = /ey1/reconledger.gaap
                                                                       and acdocu.rvers                   = GetVersion.ConsolidationVersion
{
  key rldnr  as ConsolidationLedger,
  key rdimen as ConsolidationDimension,
  key ritclg as ConsolidationChartOfAccounts,
  key ryear  as FiscalYear,
  key racct  as GLAccount,
      ktopl  as ChartOfAccounts,
      rbunit as ConsolidationUnit,
      @Semantics.currencyCode: true
      rhcur  as LocalCurrency,
      @Semantics.currencyCode: true
      rkcur  as GroupCurrency,
      @Semantics.currencyCode: true
      rtcur  as TransactionCurrency,
      rvers  as ConsolidationVersion
}

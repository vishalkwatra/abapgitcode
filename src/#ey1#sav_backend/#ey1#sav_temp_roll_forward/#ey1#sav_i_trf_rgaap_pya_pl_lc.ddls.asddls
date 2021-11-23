@AbapCatalog.sqlViewName: '/EY1/IRGPYAPLLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP PYA PL LC'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_TRF_RGAAP_PYA_PL_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : /ey1/sav_intent,
    p_toperiod     : poper
  as select from /ey1/pya_amount                as PYA
    inner join   /ey1/reconledger               as ReconLedger on PYA.bunit = ReconLedger.bunit
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.g2s
         and PYA.rvers                  = GetVersion.ConsolidationVersion
       )
       or(
         GetVersion.ConsolidationLedger = ReconLedger.s2t
         and PYA.rvers                  = GetVersion.ConsolidationVersion
       )
     )
{
  key  PYA.ktopl            as ChartOfAccounts,
  key  PYA.bunit            as ConsolidationUnit,
  key  PYA.ritclg           as ConsolidationChartOfAccounts,
  key  PYA.glaccount        as GLAccount,
       PYA.pya_year         as FiscalYear,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(PYA.yearbalance) as PYAPLAmount,
       @Semantics.currencyCode: true
       PYA.localcurrency    as LocalCurrency

}
where
      PYA.periodto           <= :p_toperiod
  and PYA.pya_year           =  :p_ryear
  and (
      PYA.ledger             =  ReconLedger.g2s
    or(
      PYA.ledger             =  ReconLedger.s2t
    )
   )
  and PYA.transactiontype    =  'P&L'
  and PYA.pya_intention_code =  :p_taxintention

group by
  PYA.ktopl,
  PYA.bunit,
  PYA.ritclg,
  PYA.glaccount,
  PYA.localcurrency,
  PYA.pya_year

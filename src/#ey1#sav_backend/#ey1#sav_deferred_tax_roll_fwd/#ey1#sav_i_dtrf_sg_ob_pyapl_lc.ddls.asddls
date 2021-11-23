@AbapCatalog.sqlViewName: '/EY1/IDTRGOBPYEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View : OB - PL PYA'
define view /EY1/SAV_I_DTRF_SG_OB_PYAPL_LC
with parameters
    p_ryear        : gjahr,
    p_taxintention : /ey1/sav_intent,
    p_toperiod     : poper
  as select from /ey1/pya_amount                as PYA
    inner join   /ey1/reconledger               as ReconLedger on PYA.bunit = ReconLedger.bunit
  //inner join   /ey1/trans_type  as TransType   on PYA.transactiontype = TransType.rldnrassgnttype
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.s2t
         and PYA.rvers                  = GetVersion.ConsolidationVersion
       )
     )
{
  key  PYA.ktopl           as ChartOfAccounts,
  key  PYA.bunit           as ConsolidationUnit,
  key  PYA.ritclg          as ConsolidationChartOfAccounts,
  key  PYA.glaccount       as GLAccount,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(PYA.yearbalance) as PYAOBPl,
       @Semantics.currencyCode: true
       PYA.localcurrency   as LocalCurrency

}
where
       PYA.periodto           <= :p_toperiod
  and  PYA.pya_year           <  :p_ryear
  and  PYA.ledger             =  ReconLedger.s2t
  and(
       PYA.transactiontype    =  'P&L'
    or PYA.transactiontype    =  'OP&L'
  )
  //and PYA.transactiontype    = 'P&L'
  and  PYA.pya_intention_code =  :p_taxintention

group by
  ktopl,
  PYA.bunit,
  ritclg,
  glaccount,
  localcurrency

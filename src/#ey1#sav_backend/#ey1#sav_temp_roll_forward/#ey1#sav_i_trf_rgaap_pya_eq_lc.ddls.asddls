@AbapCatalog.sqlViewName: '/EY1/IRGPYAEQLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP PYA EQ LC'
define view /EY1/SAV_I_TRF_RGAAP_PYA_Eq_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : /ey1/sav_intent,
    p_toperiod     : poper
  as select from /ey1/pya_amount                as PYA
    inner join   /ey1/reconledger               as ReconLedger on PYA.bunit = ReconLedger.bunit
  //inner join   /ey1/trans_type  as TransType   on PYA.transactiontype = TransType.rldnrassgnttype
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
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(PYA.yearbalance) as PYAEq,
       @Semantics.currencyCode: true
       PYA.localcurrency    as LocalCurrency

}
where
      PYA.periodto           <= :p_toperiod
  and PYA.pya_year           =  :p_ryear
  and(
      PYA.ledger             =  ReconLedger.g2s
    or(
      PYA.ledger             =  ReconLedger.s2t
    )
  )
  and PYA.transactiontype    =  'EQ'
  and PYA.pya_intention_code =  :p_taxintention

group by
  PYA.ktopl,
  PYA.bunit,
  PYA.ritclg,
  PYA.glaccount,
  PYA.localcurrency

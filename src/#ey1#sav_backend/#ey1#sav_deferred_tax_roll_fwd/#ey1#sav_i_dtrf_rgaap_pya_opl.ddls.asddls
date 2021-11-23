@AbapCatalog.sqlViewName: '/EY1/DTRFRPYAOPL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DTRF: PYA OPl'
define view /EY1/SAV_I_DTRF_RGAAP_PYA_OPl
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper,
    p_rbunit       : fc_bunit
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
       sum(PYA.yearbalance) as GAAPPYALC,

       @Semantics.currencyCode: true
       PYA.localcurrency    as LocalCurrency

}
where
      PYA.pya_year           =  :p_ryear
  and periodto               <= :p_toperiod
  and(
      PYA.ledger             =  ReconLedger.g2s
    or(
      PYA.ledger             =  ReconLedger.s2t
    )
  )
  and PYA.transactiontype    =  'OP&L'
  and PYA.pya_intention_code = $parameters.p_taxintention
  and PYA.bunit              = $parameters.p_rbunit

group by
  PYA.ktopl,
  PYA.bunit,
  PYA.ritclg,
  PYA.glaccount,
  PYA.localcurrency,
  PYA.pya_year

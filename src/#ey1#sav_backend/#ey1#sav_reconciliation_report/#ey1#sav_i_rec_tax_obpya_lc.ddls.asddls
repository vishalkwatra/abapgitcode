@AbapCatalog.sqlViewName: '/EY1/TAXPYOBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Recon Tax OB PYA LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_OBPYA_LC
  with parameters
    p_ryear        : gjahr,
    p_periodto     : poper,
    p_taxintention : /ey1/sav_intent
  as select from /ey1/pya_amount                as PYA
    inner join   /ey1/reconledger               as ReconLedger on PYA.bunit = ReconLedger.bunit
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.tax
         and PYA.rvers                  = GetVersion.ConsolidationVersion
       )
     )
{
  key  PYA.ktopl         as ChartOfAccounts,
  key  PYA.bunit         as ConsolidationUnit,
  key  PYA.ritclg        as ConsolidationChartOfAccounts,
  key  PYA.glaccount     as GLAccount,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(yearbalance)  as TaxPYAOB,
       @Semantics.currencyCode: true
       PYA.localcurrency as LocalCurrency

}
where
      periodto               <= :p_periodto
  and PYA.pya_year           <  :p_ryear
  and PYA.ledger             =  ReconLedger.tax
  and PYA.pya_intention_code =  :p_taxintention

group by
  ktopl,
  PYA.bunit,
  ritclg,
  glaccount,
  localcurrency

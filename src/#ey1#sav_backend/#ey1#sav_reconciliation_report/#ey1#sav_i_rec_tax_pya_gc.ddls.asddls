@AbapCatalog.sqlViewName: '/EY1/GLTAXPYAGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Recon Tax PYA GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_PYA_GC
  with parameters
    p_toyb         : poper,
    p_fromyb       : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
  as select from /ey1/pya_amount                as PYA
    inner join   /ey1/reconledger               as ReconLedger on  PYA.bunit  = ReconLedger.bunit
                                                               and PYA.ledger = ReconLedger.tax
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.tax
         and PYA.rvers                  = GetVersion.ConsolidationVersion
       )
     )
{
  key  PYA.ktopl               as ChartOfAccounts,
  key  PYA.bunit               as ConsolidationUnit,
  key  PYA.ritclg              as ConsolidationChartOfAccounts,
  key  PYA.glaccount           as GLAccount,
       PYA.pya_year            as FiscalYear,
       @Semantics.amount.currencyCode: 'GroupCurrency'
       sum(PYA.amountgroupcur) as TaxPYAGC,
       @Semantics.currencyCode: true
       PYA.groupcurrency       as GroupCurrency

}
where
  //      poper                  >= :p_fromyb
      periodto               <= :p_toyb
  and PYA.pya_year           =  :p_ryear
  and PYA.ledger             =  ReconLedger.tax
  and PYA.pya_intention_code =  :p_taxintention

group by
  PYA.ktopl,
  PYA.bunit,
  PYA.ritclg,
  PYA.glaccount,
  PYA.groupcurrency,
  PYA.pya_year

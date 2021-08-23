@AbapCatalog.sqlViewName: '/EY1/ETRPTAYBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-PTA Movement GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_PTA_YB_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_Reconciliation_PTA as PTA
  //    left outer join /EY1/SAV_I_Rec_TAX_PTA_SI
  //                     (p_ryear:$parameters.p_ryear,
  //                      p_taxintention : $parameters.p_taxintention) as PTASI on  PTA.rbunit = PTASI.ConsolidationUnit
  //                                                                              and PTA.ryear  = PTASI.FiscalYear
{
  key rbunit   as ConsolidationUnit,
  key ryear    as FiscalYear,
      racct    as GLAccount,
      sum(ksl) as PTAAmount,
      rkcur    as GroupCurrency
}
where
       poper        >= '001'
  and  poper        <= :p_toperiod
  and(
       taxintention <= :p_taxintention
    or taxintention =  ''
  )
  and  ryear        =  :p_ryear

group by
  rbunit,
  ryear,
  racct,
  rkcur

@AbapCatalog.sqlViewName: '/EY1/RECONADJ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Reconciliation Adjustment Interface View'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Recon_Adj
  as select from /ey1/recon_adj
{
  key racct,
  key ritem,
  key account_classcode,
  key ryear,
  key ritclg,
  key ktopl,
      statpya_lc,
      statpya_gc,
      taxpya_lc,
      taxpya_gc,

      cast(0 as abap.curr(23,2)) as StatPYALC,
      cast(0 as abap.curr(23,2)) as StatPYAGC,
      cast(0 as abap.curr(23,2)) as TaxPYALC,
      cast(0 as abap.curr(23,2)) as TaxPYAGC
}

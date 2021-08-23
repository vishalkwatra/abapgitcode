@AbapCatalog.sqlViewName: '/EY1/SAVRECONPTA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - Reconciliation PTA Table'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Reconciliation_PTA
  as select from /ey1/recon_pta
{
      ///ey1/recon_pta
  key rbunit,
  key ryear,
  key docnr,
  key buzei,
      budat,
      poper,
      taxintention,
      racct,
      fc_item,
      hsl,
      rhcur,
      ksl,
      rkcur,
      spras,
      sgtxt,
      erdat,
      erzeit,
      ernam
}

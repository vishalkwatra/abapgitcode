@AbapCatalog.sqlViewName: '/EY1/IRECADJRSN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for Recon Adjustment Reason'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Recon_Adj_Reason
  as select from /ey1/trans_type
{
  key rldnrassgnttype as AdjustmentReason,
  key trtyp           as TransType,
  key blart           as DocType
}

@AbapCatalog.sqlViewName: '/EY1/CRECADJRSN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption view for Recon Adjustment Reason'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_Recon_Adj_Reason
  as select from /EY1/SAV_I_Recon_Adj_Reason
{
  key AdjustmentReason,
  key TransType,
  key DocType
}

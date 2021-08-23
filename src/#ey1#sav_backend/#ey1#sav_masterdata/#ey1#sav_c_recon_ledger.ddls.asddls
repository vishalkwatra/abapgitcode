@AbapCatalog.sqlViewName: '/EY1/CRECLEDGER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption view for Recon Ledger'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_Recon_Ledger
  as select from /EY1/SAV_I_Recon_Ledger
{
  key bunit,
      txtmi,
      gaap,
      g2s,
      stat,
      s2t,
      tax
}

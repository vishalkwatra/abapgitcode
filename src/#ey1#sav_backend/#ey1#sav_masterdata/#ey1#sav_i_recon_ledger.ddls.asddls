@AbapCatalog.sqlViewName: '/EY1/IRECLEDGER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for Recon ledger'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Recon_Ledger
  as select from /ey1/reconledger
{
  key bunit,
      txtmi,
      gaap,
      g2s,
      stat,
      s2t,
      tax
}

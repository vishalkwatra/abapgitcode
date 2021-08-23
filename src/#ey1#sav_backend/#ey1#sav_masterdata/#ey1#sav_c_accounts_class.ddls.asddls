@AbapCatalog.sqlViewName: '/EY1/CACCNTCLMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C view for Account class Table'
@VDM.viewType: #CONSUMPTION
define view /EY1/SAV_C_Accounts_Class
  as select from /EY1/SAV_I_Accounts_Class
{
      ///EY1/SAV_I_Accounts_Class
  key acc_class_code   as AccClassCode,
      transaction_type as TransType,
      cnc              as CNC,
      bl_eq_pl         as BSEQPL,
      tax_effect       as TaxEffect,
      profit           as Profit
}

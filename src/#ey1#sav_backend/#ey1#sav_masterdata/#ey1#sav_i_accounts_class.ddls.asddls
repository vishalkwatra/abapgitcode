@AbapCatalog.sqlViewName: '/EY1/ACCNTCLASMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Accounts Class Table'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Accounts_Class
  as select from /ey1/accnt_class
{
  key acc_class_code,
      transaction_type,
      cnc,
      bl_eq_pl,
      tax_effect,
      profit
}

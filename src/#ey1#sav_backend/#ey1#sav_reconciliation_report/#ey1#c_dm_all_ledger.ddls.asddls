@AbapCatalog.sqlViewName: '/EY1/DM_ALL_LED'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data Monitor C-View -Load All Ledgers'

define view /EY1/C_DM_ALL_LEDGER
  with parameters
    p_bunit : fc_bunit
  as select distinct from /EY1/I_DM_ALL_LEDGER(p_bunit:$parameters.p_bunit)
{
  key  bunit,
       rldnr
};

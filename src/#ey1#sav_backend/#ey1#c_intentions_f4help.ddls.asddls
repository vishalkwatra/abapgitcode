@AbapCatalog.sqlViewName: '/EY1/F4_INTNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Intentions F4 Help'
define view /EY1/C_Intentions_F4Help
 as select from /EY1/SAV_C_IntentionsVH(p_mandt: $session.client) {
   mandt,
   bunit,
   gjahr,
   periodto,
   code,
   intent,
   description,
   cast(status as char15) as status,
   seqnr_flb,
   curropenperiod,
   cast(Intention as char70) as Intention
}

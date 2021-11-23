@AbapCatalog.sqlViewName: '/EY1/ITRANSTYP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C View: TransType(Without Document type)'
define view /EY1/I_TRANS_TYPE as select distinct from /ey1/trans_type {
   key trtyp,
   key rldnrassgnttype
}

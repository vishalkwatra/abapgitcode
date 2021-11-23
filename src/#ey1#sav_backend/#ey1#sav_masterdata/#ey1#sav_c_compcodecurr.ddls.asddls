@AbapCatalog.sqlViewName: '/EY1/SAVCCOCURR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View for Company Code based Currency'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_CompCodeCurr
  as select from /EY1/SAV_I_CompCodeCurr
{
  key CompanyCode,
      CompanyName,
      Country,
      Currency
}

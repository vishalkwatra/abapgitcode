@AbapCatalog.sqlViewName: '/EY1/SAVICOCURR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Company Code based Currency'
@VDM.viewType: #BASIC

define view  /EY1/SAV_I_CompCodeCurr
  as select from t001
{
  key bukrs as CompanyCode,
      butxt as CompanyName,
      land1 as Country,
      waers as Currency
}

@AbapCatalog.sqlViewName: '/EY1/TAXPTASIN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize Special Intention'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Rec_TAX_PTA_SI
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select distinct from /EY1/SAV_I_Rec_PTA
{
  key ConsolidationUnit,
  key FiscalYear,
      $parameters.p_taxintention as SpecialIntention
      //      concat('0', :p_specialperiod) as SpecialIntention
}
where
  FiscalYear = :p_ryear

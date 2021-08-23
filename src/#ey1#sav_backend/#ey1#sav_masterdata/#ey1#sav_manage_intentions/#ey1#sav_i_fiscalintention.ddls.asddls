@AbapCatalog.sqlViewName: '/EY1/INTENSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Intention Management App'
define root view /EY1/SAV_I_FiscalIntention
  as select from /ey1/fiscl_intnt
{
  key guid       as Guid,
  key gjahr      as FiscalYear,
      intention  as Intention,
      seqnr_flb  as SerialNumber,
      period_to  as PeriodTo,
      created_by as CreatedBy,
      created_on as CreatedOn,
      changed_by as ChangedBy,
      changed_on as ChangedOn
}

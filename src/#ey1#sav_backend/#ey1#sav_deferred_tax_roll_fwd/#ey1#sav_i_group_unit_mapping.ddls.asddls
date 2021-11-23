@AbapCatalog.sqlViewName: '/EY1/IMAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View - Mapping of Consolidation Group & Consolidation Unit'
@VDM.viewType: #COMPOSITE

define view /EY1/Sav_I_Group_Unit_Mapping
  as select from /ey1/ggaap_tas as TAS
    inner join   fincs_grpstr on fincs_grpstr.congr = TAS.rcongr
{
      //FINCS_GRPSTR
  key bunit          as ConsoidationUnit,

      //TAS
  key rcongr         as ConsolidationGroup,
      classification as Classification
}

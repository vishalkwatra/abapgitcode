@AbapCatalog.sqlViewName: '/EY1/IGETVERSION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch Consolidation Version'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Get_Version
  with parameters
    p_congr : fc_congr
  as select from tf184
    inner join   tf004 on tf004.dimen = tf184.dimen
{
      //TF184
  key tf184.rvers as ConsolidationVersion,
  key tf184.congr as ConsolidationGroup,
  key tf184.ryear as FiscalYear,
      tf184.rldnr as ConsolidationLedger

}
where
      tf184.congr = :p_congr
  and uname       = $session.user

@AbapCatalog.sqlViewName: '/EY1/IVERSIONINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View - Intermediate view  to fetch Version for Latest Year'

define view /EY1/SAV_I_Get_Version_int
  as select distinct from tf184            as Version
    inner join            tf004            as GlobalParam    on GlobalParam.dimen = Version.dimen
    inner join            /ey1/globalparam as SavGlobalParam on SavGlobalParam.congr = Version.congr
{

  key Version.congr      as ConsolidationGroup,
      min(Version.ryear) as FiscalYear,
      Version.rldnr      as ConsolidationLedger

}
where
      SavGlobalParam.uname = $session.user
  and GlobalParam.uname    = $session.user

group by

  Version.congr,
  Version.rldnr

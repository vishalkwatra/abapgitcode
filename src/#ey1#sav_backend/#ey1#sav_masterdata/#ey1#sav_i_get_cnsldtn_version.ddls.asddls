@AbapCatalog.sqlViewName: '/EY1/IGETVRSN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View to fetch Version for Latest Year and given Ledger'

define view /EY1/SAV_I_Get_Cnsldtn_Version
  as select from /EY1/SAV_I_Get_Version_int as GetVersion
    inner join   tf184                      as Version on  Version.congr = GetVersion.ConsolidationGroup
                                                       and Version.ryear = GetVersion.FiscalYear
                                                       and Version.rldnr = GetVersion.ConsolidationLedger
{ //zversion_max_test
  key ConsolidationGroup,
      FiscalYear,
      ConsolidationLedger,
      Version.rvers as ConsolidationVersion

}

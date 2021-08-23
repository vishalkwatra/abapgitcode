@AbapCatalog.sqlViewName: '/EY1/SAVICOUNTRY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Country'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_COUNTRY
  as select from    t005  as CountryTable
    left outer join t005t as CountryTextTable on  CountryTextTable.land1 = CountryTable.land1
                                              and CountryTextTable.spras = CountryTable.spras
{
  key CountryTable.land1       as CountryCode,
      CountryTable.landk,
      CountryTable.intca,
      CountryTable.intca3,
      CountryTable.lkvrz,
      CountryTable.waers       as Currency,

      CountryTextTable.landx50 as Description,
      CountryTextTable.natio50 as Nation
}

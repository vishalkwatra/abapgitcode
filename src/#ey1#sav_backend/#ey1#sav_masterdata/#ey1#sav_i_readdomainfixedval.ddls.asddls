@AbapCatalog.sqlViewName: '/EY1/IREADDOMVAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Read Domain Fixed Values'

@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass:#MIXED

define view /EY1/SAV_I_ReadDomainFixedVal
  as select from dd07t
{

  key domname    as SAPDataDictionaryDomain,
  key domvalue_l as DomainValue,
  key ddlanguage as LanguageCode,
      ddtext     as DomainText
}
where
      as4local = 'A'
  and as4vers  = '0000'

@AbapCatalog.sqlViewName: '/EY1/ILCGCVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View Local & Group Currency VH'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_CurrLocalGroupVH
  as select from A_CnsldtnUnit as lc
  association [0..1] to A_CnsldtnUnitT as _CnsldtnUnitT on  $projection.ConsolidationUnit = _CnsldtnUnitT.ConsolidationUnit
                                                        and _CnsldtnUnitT.Language        = $session.system_language
{
  key  lc.mandt                            as mandt,
  key  ConsolidationUnit                   as ConsolidationUnit,
  key  cast('Local' as abap.char( 5 ))     as CurrencyType,
  key  ConsolidationUnitLocalCurrency      as Currency,
       Country,

       _CnsldtnUnitT.ConsolidationUnitText as ConsolidationUnitDescription

}
union all select from /EY1/I_Group_Currency
association [0..1] to A_CnsldtnUnit as _CnsldtnUnit on $projection.ConsolidationUnit = _CnsldtnUnit.ConsolidationUnit

{
  key   bunit                               as ConsolidationUnit,
  key   cast('Group' as abap.char( 5 ))     as CurrencyType,
  key   GroupCurrency                       as Currency,
        _CnsldtnUnit.Country,
        
        _CnsldtnUnit._CnsldtnUnitT.ConsolidationUnitText as ConsolidationUnitDescription
}

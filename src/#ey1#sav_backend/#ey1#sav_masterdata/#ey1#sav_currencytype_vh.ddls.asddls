@AbapCatalog.sqlViewName: '/EY1/CURRTYPE_VH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory:#VALUE_HELP
@VDM.viewType: #BASIC
@ObjectModel.usageType: { dataClass: #CUSTOMIZING,
                          serviceQuality: #C,
                          sizeCategory: #M }
@EndUserText.label: 'VH for Currency Type'

define view /EY1/SAV_CURRENCYTYPE_VH
  as select from /ey1/curr_type
{
      //zcurrency_type
      @ObjectModel.text.element: ['type_name']
      @EndUserText.label: 'Currency Type'
  key currency_type,

      @Semantics.text:true
      @EndUserText.label: 'Type Name'
      type_name
}

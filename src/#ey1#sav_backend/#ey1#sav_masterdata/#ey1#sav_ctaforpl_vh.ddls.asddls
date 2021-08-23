@AbapCatalog.sqlViewName: '/EY1/CTAFORPLVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory:#VALUE_HELP
@VDM.viewType: #BASIC
@ObjectModel.usageType: { dataClass: #CUSTOMIZING,
                          serviceQuality: #C,
                          sizeCategory: #M }
@EndUserText.label: 'VH for CTA for pl'

define view /EY1/SAV_CTAforPL_VH
  as select from /ey1/ctaforpl_vh
{
      ///EY1/CTAFORPL_VH
      @ObjectModel.text.element: ['text']
      @EndUserText.label: 'CTA for P&L'
  key value,
  
      @Semantics.text:true
      @EndUserText.label: 'Text'
      text
}

@AbapCatalog.sqlViewName : '/EY1/SAVCTAXANLT'
@Analytics.query: true
@OData.publish: true
@EndUserText.label: 'Analytics- Manage Tax Rate'

define view /EY1/SAV_C_TAX_ANLT

  as select from /EY1/SAV_I_CTR_Tax_Rate
{

  current_tax_rate,
  @AnalyticsDetails.query.axis:#ROWS
  @Consumption.hidden: true
  rbunit,
  @EndUserText.label: 'Fiscal Year'
  @AnalyticsDetails.query.axis:#ROWS
  gjahrForEdit,
  @EndUserText.label: 'Intention'
  @AnalyticsDetails.query.axis:#ROWS
  intentionForEdit,
  //@EndUserText.label: 'STAT OB DT Rate'
  //stat_ob_dt_rateForEdit,
  @EndUserText.label: 'Cons. unit'
  rbunitForEdit,
  @EndUserText.label: 'GAAP CB DT Rate'
  gaap_cb_dt_rate,
  @EndUserText.label: 'GAAP OB DT Rate'
  gaap_ob_dt_rate,
  @EndUserText.label: 'STAT CB DT Rate'
  stat_cb_dt_rate,
  @EndUserText.label: 'STAT OB DT Rate'
  stat_ob_dt_rate
  
}

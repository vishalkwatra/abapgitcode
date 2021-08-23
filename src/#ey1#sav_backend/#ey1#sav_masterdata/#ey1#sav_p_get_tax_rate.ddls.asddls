@AbapCatalog.sqlViewName: '/EY1/PGETTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Private View - Get Tax Rates'

define view /EY1/SAV_P_Get_Tax_Rate
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr,
    p_rbunit   : fc_bunit

  as select from /EY1/SAV_TaxRate_TF( clnt:$session.client , 
                                      p_toperiod:$parameters.p_toperiod ,
                                      p_ryear:$parameters.p_ryear, 
                                      p_rbunit:  $parameters.p_rbunit)
{
  key rbunit,
  key gjahr,
  key intention,
      current_tax_rate,
      gaap_ob_dt_rate,
      gaap_cb_dt_rate,
      stat_ob_dt_rate,
      stat_cb_dt_rate
}

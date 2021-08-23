@EndUserText.label: 'CDS Table Function to fetch Tax Rates'
define table function /EY1/SAV_TaxRate_TF
  with parameters
    @Environment.systemField: #CLIENT
    clnt       : abap.clnt,
    p_toperiod : poper,
    p_ryear    : gjahr,
    p_rbunit   : fc_bunit
returns
{
  client           : abap.clnt;
  rbunit           : fc_bunit;
  gjahr            : gjahr;
  intention        : /ey1/sav_intent;
  current_tax_rate : /ey1/sav_current_tax_rate;
  gaap_ob_dt_rate  : /ey1/sav_gaap_ob_dt_rate;
  gaap_cb_dt_rate  : /ey1/sav_gaap_cb_dt_rate;
  stat_ob_dt_rate  : /ey1/sav_stat_ob_dt_rate;
  stat_cb_dt_rate  : /ey1/sav_stat_cb_dt_rate;

}
implemented by method
  /EY1/SAV_CL_Tax_Rates=>get_tax_rate;

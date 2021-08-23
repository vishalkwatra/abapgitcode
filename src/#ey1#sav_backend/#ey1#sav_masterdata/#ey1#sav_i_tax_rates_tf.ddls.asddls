@EndUserText.label: 'Table Function to fetch Tax Rates with Backup'
define table function /EY1/SAV_I_Tax_Rates_TF
  with parameters
    @Environment.systemField: #CLIENT
    clnt       : abap.clnt,
    p_toperiod : poper,
    p_ryear    : gjahr
returns
{
  client            : abap.clnt;
  ConsolidationUnit : fc_bunit;
  FiscalYear        : gjahr;
  Intention         : /ey1/sav_intent;
  GaapOBRate        : /ey1/sav_gaap_ob_dt_rate;
  GaapCBRate        : /ey1/sav_gaap_cb_dt_rate;
  StatOBRate        : /ey1/sav_stat_ob_dt_rate;
  StatCBRate        : /ey1/sav_stat_cb_dt_rate;
  CurrentTaxRate    : /ey1/sav_current_tax_rate;
}
implemented by method
  /EY1/SAV_CL_Tax_Rates=>calculate_tax_rate_backup;

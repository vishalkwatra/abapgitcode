@AbapCatalog.sqlViewName: '/EY1/ITAXRATEQ1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-view to fetch TaxRate for Intention Q1'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Fetch_Tax_Rate_Q1
  with parameters
    p_ryear : gjahr
  as select from /ey1/tax_rates as TaxRate
{
      //TaxRate
  key rbunit           as ConsolidationUnit,
  key gjahr            as FiscalYear,
  key intention,
      gaap_ob_dt_rate  as GaapOBRate,
      gaap_cb_dt_rate  as GaapCBRate,
      stat_ob_dt_rate  as StatOBRate,
      stat_cb_dt_rate  as StatCBRate,
      current_tax_rate as CurrentTaxRate
}
where
      gjahr     = :p_ryear
  and intention = 'Q1'

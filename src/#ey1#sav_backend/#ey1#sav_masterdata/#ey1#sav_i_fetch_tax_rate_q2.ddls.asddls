@AbapCatalog.sqlViewName: '/EY1/ITAXRATEQ2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Fetch Tax Rate for Intention Q2'

define view /EY1/SAV_I_Fetch_Tax_Rate_Q2
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
  and intention = 'Q2'

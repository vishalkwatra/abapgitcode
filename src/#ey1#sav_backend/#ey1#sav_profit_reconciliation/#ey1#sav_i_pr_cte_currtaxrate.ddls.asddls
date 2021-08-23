@AbapCatalog.sqlViewName: '/EY1/IPRCTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I View to fetch Current Tax value for Intention'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CTE_CurrTaxRate
  with parameters
    p_rbunit    : fc_bunit,
    p_intention : /ey1/sav_intent,
    p_ryear     : gjahr

  as select from    /EY1/SAV_I_CTR_Tax_Rate         as TaxRate
    left outer join /EY1/SAV_I_Fetch_Tax_Rate_TXP
                    ( p_ryear:$parameters.p_ryear ) as TXP on  TXP.ConsolidationUnit = TaxRate.rbunit
                                                           and TXP.FiscalYear        = $parameters.p_ryear
{ ///EY1/SAV_I_CTR_Tax_Rate
  key rbunit,
  key gjahr,
      TaxRate.intention,

      case $parameters.p_intention

       when 'Q1'  then TaxRate.current_tax_rate
       when 'Q2'  then TaxRate.current_tax_rate
       when 'Q3'  then TaxRate.current_tax_rate
       when 'TXP' then TaxRate.current_tax_rate
       else TXP.CurrentTaxRate
       end as CurrentTaxRate

      //      rbunitForEdit,
      //      gjahrForEdit,
      //      intentionForEdit,
      //      current_tax_rate
      //      current_tax_rateForEdit,
      //      gaap_ob_dt_rate,
      //      gaap_ob_dt_rateForEdit,
      //      gaap_cb_dt_rate,
      //      gaap_cb_dt_rateForEdit,
      //      stat_ob_dt_rate,
      //      stat_ob_dt_rateForEdit,
      //      stat_cb_dt_rate,
      //      stat_cb_dt_rateForEdit,
      //      created_by,
      //      created_on,
      //      changed_by,
      //      changed_on

}
where
      rbunit = $parameters.p_rbunit
  and gjahr  = $parameters.p_ryear

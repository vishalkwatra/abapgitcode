@AbapCatalog.sqlViewName: '/EY1/PTAXRATES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Private View - Fetching Tax Rates - Based on Periods'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_P_Fetch_Tax_Rates
  with parameters
    p_toperiod : poper,
    p_ryear    : gjahr

  as select distinct from /ey1/tax_rates            as TaxRates

    left outer join       /EY1/SAV_I_Fetch_Tax_Rate_Q1
                    ( p_ryear:$parameters.p_ryear ) as TaxRateQ1  on  TaxRateQ1.ConsolidationUnit = TaxRates.rbunit
                                                                  and TaxRateQ1.FiscalYear        = TaxRates.gjahr
                                                                  and TaxRateQ1.intention         = TaxRates.intention
    left outer join       /EY1/SAV_I_Fetch_Tax_Rate_Q2
                    ( p_ryear:$parameters.p_ryear ) as TaxRateQ2  on  TaxRateQ2.ConsolidationUnit = TaxRates.rbunit
                                                                  and TaxRateQ2.FiscalYear        = TaxRates.gjahr
                                                                  and TaxRateQ2.intention         = TaxRates.intention
    left outer join       /EY1/SAV_I_Fetch_Tax_Rate_Q3
                    ( p_ryear:$parameters.p_ryear ) as TaxRateQ3  on  TaxRateQ3.ConsolidationUnit = TaxRates.rbunit
                                                                  and TaxRateQ3.FiscalYear        = TaxRates.gjahr
                                                                  and TaxRateQ3.intention         = TaxRates.intention
    left outer join       /EY1/SAV_I_Fetch_Tax_Rate_TXP
                    ( p_ryear:$parameters.p_ryear ) as TaxRateTXP on  TaxRateTXP.ConsolidationUnit = TaxRates.rbunit
                                                                  and TaxRateTXP.FiscalYear        = TaxRates.gjahr
                                                                  and TaxRateTXP.intention         = TaxRates.intention
{
  key rbunit                    as ConsolidationUnit,
  key gjahr                     as FiscalYear,

      case $parameters.p_toperiod

      when '001' then TaxRateQ1.intention
      when '002' then TaxRateQ1.intention
      when '003' then TaxRateQ1.intention

      when '004' then TaxRateQ2.intention
      when '005' then TaxRateQ2.intention
      when '006' then TaxRateQ2.intention

      when '007' then TaxRateQ3.intention
      when '008' then TaxRateQ3.intention
      when '009' then TaxRateQ3.intention

       else TaxRateTXP.intention
       end                      as Intention,


      case $parameters.p_toperiod

      when '001' then TaxRateQ1.GaapOBRate
      when '002' then TaxRateQ1.GaapOBRate
      when '003' then TaxRateQ1.GaapOBRate

      when '004' then TaxRateQ2.GaapOBRate
      when '005' then TaxRateQ2.GaapOBRate
      when '006' then TaxRateQ2.GaapOBRate

      when '007' then TaxRateQ3.GaapOBRate
      when '008' then TaxRateQ3.GaapOBRate
      when '009' then TaxRateQ3.GaapOBRate

      else TaxRateTXP.GaapOBRate
      end                       as GaapOBDTRate,

      case $parameters.p_toperiod

      when '001' then TaxRateQ1.GaapCBRate
      when '002' then TaxRateQ1.GaapCBRate
      when '003' then TaxRateQ1.GaapCBRate

      when '004' then TaxRateQ2.GaapCBRate
      when '005' then TaxRateQ2.GaapCBRate
      when '006' then TaxRateQ2.GaapCBRate

      when '007' then TaxRateQ3.GaapCBRate
      when '008' then TaxRateQ3.GaapCBRate
      when '009' then TaxRateQ3.GaapCBRate

      else TaxRateTXP.GaapCBRate
      end                       as GaapCBDTRate,

      case $parameters.p_toperiod

      when '001' then TaxRateQ1.StatOBRate
      when '002' then TaxRateQ1.StatOBRate
      when '003' then TaxRateQ1.StatOBRate

      when '004' then TaxRateQ2.StatOBRate
      when '005' then TaxRateQ2.StatOBRate
      when '006' then TaxRateQ2.StatOBRate

      when '007' then TaxRateQ3.StatOBRate
      when '008' then TaxRateQ3.StatOBRate
      when '009' then TaxRateQ3.StatOBRate

      else TaxRateTXP.StatOBRate
      end                       as StatOBDTRate,

      case $parameters.p_toperiod

      when '001' then TaxRateQ1.StatCBRate
      when '002' then TaxRateQ1.StatCBRate
      when '003' then TaxRateQ1.StatCBRate

      when '004' then TaxRateQ2.StatCBRate
      when '005' then TaxRateQ2.StatCBRate
      when '006' then TaxRateQ2.StatCBRate

      when '007' then TaxRateQ3.StatCBRate
      when '008' then TaxRateQ3.StatCBRate
      when '009' then TaxRateQ3.StatCBRate

      else TaxRateTXP.StatCBRate
      end                       as StatCBDTRate,

      case $parameters.p_toperiod

      when '001' then TaxRateQ1.CurrentTaxRate
      when '002' then TaxRateQ1.CurrentTaxRate
      when '003' then TaxRateQ1.CurrentTaxRate

      when '004' then TaxRateQ2.CurrentTaxRate
      when '005' then TaxRateQ2.CurrentTaxRate
      when '006' then TaxRateQ2.CurrentTaxRate

      when '007' then TaxRateQ3.CurrentTaxRate
      when '008' then TaxRateQ3.CurrentTaxRate
      when '009' then TaxRateQ3.CurrentTaxRate

      else TaxRateTXP.CurrentTaxRate
      end                       as CurrentTaxRate,

      TaxRateTXP.CurrentTaxRate as CurrentTaxRateTXP,
      TaxRateTXP.GaapOBRate     as GaapOBRateTXP,
      TaxRateTXP.GaapCBRate     as GaapCBRateTXP,
      TaxRateTXP.StatOBRate     as StatOBRateTXP,
      TaxRateTXP.StatCBRate     as StatCBRateTXP,
      TaxRateTXP.intention      as IntentionTXP
}
where
  gjahr = :p_ryear

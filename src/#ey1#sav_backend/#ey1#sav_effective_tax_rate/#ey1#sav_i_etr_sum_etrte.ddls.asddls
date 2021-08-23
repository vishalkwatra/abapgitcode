@AbapCatalog.sqlViewName: '/EY1/ETRSUMETRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- Summary- Effective Tax Rate/Tax Expense'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_ETRTE
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_intention     : /ey1/sav_intent,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit

  as select from /EY1/SAV_I_ETR_SUM_ETRTE_TP
                 ( p_cntry: $parameters.p_cntry, p_ryear:$parameters.p_ryear ,
                 p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,
                 p_intention: $parameters.p_intention, p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention,
                 p_rbunit: $parameters.p_rbunit) as EffTaxRate

{
  key    EffTaxRate.ConsolidationDimension,
  key    EffTaxRate.FiscalYear,
  key    EffTaxRate.ConsolidationChartofAccounts,
  key    EffTaxRate.ChartOfAccounts,
  key    EffTaxRate.ConsolidationUnit,

//         CountryKey,
//         Intention,

         EffTaxRate.MainCurrency,

         cast (0 as abap.curr(23,2))                                                                 as Amount,


         case when PBT is null then cast(0 as /ey1/sav_rate)
         when PBT = 0 then cast(0 as /ey1/sav_rate)
         else (cast(EffTaxRate.Tax as abap.fltp(16,16)) / 0.01) / cast(PBT  as abap.fltp(16,16)) end as Rate,

         EffTaxRate.Tax,
         EffTaxRate.Percentage,

         EffTaxRate.ReportingType,
         EffTaxRate.CurrType
}

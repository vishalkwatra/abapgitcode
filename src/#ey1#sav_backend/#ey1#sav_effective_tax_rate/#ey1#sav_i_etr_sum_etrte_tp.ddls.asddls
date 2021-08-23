@AbapCatalog.sqlViewName: '/EY1/ETRSUMTAXP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- Summary- Effective Tax Rate - Tax & Percentage'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_ETRTE_TP
  with parameters
    p_cntry         : land1,
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_intention     : /ey1/sav_intent,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit

  as select from /EY1/SAV_I_ETR_SUM_ETRTE_TP_NL
                 ( p_cntry: $parameters.p_cntry,
                 p_ryear: $parameters.p_ryear,
                 p_fromperiod:$parameters.p_fromperiod ,
                 p_toperiod: $parameters.p_toperiod,
                 p_intention: $parameters.p_intention,
                 p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention,
                 p_rbunit: $parameters.p_rbunit)

{

      ///EY1/SAV_I_ETR_SUM_ETRTE_TP_NL
  key ConsolidationDimension,
  key FiscalYear,
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
      ConsolidationUnit,
      PBT,
      //      CountryKey,
      //      Intention,
      MainCurrency,

      cast(ITDCTRTax as /ey1/sav_amount) + cast(ETEBTax as /ey1/sav_amount) + cast(DDCTETax as /ey1/sav_amount) + cast(BDDTTax as /ey1/sav_amount) + cast(PTATax as /ey1/sav_amount)   + cast(CTRTDTax as /ey1/sav_amount)                            as Tax,


      cast(ITDCTRPercentage as /ey1/sav_rate) + cast(ETEBPercentage as /ey1/sav_rate) + cast(DDCTEPercentage as /ey1/sav_rate) + cast(BDDTPercentage as /ey1/sav_rate) + cast(PTAPercentage as /ey1/sav_rate)+ cast(CTRTDPercentage as /ey1/sav_rate) as Percentage,


      CurrType,
      ReportingType

}

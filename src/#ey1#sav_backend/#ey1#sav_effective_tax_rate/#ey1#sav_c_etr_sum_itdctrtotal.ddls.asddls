@AbapCatalog.sqlViewName: '/EY1/CETRITCTRTT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View- ETR- Summary-TOTAL-Inc Taxed Diff Current Tax Rate'

@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ETR_SUM_ITDCTRTotal
  with parameters
    p_cntry     : land1,
    p_ryear     : gjahr,
    p_intention : /ey1/sav_intent

  as select from /EY1/SAV_I_ETR_SUM_ITDCTRTotal
                 (p_cntry:$parameters.p_cntry,
                 p_ryear: $parameters.p_ryear,
                 p_intention: $parameters.p_intention) as ETR

{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key FiscalYear,
  key ConsolidationUnit,
  key CountryKey,
  key Intention,

      @Semantics.currencyCode: true
  key MainCurrency,
      Percentage,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Tax
}

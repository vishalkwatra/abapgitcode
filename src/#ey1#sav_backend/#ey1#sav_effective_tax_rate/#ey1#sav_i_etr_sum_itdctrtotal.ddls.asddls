@AbapCatalog.sqlViewName: '/EY1/ETRSUMTRTOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- Summary-TOTAL-Inc Taxed Diff Current Tax Rate'

define view /EY1/SAV_I_ETR_SUM_ITDCTRTotal
  with parameters
    p_cntry     : land1,
    p_ryear     : gjahr,
    p_intention : /ey1/sav_intent
  as select from /ey1/tiers_split

{
  key ritclg                                                                         as ConsolidationChartofAccounts,
  key ktopl                                                                          as ChartOfAccounts,
  key ryear                                                                          as FiscalYear,
  key bunit                                                                          as ConsolidationUnit,
  key land1                                                                          as CountryKey,
  key intention                                                                      as Intention,
  key main_currency                                                                  as MainCurrency,


      case when percentage is null then cast(0 as /ey1/sav_rate) else percentage end as Percentage,
      case when tax is null then cast(0 as /ey1/sav_amount) else tax end             as Tax
}
where
      land1     = :p_cntry
  and ryear     = :p_ryear
  and intention = :p_intention

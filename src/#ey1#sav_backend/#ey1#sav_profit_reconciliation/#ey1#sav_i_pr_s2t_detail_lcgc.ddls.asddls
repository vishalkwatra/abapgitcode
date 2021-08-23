@AbapCatalog.sqlViewName: '/EY1/PRS2TDLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T -Detail LCGC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_S2T_Detail_LCGC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_S2T_Total_LC
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as ReconciliationCheck,

      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_S2T_Total_GC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as ReconciliationCheck,

      cast('Group' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_S2T_FPLBT_LC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as ReconciliationCheck,

      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_S2T_FPLBT_GC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as ReconciliationCheck,

      cast('Group' as abap.char(5)) as CurrencyType
}

union all select from /EY1/SAV_I_PR_S2T_CCTax_LC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      ReconciliationCheck,

      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_PR_S2T_CCTax_GC
                      ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,p_taxintention:$parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as TotalS2T,

      @Semantics.amount.currencyCode: 'MainCurrency'
      cast(0 as abap.curr(23,2))    as FiscalIncomeLossBT,

      @Semantics.amount.currencyCode: 'MainCurrency'
      ReconciliationCheck,

      cast('Group' as abap.char(5)) as CurrencyType
}

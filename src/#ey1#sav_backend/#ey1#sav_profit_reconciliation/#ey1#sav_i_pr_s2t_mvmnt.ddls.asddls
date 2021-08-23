@AbapCatalog.sqlViewName: '/EY1/PRS2TYB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T -Year Mvmnt'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_S2T_Mvmnt
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_S2T_YB_LCGC
                 ( p_toperiod:$parameters.p_toperiod, p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)
{
      ///EY1/SAV_I_PR_G2S_YB_LCGC
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
  key GLAccount,
  key AccountClassCode,
      ConsolidationDimension,
      @Semantics.currencyCode: true
      MainCurrency,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TPLYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TPmntYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TransactionTotal,
      CurrencyType
}
where S2TPLYearBalance != 0
or S2TPmntYearBalance !=0
or TransactionTotal !=0 

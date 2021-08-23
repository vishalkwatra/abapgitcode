@AbapCatalog.sqlViewName: '/EY1/ERS2TOBLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T OB LC GC Union'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_LCGCUnion
  with parameters
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_S2T_OB_LC( p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TAdjustAmt,
      @Semantics.currencyCode: true
      LocalCurrency as MainCurrency,
      BsEqPl,
      TaxEffected,
      CurrencyType
}
union all select from /EY1/SAV_I_ER_S2T_OB_GC( p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TAdjustAmt,
      @Semantics.currencyCode: true
      GroupCurrency as MainCurrency,
      BsEqPl,
      TaxEffected,
      CurrencyType
}

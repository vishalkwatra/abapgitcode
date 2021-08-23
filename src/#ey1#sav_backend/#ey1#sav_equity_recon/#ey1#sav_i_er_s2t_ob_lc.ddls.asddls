@AbapCatalog.sqlViewName: '/EY1/ERS2TOBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch ER S2T OB Sum Values for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_LC
  with parameters
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_S2T_OB_BETE_LC( p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      S2TAdjustAmt,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected,
      cast ('Local' as abap.char(5)) as CurrencyType

}
union all select from /EY1/SAV_I_ER_S2T_OB_RE_LC( p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention )
{


  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key AccountClassCode,
  key ConsolidationDimension,
  key FiscalYear,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      S2TAdjustAmt,
      @Semantics.currencyCode: true
      LocalCurrency,
      BsEqPl,
      TaxEffected,
      cast ('Local' as abap.char(5)) as CurrencyType
}

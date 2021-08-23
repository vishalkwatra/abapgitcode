@AbapCatalog.sqlViewName: '/EY1/ESTRCOBLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER S2T OBRec Check LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_S2T_OB_RCHK_LCGC
  with parameters
    p_ryear         : gjahr,
    p_fromyb        : poper,
    p_toyb          : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_S2T_OB_RChk_LC(
                 p_ryear:$parameters.p_ryear ,
                 p_taxintention:$parameters.p_taxintention )
{
  key ConsolidationDimension,
  key FiscalYear,
  key GLAccount,
      ChartOfAccounts,
      ConsolidationUnit,
      @Semantics.currencyCode: true
      LocalCurrency                 as MainCurrency,
      ConsolidationChartofAccounts,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TAXOpeningBalance,

      //      @Semantics.amount.currencyCode: 'MainCurrency'
      //      cast(0 as abap.curr(23,2))    as YBClosingBalance,
      //      @Semantics.amount.currencyCode: 'MainCurrency'
      //      cast(0 as abap.curr(23,2))    as CBClosingBalance,

      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_ER_S2T_OB_RChk_GC(
                      p_ryear:$parameters.p_ryear ,
                      p_taxintention:$parameters.p_taxintention )
{
  key ConsolidationDimension,
  key FiscalYear,
  key GLAccount,
      ChartOfAccounts,
      ConsolidationUnit,
      @Semantics.currencyCode: true
      GroupCurrency                 as MainCurrency,
      ConsolidationChartofAccounts,
      @Semantics.amount.currencyCode: 'MainCurrency'
      TaxOpeningBalance,
      //      @Semantics.amount.currencyCode: 'MainCurrency'
      //      cast(0 as abap.curr(23,2))    as YBClosingBalance,
      //      @Semantics.amount.currencyCode: 'MainCurrency'
      //      cast(0 as abap.curr(23,2))    as CBClosingBalance,
      cast('Group' as abap.char(5)) as CurrencyType
}

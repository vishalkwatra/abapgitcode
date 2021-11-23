@AbapCatalog.sqlViewName: '/EY1/EGSRCOBLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S OBRec Check LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_OB_RCHK_LCGC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention

  as select from /EY1/SAV_I_ER_G2S_OB_RChk_LC(p_ryear:$parameters.p_ryear ,
                                              p_taxintention: $parameters.p_taxintention,
                                              p_toyb:$parameters.p_toyb,
                                              p_intention: $parameters.p_intention)
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
      StatOpeningBalance,

      cast('Local' as abap.char(5)) as CurrencyType
}
union all select from /EY1/SAV_I_ER_G2S_OB_RChk_GC(p_ryear:$parameters.p_ryear ,
                                                   p_taxintention: $parameters.p_taxintention,
                                                   p_toyb:$parameters.p_toyb,
                                              p_intention: $parameters.p_intention)
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
      StatOpeningBalance,

      cast('Group' as abap.char(5)) as CurrencyType
}

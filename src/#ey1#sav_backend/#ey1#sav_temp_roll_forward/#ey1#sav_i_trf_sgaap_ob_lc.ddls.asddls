@AbapCatalog.sqlViewName: '/EY1/ISGOBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd SGAAP OB Temp Diff-LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_OB_LC
  with parameters
    p_ryear        : gjahr,
    //    p_taxintention : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select from /EY1/SAV_I_TRF_SGAAP_OB_NRM_LC
                 (p_ryear:$parameters.p_ryear,
                  p_taxintention :$parameters.p_taxintention,
                  p_toperiod :$parameters.p_toperiod ) as GLAccnt
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqOpeningBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlOpeningBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PmntOpeningBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqOpeningBalance + PlOpeningBalance + PmntOpeningBalance as TempDiffOpeningBalance

}

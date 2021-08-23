@AbapCatalog.sqlViewName: '/EY1/ERGAAPYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch ER GAAP YB balance for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_YB_LC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD( p_ryear: $parameters.p_ryear)                        as EQMD

    left outer join /EY1/SAV_I_ER_GAAPEQ_YB_PL_LC( p_ryear: $parameters.p_ryear,
                                                   p_fromperiod: $parameters.p_fromperiod,
                                                   p_toperiod: $parameters.p_toperiod,
                                                   p_taxintention: $parameters.p_taxintention) as YBPLSum on  YBPLSum.ConsolidationUnit            = EQMD.ConsolidationUnit
                                                                                                            and YBPLSum.ConsolidationDimension       = EQMD.ConsolidationDimension
                                                                                                            and YBPLSum.FiscalYear                   = EQMD.FiscalYear
                                                                                                            and YBPLSum.ConsolidationChartofAccounts = EQMD.ConsolidationChartofAccounts
                                                                                                            and EQMD.AccountClassCode                = 'RE'

{
      //EQMD
  key ConsolidationLedger,
  key EQMD.ConsolidationDimension,
  key AccountClassCode,
  key GLAccount,
  key EQMD.FiscalYear,
  key EQMD.ConsolidationUnit,

      FinancialStatementItem,
      EQMD.ChartOfAccounts,
      EQMD.ConsolidationChartofAccounts,
      //      EQMD.BsEqPl,
      //      TaxEffected,

      //YBPLSum
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapMvmnt,

      @Semantics.currencyCode: true
      YBPLSum.LocalCurrency
}
where
  AccountClassCode = 'RE'

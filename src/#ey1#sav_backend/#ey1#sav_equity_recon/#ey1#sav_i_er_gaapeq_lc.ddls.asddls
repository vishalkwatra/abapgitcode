@AbapCatalog.sqlViewName: '/EY1/ERGEQLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch LC values of Gaap EQ section of ER'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_LC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD( p_ryear: $parameters.p_ryear)                              as EQMD

    left outer join /EY1/SAV_I_ER_GAAPEQ_OB_LC( p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention )         as GaapOBLC on  GaapOBLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapOBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapOBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_YB_LC( p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention )         as GaapYBLC on  GaapYBLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapYBLC.Fiscalyear        = EQMD.FiscalYear
                                                                                                                   and GaapYBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_CB_LC( p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention )         as GaapCBLC on  GaapCBLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapCBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapCBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_Equity_LC( p_toperiod:$parameters.p_toperiod,
                                                        p_ryear:$parameters.p_ryear,
                                                        p_taxintention: $parameters.p_taxintention ) as GaapEQLC on  GaapEQLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapEQLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapEQLC.ConsolidationUnit = EQMD.ConsolidationUnit
{ 
  key EQMD.ChartOfAccounts,
  key EQMD.ConsolidationUnit,
  key EQMD.ConsolidationChartofAccounts,
  key EQMD.FiscalYear,
  key EQMD.AccountClassCode,
  key EQMD.GLAccount,

      EQMD.ConsolidationDimension,

      EQMD.FinancialStatementItem,

      @Semantics.currencyCode: true
      EQMD.LocalCurrency,

      //GaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapOBLC.GaapOpeningBalance,

      //GaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapYBLC.GaapMvmnt,

      //GaapEQLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapEQLC.GaapEQ,

      //GaapCBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapCTA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapClosingBalance,

      cast ('Local' as abap.char(5)) as CurrencyType
}

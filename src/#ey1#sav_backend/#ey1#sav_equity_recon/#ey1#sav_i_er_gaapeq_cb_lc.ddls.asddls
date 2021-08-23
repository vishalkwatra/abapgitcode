@AbapCatalog.sqlViewName: '/EY1/ERGAAPCBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch ER GAAP EQ Closing Balance for LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_CB_LC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD( p_ryear: $parameters.p_ryear)                          as EQMD

    left outer join /EY1/SAV_I_ER_GAAPEQ_OB_LC( p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention )     as GaapOBLC on  GaapOBLC.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapOBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapOBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_YB_LC( p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention )     as GaapYBLC on  GaapYBLC.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapYBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapYBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_Equity_LC( p_toperiod:$parameters.p_toperiod,
                                                    p_ryear:$parameters.p_ryear,
                                                    p_taxintention: $parameters.p_taxintention ) as GaapEQLC on  GaapEQLC.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapEQLC.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapEQLC.ConsolidationUnit = EQMD.ConsolidationUnit
{ //EQMD
  key EQMD.ConsolidationDimension,
  key EQMD.GLAccount,
  key EQMD.FiscalYear,
  key EQMD.ConsolidationUnit,
  key EQMD.ChartOfAccounts,
  
      EQMD.FinancialStatementItem,
      EQMD.ConsolidationChartofAccounts,

      @Semantics.currencyCode: 'true'
      EQMD.LocalCurrency,

      //GaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapOpeningBalance,

      //GaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapMvmnt,

      //GaapEQLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapEQ,

      cast (0 as abap.curr( 23, 2))                                                      as GaapCTA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when GaapOpeningBalance is null then cast( case when GaapMvmnt is null then GaapEQ
                                                                 when GaapEQ is null then GaapMvmnt
                                                                 else GaapMvmnt + GaapEQ end as abap.curr(23,2))

                 when GaapMvmnt is null then cast( case when GaapOpeningBalance is null then GaapEQ
                                                              when GaapEQ is null then GaapOpeningBalance
                                                              else GaapOpeningBalance + GaapEQ end as abap.curr(23,2))

                 when GaapEQ is null then cast(case when GaapOpeningBalance is null then GaapMvmnt
                                                              when GaapMvmnt is null then GaapOpeningBalance
                                                              else GaapOpeningBalance + GaapMvmnt end as abap.curr(23,2))

                 else GaapOpeningBalance + GaapMvmnt + GaapEQ end as abap.curr( 23, 2 )) as GaapClosingBalance
}

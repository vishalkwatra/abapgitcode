@AbapCatalog.sqlViewName: '/EY1/ERGEQGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to fetch GC values of Gaap EQ section of ER'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_GAAPEQ_GC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD( p_ryear: $parameters.p_ryear)                              as EQMD

    left outer join /EY1/SAV_I_ER_GAAPEQ_OB_GC( p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention )         as GaapOBLC on  GaapOBLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapOBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapOBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_YB_GC( p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention )         as GaapYBLC on  GaapYBLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapYBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapYBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_CB_GC( p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention )         as GaapCBLC on  GaapCBLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapCBLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapCBLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_Equity_GC( p_toperiod:$parameters.p_toperiod,
                                                        p_ryear:$parameters.p_ryear,
                                                        p_taxintention: $parameters.p_taxintention ) as GaapEQLC on  GaapEQLC.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapEQLC.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapEQLC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_CTA_GC( p_ryear:$parameters.p_ryear,
                                                        p_fromperiod:$parameters.p_fromperiod,
                                                        p_toperiod:$parameters.p_toperiod,
                                                        p_taxintention: $parameters.p_taxintention ) as GaapCTA  on  GaapCTA.GLAccount         = EQMD.GLAccount
                                                                                                                   and GaapCTA.FiscalYear        = EQMD.FiscalYear
                                                                                                                   and GaapCTA.ConsolidationUnit = EQMD.ConsolidationUnit
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
      EQMD.GroupCurrency,
      
      //GaapOBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapOBLC.GaapOpeningBalance,
      
      //GaapYBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapYBLC.GaapMvmnt,
      
      //GaapEQLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapEQLC.GaapEQ,

      //GaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapCTA.GaapCTA,

      //GaapCBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      cast( case when GaapOBYB is null then GaapEQCTA
                when GaapEQCTA is null then GaapOBYB
                else GaapEQCTA + GaapOBYB end as abap.curr(23,2)) as GaapClosingBalance,

      cast ('Group' as abap.char(5))                              as CurrencyType
}

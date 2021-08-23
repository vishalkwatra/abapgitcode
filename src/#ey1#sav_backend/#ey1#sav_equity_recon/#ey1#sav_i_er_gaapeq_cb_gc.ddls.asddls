@AbapCatalog.sqlViewName: '/EY1/ERGAAPCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View to fetch ER GAAP EQ Closing Balance for GC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_ER_GAAPEQ_CB_GC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD( p_ryear: $parameters.p_ryear)                          as EQMD

    left outer join /EY1/SAV_I_ER_GAAPEQ_OB_GC( p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention )     as GaapOBGC on  GaapOBGC.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapOBGC.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapOBGC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_YB_GC( p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention )     as GaapYBGC on  GaapYBGC.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapYBGC.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapYBGC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_Equity_GC( p_toperiod:$parameters.p_toperiod,
                                                    p_ryear:$parameters.p_ryear,
                                                    p_taxintention: $parameters.p_taxintention ) as GaapEQGC on  GaapEQGC.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapEQGC.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapEQGC.ConsolidationUnit = EQMD.ConsolidationUnit
    left outer join /EY1/SAV_I_ER_GAAPEQ_CTA_GC( p_ryear:$parameters.p_ryear,
                                                    p_fromperiod:$parameters.p_fromperiod,
                                                    p_toperiod:$parameters.p_toperiod,
                                                    p_taxintention: $parameters.p_taxintention ) as GaapCTA  on  GaapCTA.GLAccount         = EQMD.GLAccount
                                                                                                               and GaapCTA.FiscalYear        = EQMD.FiscalYear
                                                                                                               and GaapCTA.ConsolidationUnit = EQMD.ConsolidationUnit
{ //EQMD  
  key EQMD.ConsolidationDimension,
  key EQMD.GLAccount,
  key EQMD.FiscalYear,
  key EQMD.ConsolidationUnit,
  key EQMD.ChartOfAccounts,
  
      EQMD.FinancialStatementItem,
      EQMD.ConsolidationChartofAccounts,

      @Semantics.currencyCode: 'true'
      EQMD.GroupCurrency,

      //GaapOBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapOpeningBalance,

      //GaapYBLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapMvmnt,

      //GaapEQLC
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapEQ,

      //GaapCTA
      @Semantics.amount.currencyCode: 'GroupCurrency'
      GaapCTA,
      
      cast( case when GaapOpeningBalance is null then GaapMvmnt
                 when GaapMvmnt is null then GaapOpeningBalance
                 else GaapMvmnt + GaapOpeningBalance end as abap.curr(23,2)) as GaapOBYB,
                 
      cast( case when GaapEQ is null then GaapCTA
                 when GaapCTA is null then GaapEQ
                 else GaapCTA + GaapEQ end as abap.curr(23,2)) as GaapEQCTA

}

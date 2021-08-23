@AbapCatalog.sqlViewName: '/EY1/ETRSGCTCBGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-SGAAP-Change in Tax Rate Effect Temp Diff CB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_CTRTDCBPL_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit
  as select from    /EY1/SAV_I_GlAcc_BSEQTE_MD
                 ( p_ryear: $parameters.p_ryear)                  as MasterData

  // Left outer join to map the Transaction Data
    left outer join /EY1/SAV_I_TRF_SGAAP_CB_PL_GC( p_toperiod:$parameters.p_toperiod ,
                    p_ryear: $parameters.p_ryear,
                    p_taxintention: $parameters.p_taxintention) as PLTransactions on  PLTransactions.ConsolidationChartofAccounts = MasterData.ConsolidationChartofAccounts
                                                                                    and PLTransactions.ChartOfAccounts              = MasterData.ChartOfAccounts
                                                                                    and PLTransactions.ConsolidationUnit            = MasterData.ConsolidationUnit
                                                                                    and PLTransactions.GLAccount                    = MasterData.GLAccount
                                                                                    and PLTransactions.FiscalYear                   = MasterData.FiscalYear
  // Left outer join to map Tax Rates
    left outer join /EY1/SAV_I_Get_Tax_Rate
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear: $parameters.p_ryear,
                    p_rbunit: $parameters.p_rbunit)               as TaxRates       on  TaxRates.ConsolidationUnit = MasterData.ConsolidationUnit
                                                                                    and TaxRates.FiscalYear        = MasterData.FiscalYear

{
  key MasterData.ConsolidationChartofAccounts,
  key MasterData.ChartOfAccounts,
  key MasterData.ConsolidationUnit,
  key MasterData.ConsolidationDimension,
  key MasterData.GLAccount,
  key AccountClassCode,
  key MasterData.FiscalYear,
      MasterData.GroupCurrency,
      cast(StatCBDTRate as /ey1/sav_rate)- cast(StatOBDTRate as /ey1/sav_rate) as Rate,
      MultiFactor,


      BsEqPl,
      TaxEffected,


      PlClosingBalance
}
where
  MasterData.ConsolidationUnit = $parameters.p_rbunit

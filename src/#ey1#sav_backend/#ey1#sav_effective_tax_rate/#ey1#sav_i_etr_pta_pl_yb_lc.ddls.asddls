@AbapCatalog.sqlViewName: '/EY1/ETRPTAPLLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-PTA PL Movement LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_PTA_PL_YB_LC
  with parameters
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_rbunit        : fc_bunit,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_PL_MD
                 ( p_ryear: $parameters.p_ryear)                  as MasterData
                 
    left outer join /EY1/SAV_I_ETR_PTA_YB_LC( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention ) as PTA      on  PTA.ConsolidationUnit = MasterData.ConsolidationUnit
                                                                              and PTA.FiscalYear        = MasterData.FiscalYear
                                                                              and PTA.GLAccount         = MasterData.GLAccount

    left outer join /EY1/SAV_I_Get_Tax_Rate( p_toperiod:$parameters.p_toperiod,
                    p_ryear: $parameters.p_ryear,
                    p_rbunit: $parameters.p_rbunit)               as TaxRates on  TaxRates.ConsolidationUnit = MasterData.ConsolidationUnit
                                                                              and TaxRates.FiscalYear        = MasterData.FiscalYear
{
  key  MasterData.ConsolidationChartofAccounts,
  key  MasterData.ChartOfAccounts,
  key  MasterData.ConsolidationUnit,
  key  ConsolidationDimension,
  key  MasterData.GLAccount,
  key  AccountClassCode,

  key  MasterData.FiscalYear,
       MasterData.LocalCurrency,
       BsEqPl,
       ProfitBeforeTax,
       PTAAmount * -1 as PTAAmount,
       CurrentTaxRate as Rate,
       MultiFactor
}
where
  MasterData.ConsolidationUnit = $parameters.p_rbunit

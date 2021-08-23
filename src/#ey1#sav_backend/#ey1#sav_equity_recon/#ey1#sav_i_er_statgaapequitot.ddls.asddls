@AbapCatalog.sqlViewName: '/EY1/ERSTGAEQTO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize ER Stat Gaap Equity Total of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_StatGaapEquiTot
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_ER_StGaEq_NL(p_ryear:$parameters.p_ryear,
                                             p_fromperiod:$parameters.p_fromperiod,
                                             p_toperiod:$parameters.p_toperiod,
                                             p_taxintention: $parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,

      ConsolidationDimension,
      CurrencyType,
      @Semantics.currencyCode: 'true'
      MainCurrency,

      GaapOBBalance+G2SOBBalance as OBBalance,
      G2SPLBalance,
      G2SPMTBalance,
      GaapYBBalance+G2SYBBalance as YBBalance,
      GaapEQBalance+G2SEQBalance as EQBalance,
      G2SOtherBalance,
      GaapCTABalance,
      GaapCBBalance+G2SCBBalance as CBBalance
}

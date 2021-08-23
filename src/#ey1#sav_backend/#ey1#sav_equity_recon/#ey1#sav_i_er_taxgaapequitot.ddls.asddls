@AbapCatalog.sqlViewName: '/EY1/ERTAGAEQTO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize ER Tax Gaap Equity Total of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_TaxGaapEquiTot
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_ER_TAGaEq_NL(p_ryear:$parameters.p_ryear,
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
      
      GaapOBBalance+G2SOBBalance+S2TOBBalance as OBBalance,
      G2SPLBalance+S2TPLBalance               as PLBalance,
      G2SPMTBalance+S2TPMTBalance             as PMTBalance,
      GaapYBBalance+G2SYBBalance+S2TYBBalance as YBBalance,
      GaapEQBalance+G2SEQBalance+S2TEQBalance as EQBalance,
      G2SOtherBalance+S2TOtherBalance         as OtherBalance,
      GaapCTABalance,
      GaapCBBalance+G2SCBBalance+S2TCBBalance as CBBalance
}

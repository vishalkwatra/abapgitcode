@AbapCatalog.sqlViewName: '/EY1/CERSTGAEQTO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View for  ER Stat Gaap Equity Total of values'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ER_StatGaapEqTotal
  with parameters
    p_ryear        : gjahr,
    p_fromperiod   : poper,
    p_toperiod     : poper,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_StatGaapEquiTot( p_ryear:$parameters.p_ryear ,
                                                p_fromperiod:$parameters.p_fromperiod ,
                                                p_toperiod:$parameters.p_toperiod ,
                                                p_taxintention:$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,
      
      @Semantics.currencyCode: true
      MainCurrency,
      
      CurrencyType,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OBBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPLBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPMTBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      YBBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      EQBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SOtherBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      GaapCTABalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      CBBalance
}

@AbapCatalog.sqlViewName: '/EY1/CERG2SDL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View ER G2S Details'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ER_G2S_Details
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_fromperiod   : poper,
    p_switch       : char1
  as select from /EY1/SAV_I_ER_G2S_Details( p_toperiod:$parameters.p_toperiod ,
                                            p_ryear: $parameters.p_ryear,
                                            p_taxintention: $parameters.p_taxintention,
                                            p_fromperiod: $parameters.p_fromperiod,
                                            p_switch:$parameters.p_switch )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,
      @Semantics.currencyCode: true
      MainCurrency
}

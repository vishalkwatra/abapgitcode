@AbapCatalog.sqlViewName: '/EY1/ERG2SDLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S Details LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_Detail_LCGC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_fromperiod   : poper,
    p_switch       : char1

  as select from /EY1/SAV_I_ER_G2STotal(p_toperiod:$parameters.p_toperiod,
                                        p_ryear:$parameters.p_ryear,
                                        p_taxintention: $parameters.p_taxintention)
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
      ConsolidationDimension,

      @Semantics.currencyCode: true
      MainCurrency
}

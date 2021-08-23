@AbapCatalog.sqlViewName: '/EY1/IRGYBNMLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward Normalize Values of YB-LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_RGAAP_YB_NRMLC
  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention  : zz1_taxintention

  as select distinct from /EY1/SAV_I_GlAcc_DTRF_MD
                          ( p_ryear:$parameters.p_ryear )                  as GLAccnt

    left outer join       /EY1/SAV_I_DTRF_RGAAP_YB_PL_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )   as RGaapPl  on  RGaapPl.GLAccount         = GLAccnt.GLAccount
                                                                                       and RGaapPl.FiscalYear        = GLAccnt.FiscalYear
                                                                                       and RGaapPl.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_DTRF_RGAAP_YB_EQ_LC
                    ( p_toperiod :$parameters.p_toperiod,
                           p_ryear:$parameters.p_ryear,
                           p_taxintention :$parameters.p_taxintention )  as RGaapEq  on  RGaapEq.GLAccount         = GLAccnt.GLAccount
                                                                                       and RGaapEq.FiscalYear        = GLAccnt.FiscalYear
                                                                                       and RGaapEq.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_DTRF_RGAAP_YB_OPLLC
                    ( p_toperiod :$parameters.p_toperiod,
                           p_ryear:$parameters.p_ryear,
                           p_taxintention :$parameters.p_taxintention )  as RGaapOPl on  RGaapOPl.GLAccount         = GLAccnt.GLAccount
                                                                                       and RGaapOPl.FiscalYear        = GLAccnt.FiscalYear
                                                                                       and RGaapOPl.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_DTRF_RGAAP_YB_OEQLC
                    ( p_toperiod :$parameters.p_toperiod,
                            p_ryear:$parameters.p_ryear,
                            p_taxintention :$parameters.p_taxintention ) as RGaapOEq on  RGaapOEq.GLAccount         = GLAccnt.GLAccount
                                                                                       and RGaapOEq.FiscalYear        = GLAccnt.FiscalYear
                                                                                       and RGaapOEq.ConsolidationUnit = GLAccnt.ConsolidationUnit


    left outer join       /EY1/SAV_I_Get_Tax_Rate
                    ( p_toperiod:$parameters.p_toperiod ,
                          p_ryear:$parameters.p_ryear ,
                          p_rbunit:$parameters.p_rbunit )                  as TaxRate  on  TaxRate.ConsolidationUnit = $parameters.p_rbunit
                                                                                       and TaxRate.FiscalYear        = $parameters.p_ryear
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      GaapOBDTRate as GaapOBRate,
      GaapCBDTRate as GaapCBRate,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYB * GaapOBDTRate * MultiFactor  as PlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqYB * GaapOBDTRate * MultiFactor  as EqYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYB * GaapOBDTRate * MultiFactor as OPlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OEqYB * GaapOBDTRate * MultiFactor as OEqYearBalance
}

@AbapCatalog.sqlViewName: '/EY1/ISGOBNMLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View DTRF SGAAP Normalize Values of OB-LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_DTRF_SGAAP_OB_NRMLC

  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_DTRF_MD
                 ( p_ryear:$parameters.p_ryear )                     as GLAccnt

    left outer join /EY1/SAV_I_DTRF_SGAAP_OB_PL_LC
                    (
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapPl on  SGaapPl.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapPl.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_DTRF_SGAAP_OB_EQ_LC
                    (
                      p_ryear:$parameters.p_ryear,
                      p_taxintention :$parameters.p_taxintention ) as SGaapEq on  SGaapEq.GLAccount         = GLAccnt.GLAccount
                                                                                and SGaapEq.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join /EY1/SAV_I_Get_Tax_Rate
                    ( p_toperiod:$parameters.p_toperiod ,
                    p_ryear:$parameters.p_ryear ,
                     p_rbunit:$parameters.p_rbunit )                 as TaxRate on  TaxRate.ConsolidationUnit = $parameters.p_rbunit
                                                                                and TaxRate.FiscalYear        = $parameters.p_ryear
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      StatOBDTRate                      as StatOBRate,
      StatCBDTRate                      as StatCBRate,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      EqOB * StatOBDTRate * MultiFactor as EqOpeningBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlOB * StatOBDTRate * MultiFactor as PlOpeningBalance
}

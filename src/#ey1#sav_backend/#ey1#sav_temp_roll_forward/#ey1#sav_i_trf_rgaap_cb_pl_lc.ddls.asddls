@AbapCatalog.sqlViewName: '/EY1/IRGCBPLLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TempRollFwd RGAAP CB for P&L-LC'

@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_CB_PL_LC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
    
   
    
  as select from    /EY1/SAV_I_GlAcc_TRF_MD ( p_ryear:$parameters.p_ryear ) as GLAccnt

    left outer join /EY1/SAV_I_TRF_RGAAP_OB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )            as RGaapOBLC on  RGaapOBLC.GLAccount         = GLAccnt.GLAccount
                                                                                         and RGaapOBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_YB_LC
                    ( p_toperiod :$parameters.p_toperiod,
                          p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention )      as RGaapYBLC on  RGaapYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                         and RGaapYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and RGaapYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_PYA_LC
                    (p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )              as RGaapPYA  on  RGaapPYA.GLAccount         = GLAccnt.GLAccount
                                                                                         and RGaapPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join /EY1/SAV_I_TRF_RGAAP_CTA
                    ( p_toperiod :$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear )                           as RGaapCTA  on  RGaapCTA.GLAccount         = GLAccnt.GLAccount
                                                                                         and RGaapCTA.FiscalYear        = GLAccnt.FiscalYear
                                                                                         and RGaapCTA.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
      //GLAccnt
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,
  key GLAccnt.FiscalYear,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: 'true'
      GLAccnt.LocalCurrency,

      //RGaapOBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlOpeningBalance,

      //RGaapYBLC
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OPlYearBalance,

      //RGaapPYA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAPl,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      PYAOpl,

      //RGaapCTA
      @Semantics.amount.currencyCode: 'LocalCurrency'
      CTAPl,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      PlYearBalance + PlOpeningBalance + OPlYearBalance + PYAPl + PYAOpl + CTAPl as PlClosingBalance
}

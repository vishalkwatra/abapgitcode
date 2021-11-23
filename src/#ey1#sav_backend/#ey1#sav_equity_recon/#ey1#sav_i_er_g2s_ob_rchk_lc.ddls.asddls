@AbapCatalog.sqlViewName: '/EY1/ERG2SOBRKLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S OB Reconciliation Check of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_OB_RChk_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_toyb         : poper,
    p_intention    : zz1_taxintention

  as select from    /EY1/SAV_I_GlAcc_EQ_MD(p_ryear: $parameters.p_ryear)            as GLAccnt

    left outer join /EY1/SAV_I_Rec_STAT_OBNR_LC(p_ryear:$parameters.p_ryear ,
                                              p_periodto: $parameters.p_toyb,
                                              p_taxintention: $parameters.p_taxintention,
                                              p_intention: $parameters.p_intention) as StatOB on  StatOB.GLAccount         = GLAccnt.GLAccount
                                                                                              and StatOB.FiscalYear        = GLAccnt.FiscalYear
                                                                                              and StatOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                              and StatOB.LocalCurrency     = GLAccnt.LocalCurrency
                                                                                              and StatOB.ChartOfAccounts   = GLAccnt.ChartOfAccounts


{
  key GLAccnt.GLAccount,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,

      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,

      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      GLAccnt.ConsolidationChartofAccounts,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      StatOpeningBalance as StatOpeningBalance
}

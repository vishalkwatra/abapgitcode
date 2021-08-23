@AbapCatalog.sqlViewName: '/EY1/CERG2S'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch  ER Gaap2Stat Values'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ER_Gaap2Stat
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_Gaap2Stat(p_toperiod:$parameters.p_toperiod,
                                         p_ryear:$parameters.p_ryear ,
                                         p_taxintention:$parameters.p_taxintention) as G2S

  association [0..1] to /EY1/SAV_I_GlAccText    as _RAcct_Text   on  _RAcct_Text.GLAccount       = G2S.GLAccount
                                                                 and _RAcct_Text.Language        = $session.system_language
                                                                 and _RAcct_Text.ChartOfAccounts = G2S.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_AccClassText as _AccCode_Text on  _AccCode_Text.AccountClassCode = G2S.AccountClassCode
                                                                 and _AccCode_Text.Language         = $session.system_language

  association [0..1] to /EY1/SAV_I_FSItemText   as _FSItem_Text  on  _FSItem_Text.ConsolidationReportingItem   = G2S.financialstatementitem
                                                                 and _FSItem_Text.ConsolidationChartOfAccounts = G2S.ConsolidationChartofAccounts
                                                                 and _FSItem_Text.Language                     = $session.system_language
{
  key ChartOfAccounts,
  
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key ConsolidationUnit,
  
  key ConsolidationChartofAccounts,
  
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key GLAccount,
  
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key AccountClassCode,
  
  key ConsolidationDimension,
  key FiscalYear,
  
      _RAcct_Text.GLAccountMdmText as AccountDescription,
      
      @Semantics.currencyCode: true
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SAdjustAmt,
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SPYA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmtYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SCYABalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqTotalYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      OthrTotalYearBalance,
      @Semantics.amount.currencyCode: 'MainCurrency'
      G2SCTA,
      @Semantics.amount.currencyCode: 'MainCurrency'
      CBYearBalance,

      CurrencyType
}

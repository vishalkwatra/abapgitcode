@AbapCatalog.sqlViewName: '/EY1/CERS2T'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View to fetch  ER Stat2Tax Values'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ER_Stat2Tax
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_ER_Stat2Tax(p_toperiod:$parameters.p_toperiod,
                                        p_ryear:$parameters.p_ryear ,
                                        p_taxintention:$parameters.p_taxintention) as S2T

  association [0..1] to /EY1/SAV_I_GlAccText    as _RAcct_Text   on  _RAcct_Text.GLAccount       = S2T.GLAccount
                                                                 and _RAcct_Text.Language        = $session.system_language
                                                                 and _RAcct_Text.ChartOfAccounts = S2T.ChartOfAccounts

  association [0..1] to /EY1/SAV_I_AccClassText as _AccCode_Text on  _AccCode_Text.AccountClassCode = S2T.AccountClassCode
                                                                 and _AccCode_Text.Language         = $session.system_language

  association [0..1] to /EY1/SAV_I_FSItemText   as _FSItem_Text  on  _FSItem_Text.ConsolidationReportingItem   = S2T.financialstatementitem
                                                                 and _FSItem_Text.ConsolidationChartOfAccounts = S2T.ConsolidationChartofAccounts
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
      S2TAdjustAmt,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TPYA,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      PlYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      PmtYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TCYABalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      EqTotalYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      OthrTotalYearBalance,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      S2TCTA,
      
      @Semantics.amount.currencyCode: 'MainCurrency'
      CBYearBalance,

      CurrencyType
}

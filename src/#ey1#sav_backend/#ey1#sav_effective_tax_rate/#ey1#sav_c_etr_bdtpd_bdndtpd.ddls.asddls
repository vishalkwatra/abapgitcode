@AbapCatalog.sqlViewName: '/EY1/CETRBDNTCPD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View-ETR-BDTPD-Diff for whch no Def tax is cal- PermDiff'
@Search.searchable: true
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_ETR_BDTPD_BDNDTPD
  with parameters
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit,
    p_intention     : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_BDTPD_BDNDTPD ( p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,
                 p_ryear: $parameters.p_ryear, p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention, p_rbunit: $parameters.p_rbunit,
                 p_intention: $parameters.p_intention) as DDCTR

  association [0..1] to /EY1/SAV_I_GlAccText as _RAcct_Text on  _RAcct_Text.GLAccount       = DDCTR.GLAccount
                                                            and _RAcct_Text.Language        = $session.system_language
                                                            and _RAcct_Text.ChartOfAccounts = DDCTR.ChartOfAccounts

{
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key ConsolidationUnit,

  key ConsolidationDimension,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key GLAccount,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
  key AccountClassCode,

  key FiscalYear,

      _RAcct_Text.GLAccountMdmText as AccountDescription,

      ConsolidationLedger,

      @Semantics.currencyCode: true
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Amount,

      Rate,

      @Semantics.amount.currencyCode: 'MainCurrency'
      Tax,

      Percentage,

      CurrencyType,
      ReportingType
}

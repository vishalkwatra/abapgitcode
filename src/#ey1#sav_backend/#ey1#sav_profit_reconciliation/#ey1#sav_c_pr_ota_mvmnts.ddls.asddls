@AbapCatalog.sqlViewName: '/EY1/CPRSECOTA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'C-View - Profit Recon - OTA Mvmnt'
@VDM.viewType: #CONSUMPTION

define view /EY1/SAV_C_PR_OTA_Mvmnts 
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_PR_OTA_Mvmnt
                 ( p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention) as OTA

  association [0..1] to /EY1/SAV_I_GlAccText as _RAcct_Text on  _RAcct_Text.GLAccount       = OTA.GLAccount
                                                            and _RAcct_Text.Language        = $session.system_language
                                                            and _RAcct_Text.ChartOfAccounts = OTA.ChartOfAccounts


{
     
  key ChartOfAccounts,
     
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key FiscalYear,
     
      @EndUserText.label: 'Account'
  key GLAccount,
      @Consumption.semanticObject: 'AccountClass'
     
      @EndUserText.label: 'Acct Class'
  key AccountClassCode,
      ConsolidationDimension,
      @EndUserText.label: 'Account Description'
     
      _RAcct_Text.GLAccountMdmText,

      @Semantics.currencyCode: 'true'
      @EndUserText.label: 'CCY'
      MainCurrency,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OTATransactionsPL,

      @Semantics.amount.currencyCode: 'MainCurrency'
      OTATransactionsPmnt,

      @Semantics.amount.currencyCode: 'MainCurrency'
      TransactionTotal,

      CurrencyType,

      _RAcct_Text
}

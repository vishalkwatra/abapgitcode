@AbapCatalog.sqlViewName: '/EY1/GLPROFITRMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View for Profit Recon Master Data'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_GlAcc_ProfitRec_MD
  with parameters
    p_ryear : gjahr
  as select distinct from /EY1/SAV_I_GlAccCUnit     as GLAccnt
    left outer join       acdocu                                     on  acdocu.racct = GLAccnt.GLAccount
                                                                     and acdocu.ryear = :p_ryear
                                                                     and acdocu.ktopl = GLAccnt.ktopl
    left outer join       /EY1/SAV_I_Accounts_Class as AccountsClass on GLAccnt.AccountClassCode = AccountsClass.acc_class_code
{
      // GLAccnt
  key GLAccount,
  key AccountClassCode,
      // acdocu
  key rdimen                   as ConsolidationDimension,
  key ryear                    as FiscalYear,

      FinancialStatementItem,
      acdocu.ktopl             as ChartOfAccounts,
      rbunit                   as ConsolidationUnit,
      @Semantics.currencyCode: true
      rhcur                    as LocalCurrency,
      @Semantics.currencyCode: true
      rkcur                    as GroupCurrency,
      ritclg                   as ConsolidationChartofAccounts,

      AccountsClass.bl_eq_pl   as BsEqPl,
      AccountsClass.profit     as ProfitBeforeTax,
      AccountsClass.tax_effect as TaxEffected
}

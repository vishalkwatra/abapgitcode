@AbapCatalog.sqlViewName: '/EY1/GLGAAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account Consolidation Unit - Gaap'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Rec_GlAcCUnit_GAAP
  with parameters
  p_ryear: gjahr
  as select from    /EY1/SAV_I_GlAccCUnit as glaccnt
    left outer join /EY1/SAV_I_Rec_GAAP(p_ryear: $parameters.p_ryear)   as acdocu on  acdocu.GLAccount = glaccnt.GLAccount
                                                    and acdocu.ktopl     = glaccnt.ktopl

{
  key glaccnt.GLAccount,
  key glaccnt.AccountClassCode,
  key ConsolidationLedger,
  key ConsolidationDimension,
  key FiscalYear,
  key acdocu.ConsolidationChartOfAccounts,
      ConsolidationUnit,
      glaccnt.FinancialStatementItem,
      acdocu.ChartOfAccounts,
      LocalCurrency,
      GroupCurrency,
      TransactionCurrency,

      cast(cast(FiscalYear as abap.dec( 4, 0 )) - 1 as abap.char( 7 )) as PriorYear
}

@AbapCatalog.sqlViewName: '/EY1/GLACCSTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account Consolidation Unit - STAT'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Rec_GlAccCUnit_STAT
  as select from    /EY1/SAV_I_GlAccCUnit as glaccnt
    left outer join /EY1/SAV_I_Rec_STAT   as acdocu on acdocu.GLAccount = glaccnt.GLAccount
{

  key glaccnt.GLAccount,
  key glaccnt.AccountClassCode,
  key ConsolidationLedger,
  key ConsolidationDimension,
  key FiscalYear,
      ConsolidationUnit,
      glaccnt.FinancialStatementItem,
      acdocu.ChartOfAccounts,
      LocalCurrency,
      GroupCurrency,
      TransactionCurrency,

      cast(cast(FiscalYear as abap.dec( 4, 0 )) - 1 as abap.char( 7 )) as PriorYear
}

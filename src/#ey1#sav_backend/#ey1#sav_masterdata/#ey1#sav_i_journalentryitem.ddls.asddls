@AbapCatalog.sqlViewName: '/EY1/SAVJRLENTIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I view for JournalEntryItem'
define view /EY1/SAV_I_JournalEntryItem
  as select from E_JournalEntryItem as E_JrnlEntry
    inner join   /EY1/SAV_I_ReadIntentVH as TaxIntentionText on E_JrnlEntry.ZZ1_TaxIntention_COB = TaxIntentionText.TaxIntention
{
      //E_JournalEntryItem
  key E_JrnlEntry.SourceLedger,
  key E_JrnlEntry.CompanyCode,
  key E_JrnlEntry.FiscalYear,
  key E_JrnlEntry.AccountingDocument,
  key E_JrnlEntry.LedgerGLLineItem,
      //TaxIntentionText
      //key Intent,
      //key SerialNumber,
      //      ZZ1_TaxIntention_COB,
      //      ZZ1_LedgerGroup_COB,
      IntentDescription,
      //PeriodTo,
      //TaxIntention,
      // AnalyticsPeriodTo,
      /* Associations */
      //E_JournalEntryItem
      E_JrnlEntry.ZZ1_LedgerGroup_COB,     
      E_JrnlEntry.ZZ1_TaxIntention_COB
}

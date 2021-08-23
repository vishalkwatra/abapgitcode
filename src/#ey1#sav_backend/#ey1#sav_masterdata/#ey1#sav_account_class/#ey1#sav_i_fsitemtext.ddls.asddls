@AbapCatalog.sqlViewName: '/EY1/FSITEMTEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - View FS ItemText'
//@ObjectModel.dataCategory: #TEXT


define view /EY1/SAV_I_FSItemText
  as select from fincs_fsitemt
{
      //fincs_fsitemt
//      @Semantics.language: true
  key langu as Language,
  key itclg as ConsolidationChartOfAccounts,
//  @ObjectModel.text.element: ['ConsolidationRptgItemMdmText']
  key item  as ConsolidationReportingItem,
      txtsh as ConsolidationReportingItemText,
//      @Semantics.text: true
      txtmi as ConsolidationRptgItemMdmText,
      txtlg as ConsolidationRptgItemLngText
}

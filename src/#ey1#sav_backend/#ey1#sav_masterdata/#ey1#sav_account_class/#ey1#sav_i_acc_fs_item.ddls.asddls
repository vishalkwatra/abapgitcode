@AbapCatalog.sqlViewName: '/EY1/FSITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for FS Item'

@ObjectModel: {
                transactionalProcessingEnabled: true,
                updateEnabled: 'EXTERNAL_CALCULATION',
                createEnabled: true,
                deleteEnabled: 'EXTERNAL_CALCULATION',
                semanticKey: ['AccountClassCode', 'ConsolidationChartOfAccounts' , 'FinancialStatementItem'],
                writeDraftPersistence: '/EY1/FS_ITEM_D'}

define view /EY1/SAV_I_Acc_FS_Item
  as select from /EY1/SAV_I_FinancialStatItem
  association [1..1] to /EY1/SAV_I_Acc_Class as _Acc_Class on $projection.AccountClassCode = _Acc_Class.AccountClassCode
{

      @ObjectModel.readOnly:true
  key account_classcode as AccountClassCode,


      @ObjectModel.readOnly:true
  key itclg             as ConsolidationChartOfAccounts,


      @ObjectModel.readOnly:true
  key item              as FinancialStatementItem,



      account_classcode as AccountClassCodeForEdit,

      @ObjectModel:{ readOnly: 'EXTERNAL_CALCULATION',
                   editableFieldFor: 'ConsolidationChartOfAccounts' }
      @ObjectModel.mandatory: true
      itclg             as ConsolidationCOAForEdit,


      @ObjectModel:{ readOnly: 'EXTERNAL_CALCULATION',
                   editableFieldFor: 'FinancialStatementItem' }
      @ObjectModel.mandatory: true
      item              as FinancialStatementItemForEdit,



      @ObjectModel: { association: { type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT] } }
      _Acc_Class
}

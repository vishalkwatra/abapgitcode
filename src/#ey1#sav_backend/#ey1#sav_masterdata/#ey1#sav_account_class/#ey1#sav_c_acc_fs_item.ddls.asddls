@AbapCatalog.sqlViewName: '/EY1/CFSITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Consumption view for FS Item'

@VDM.viewType: #CONSUMPTION

@Metadata.allowExtensions: true

@ObjectModel: { semanticKey:   ['AccountClassCode', 'ConsolidationChartOfAccounts', 'FinancialStatementItem'],
                updateEnabled:   #('EXTERNAL_CALCULATION'),
                createEnabled: true,
                deleteEnabled:   #('EXTERNAL_CALCULATION') }

@UI.headerInfo: { typeName:         'FS Item',
                  typeNamePlural:   'FS Items',
                  title:            { value: 'FinancialStatementItemForEdit' },
                  description:       {value: 'ConsolidationCOAForEdit'} }


define view /EY1/SAV_C_Acc_FS_Item
  as select from /EY1/SAV_I_Acc_FS_Item
  association [1..1] to /EY1/SAV_C_Acc_Class                 as _AccClass                   on $projection.AccountClassCode = _AccClass.AccountClassCode

  association [0..*] to C_CnsldtnFSItemInclRptgItemVH as _CnsldtnFSItemInclRptgItemVH on $projection.ConsolidationCOAForEdit = _CnsldtnFSItemInclRptgItemVH.ConsolidationChartOfAccounts

  association [1..1] to C_CnsldtnChartOfAccountsVH    as _ChartOfAccountsVH           on $projection.ConsolidationCOAForEdit = _ChartOfAccountsVH.ConsolidationChartOfAccounts
{

      @UI.facet:[
          {
              id:'FSItemInfo',
              type: #COLLECTION,
              position: 10,
              label: 'FS Item Information'
          },
          {
              type: #FIELDGROUP_REFERENCE,
              position: 10,
              targetQualifier: 'FSItemInformation',
              parentId: 'FSItemInfo',
              isSummary: true,
              isPartOfPreview: true
          }
      ]



      @ObjectModel.readOnly:true
      @UI.hidden: true
  key AccountClassCode,

      @ObjectModel.readOnly:true
      @UI.hidden: true
  key ConsolidationChartOfAccounts,

      @ObjectModel.readOnly:true
      @UI.hidden: true
  key FinancialStatementItem,

      //            @UI.lineItem: [{ position: 10 }]
      //      @UI.hidden: true
      //      account_classcodeForEdit,



      @UI.lineItem: [{ position: 10 }]
    //  @UI.fieldGroup: [{ qualifier: 'FSItemInformation', position: 10,importance: #HIGH }]
      @Consumption.valueHelpDefinition.entity: {
        name:'C_CnsldtnChartOfAccountsVH',
        element:'ConsolidationChartOfAccounts'
      }
      @ObjectModel.text.element: [ 'ConsolidationChartOfAcctsText' ]
      ConsolidationCOAForEdit,

      @UI.lineItem: [{ position: 20 }]
    //  @UI.fieldGroup: [{ qualifier: 'FSItemInformation', position: 20,importance: #HIGH }]
      @Consumption.valueHelpDefinition: {
        entity:{
          name:'C_CnsldtnFSItemInclRptgItemVH',
          element:'FinancialStatementItem'},
        additionalBinding: [
          {localElement: 'ConsolidationCOAForEdit',
          element: 'ConsolidationCOAForEdit',
          usage: #FILTER }
        ]
      }
      FinancialStatementItemForEdit,

      @ObjectModel.readOnly:true
      @EndUserText: {
        label: 'Consolidation Chart of Accounts Desc.',
        quickInfo: 'Consolidation Chart of Accounts Description'
      }
      _ChartOfAccountsVH.ConsolidationChartOfAcctsText,

      @ObjectModel.association: { type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT] }
      _AccClass,

      _CnsldtnFSItemInclRptgItemVH
}

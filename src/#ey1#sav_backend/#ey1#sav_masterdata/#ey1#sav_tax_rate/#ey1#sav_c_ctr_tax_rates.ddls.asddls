@AbapCatalog.sqlViewName: '/EY1/CTAXRATES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Consumption view for Country Tax Rates'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true

@ObjectModel: { compositionRoot:                  true,
                transactionalProcessingDelegated: true,
                semanticKey:                      ['rbunit', 'gjahr', 'intention'],
                createEnabled:                    #('EXTERNAL_CALCULATION'),
                updateEnabled:                    #('EXTERNAL_CALCULATION'),
                deleteEnabled:                    #('EXTERNAL_CALCULATION'),
                draftEnabled:                     true }

@UI.headerInfo: { typeName:         'Manage Tax Rate',
                  typeNamePlural:   'Manage Tax Rates',
                  title:            { value: 'rbunitForEdit' } }

define view /EY1/SAV_C_CTR_Tax_Rates
  as select from /EY1/SAV_I_CTR_Tax_Rate
  association [1..1] to I_CnsldtnUnitT   as _CnsldtnUnitText on  $projection.rbunitForEdit = _CnsldtnUnitText.ConsolidationUnit
                                                             and _CnsldtnUnitText.Language = $session.system_language
  association [1..1] to /EY1/I_ReadIntentVH as _IntentVH        on  $projection.intentionForEdit = _IntentVH.IntentionDomVal

{
      //Z_I_CTR_TAX_RATES

      @UI.facet:[ { id:              'TaxInfo',
                    type:            #COLLECTION,
                    position:         10,
                    label:           'Tax Information' },

                  { type:             #FIELDGROUP_REFERENCE,
                    position:         10,
                    label:           'Basic Information',
                    targetQualifier: 'BasicInformation',
                    parentId:        'TaxInfo',
                    isSummary:        true,
                    isPartOfPreview:  true },


                 { type:            #FIELDGROUP_REFERENCE,
                    position:        20,
                    label:           'User Data',
                    targetQualifier: 'UserInfo',
                    parentId:        'TaxInfo',
                    isSummary:        true,
                    hidden: false,
                    importance: #HIGH,
                    isPartOfPreview:  true } ]

      @ObjectModel.readOnly:true
      @UI.hidden: true
  key rbunit,

      @ObjectModel.readOnly:true
      @UI.dataPoint: { title: 'Fiscal Year'}
  key gjahr,

      @Consumption.valueHelpDefinition: { entity: { name: 'Z_I_ReadIntentVH', element: 'IntentionDomVal' } }
      @ObjectModel.text.element:        ['IntentionDomText']
      @ObjectModel.readOnly:true
//      @UI.dataPoint: { title: 'Intention' }
  key intention,

//      @ObjectModel.readOnly:true
//      @UI.dataPoint: { title: 'Intention'}
//      concat(concat(concat(_IntentVH.IntentionDomText, ' ('), intention), ')') as intentionText,
//       concat(_IntentVH.IntentionDomText, intention) as intentionText,

      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 10 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 10 }]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @Consumption.valueHelpDefinition: { entity: { name:    'C_CnsldtnUnitValueHelp', element: 'ConsolidationUnit' } }
      @ObjectModel.text.element: ['ConsolidationUnitMdmText']
      rbunitForEdit,

      @UI.hidden: true
      @ObjectModel.readOnly:true
      _CnsldtnUnitText.ConsolidationUnitMdmText,

      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 20 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 20 }]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @Semantics.fiscal.year: true
      @EndUserText.label:'Fiscal Year'
      gjahrForEdit,

      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 30 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 30}]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @Consumption.valueHelpDefinition: { entity: { name: 'Z_I_ReadIntentVH', element: 'IntentionDomVal' } }
      @ObjectModel.text.element:        ['IntentionDomText']
      intentionForEdit,

      //    Current TAX
      @UI.hidden: true
      current_tax_rate,


      @EndUserText.label: 'Current Tax Rate'
      @UI.lineItem: [{ position: 40 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 40}]
      @ObjectModel.mandatory: true
      current_tax_rateForEdit,

      //    GAAP OB
      @UI.hidden: true
      @ObjectModel.readOnly:true
      gaap_ob_dt_rate,

      @UI.lineItem: [{ position: 50 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 50 }]
      @EndUserText.label:'GAAP OB DT Rate'
      @ObjectModel.readOnly:true
      gaap_ob_dt_rateForEdit,

      //    GAAP CB
      @UI.hidden: true
      gaap_cb_dt_rate,

      @UI.lineItem: [{ position: 60 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 60,importance: #HIGH }]
      @EndUserText.label:'GAAP CB DT Rate'
      gaap_cb_dt_rateForEdit,

      //    STAT OB
      @UI.hidden: true
      @ObjectModel.readOnly:true
      stat_ob_dt_rate,

      @UI.lineItem: [{ position: 70 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 70,importance: #HIGH }]
      @EndUserText.label:'STAT OB DT Rate'
      @ObjectModel.readOnly:true
      stat_ob_dt_rateForEdit,

      //    STAT CB
      @UI.hidden: true
      stat_cb_dt_rate,

      @UI.lineItem: [{ position: 80 }]
      @UI.fieldGroup: [{ qualifier: 'BasicInformation', position: 80,importance: #HIGH }]
      @EndUserText.label:'STAT CB DT Rate'
      stat_cb_dt_rateForEdit,

      @UI.fieldGroup: [{ qualifier: 'UserInfo', position: 10, importance: #HIGH }]
      @EndUserText.label:'Created by'
      created_by,

      @UI.fieldGroup: [{ qualifier: 'UserInfo', position: 20, importance: #HIGH }]
      @EndUserText.label:'Created on'
      created_on,

      @UI.fieldGroup: [{ qualifier: 'UserInfo', position: 30, importance: #HIGH }]
      @EndUserText.label:'Changed by'
      changed_by,

      @UI.fieldGroup: [{ qualifier: 'UserInfo', position: 40, importance: #HIGH }]
      @EndUserText.label:'Changed on'
      changed_on,

      @UI.dataPoint: { title: 'Intention'}
 //     @UI.hidden: true
      @ObjectModel.readOnly:true
      _IntentVH.IntentionDomText,

      _CnsldtnUnitText,
      _IntentVH

}

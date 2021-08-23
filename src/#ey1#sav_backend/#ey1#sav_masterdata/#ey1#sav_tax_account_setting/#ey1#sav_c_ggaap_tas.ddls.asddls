@AbapCatalog.sqlViewName: '/EY1/CGGAAP_TAS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Consumption View of Group GAAP Tax Account Settings'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true

@ObjectModel: { compositionRoot:                   true,
                transactionalProcessingDelegated:  true,
                semanticKey:                       ['ConsolidationGroup'],
                createEnabled:                     #('EXTERNAL_CALCULATION'),
                updateEnabled:                     #('EXTERNAL_CALCULATION'),
                deleteEnabled:                     #('EXTERNAL_CALCULATION'),
                draftEnabled:                      true }

@UI.headerInfo: { typeName:         'Tax Accounting Settings',
                  typeNamePlural:   'Group GAAP Tax Accounting Settings',
                  title:            {type: #STANDARD, value: 'ConsolidationGroupForEdit' },
                  description:      {value: 'ConsolidationGroupMediumText'} }

define view /EY1/SAV_C_GGAAP_TAS
  as select from /EY1/SAV_I_GGAAP_TAS

  association [0..*] to /EY1/SAV_C_SGAAP_TAS          as _SGAAP                  on  $projection.ConsolidationGroup = _SGAAP.ConsolidationGroup

  association [1..1] to I_CnsldtnGroupT               as _ConsolidationGroupText on  $projection.ConsolidationGroup   = _ConsolidationGroupText.ConsolidationGroup
                                                                                 and _ConsolidationGroupText.Language = $session.system_language

  association [1..1] to /EY1/SAV_I_CLASSIFICATION_VH  as _Classification         on  $projection.Classification = _Classification.Classification

  association [1..1] to /EY1/SAV_I_TaxRateChange_VH   as _TaxRateChange          on  $projection.TaxRateChange = _TaxRateChange.TaxRateChange

  association [1..1] to /EY1/SAV_I_DTARecognition_VH  as _DTARecognition         on  $projection.DTARecongnition = _DTARecognition.DTARecognition

  association [1..1] to /EY1/SAV_I_DTICElimination_VH as _DTICElimination        on  $projection.DTIntracompanyElimination = _DTICElimination.DTIntracompanyElimination

{

      @UI.facet:[ { id:              'GroupInfo',
                    type:            #COLLECTION,
                    position:        10,
                    label:           'Group GAAP' },

                  { type:            #FIELDGROUP_REFERENCE,
                    position:        10,
                    targetQualifier: 'GroupGAAP',
                    parentId:        'GroupInfo',
                    isSummary:       true,
                    isPartOfPreview: true },

                  { type:             #LINEITEM_REFERENCE ,
                    label:            'Statutory GAAP' ,
                    position:          20 ,
                    targetElement:    '_SGAAP' } ]

      ///EY1/SAV_I_GGAAP_TAS
      @ObjectModel.readOnly:true
      @UI.hidden: true
  key ConsolidationGroup,

      @UI.selectionField:   [{ position: 10 }]
      @UI.lineItem:         [{ position: 10 }]
      @ObjectModel.text.element: ['ConsolidationGroupMediumText']
      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 10 }]
      @Search:              { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      @Consumption.valueHelpDefinition.entity: { name:'C_CnsldtnGroupAllVH', element:'ConsolidationGroup' }
      ConsolidationGroupForEdit,

      @UI.lineItem:         [{ position: 20 }]
      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 20 }]
      @EndUserText: { label: 'Description' }
      @UI.hidden: true
      @ObjectModel.readOnly:true
      ConsolidationGroupMediumText,

      @UI.lineItem: [{ position: 30 }]
      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 30 }]
      //      @Consumption.valueHelp: '_Classification'
      @ObjectModel.foreignKey.association: '_Classification'
      @EndUserText.label: 'Classification'
      Classification,

      @UI.lineItem: [{ position: 40 }]
      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 40 }]
      //      @Consumption.valueHelp: '_TaxRateChange'
      @ObjectModel.foreignKey.association: '_TaxRateChange'
      @EndUserText.label: 'Change in Tax Rate'
      TaxRateChange,

      @UI.lineItem: [{ position: 50 }]
      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 50 }]
      //      @Consumption.valueHelp: '_DTARecognition'
      @ObjectModel.foreignKey.association: '_DTARecognition'
      @EndUserText.label: 'DTA Recognition'
      DTARecongnition,

      @UI.lineItem: [{ position: 60 }]
      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 60 }]
      //      @Consumption.valueHelp: '_DTICElimination'
      @ObjectModel.foreignKey.association: '_DTICElimination'
      @EndUserText.label: 'Deferred Tax Intracompany Eliminations'
      DTIntracompanyElimination,

      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 70 }]
      @EndUserText.label:'Created by'
      CreatedBy,

      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 80 }]
      @EndUserText.label:'Created on'
      CreatedOn,

      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 90 }]
      @EndUserText.label:'Changed by'
      ChangedBy,

      @UI.fieldGroup: [{ qualifier: 'GroupGAAP', position: 100 }]
      @EndUserText.label:'Changed on'
      ChangedOn,

      /* Associations */

      @ObjectModel.association: { type: [#TO_COMPOSITION_CHILD] }
      _SGAAP,

      _Classification,
      _DTARecognition,
      _DTICElimination,
      _TaxRateChange

}

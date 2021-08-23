@AbapCatalog.sqlViewName: '/EY1/CSGAAP_TAS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Consumption View of Statutory GAAP Tax Account Settings'
@VDM.viewType: #CONSUMPTION

@Metadata.allowExtensions: true

@ObjectModel: { semanticKey:     ['ConsolidationGroup', 'ConsolidationUnit'],
                updateEnabled:   #('EXTERNAL_CALCULATION'),
                createEnabled:   true,
                deleteEnabled:   #('EXTERNAL_CALCULATION') }

@UI.headerInfo: { typeName:         'Statutory GAAP',
                  typeNamePlural:   'Statutory GAAP',
                  title:            { value: 'ConsolidationUnitForEdit' },
                  description:      {value: 'ConsolidationUnitText'} }

define view /EY1/SAV_C_SGAAP_TAS
  as select from /EY1/SAV_I_SGAAP_TAS

  association [0..1] to /EY1/SAV_C_GGAAP_TAS          as _GGAAP                  on  $projection.ConsolidationGroup = _GGAAP.ConsolidationGroup

  association [1..1] to I_CnsldtnGroupT               as _ConsolidationGroupText on  $projection.ConsolidationGroup   = _ConsolidationGroupText.ConsolidationGroup
                                                                                 and _ConsolidationGroupText.Language = $session.system_language

  association [1..1] to I_CnsldtnUnitT                as _CnsldtnUnitText        on  $projection.ConsolidationUnitForEdit = _CnsldtnUnitText.ConsolidationUnit
                                                                                 and _CnsldtnUnitText.Language            = $session.system_language

  association [1..1] to /EY1/SAV_I_CLASSIFICATION_VH  as _Classification         on  $projection.Classification = _Classification.Classification

  association [1..1] to /EY1/SAV_I_TaxRateChange_VH   as _TaxRateChange          on  $projection.TaxRateChange = _TaxRateChange.TaxRateChange

  association [1..1] to /EY1/SAV_I_DTARecognition_VH  as _DTARecognition         on  $projection.DTARecognition = _DTARecognition.DTARecognition

  association [1..1] to /EY1/SAV_I_DTICElimination_VH as _DTICElimination        on  $projection.DTIntracompanyElimination = _DTICElimination.DTIntracompanyElimination

{
      @UI.facet:[ { id:       'SGAAPId',
                    type:     #COLLECTION,
                    position: 10,
                    label:    'Statutory GAAP' },

                  { type:            #FIELDGROUP_REFERENCE,
                    position:        10,
                    targetQualifier: 'StatutoryGAAP',
                    parentId:        'SGAAPId',
                    isSummary:       true,
                    isPartOfPreview: true } ]

      ///EY1/SAV_I_SGAAP_TAS
      @ObjectModel.readOnly:true
      @UI.hidden: true
  key ConsolidationGroup,

      @ObjectModel.readOnly:true
      @UI.hidden: true
  key ConsolidationUnit,

      @UI.lineItem: [{ position: 10 }]
      @ObjectModel.text.element: [ 'ConsolidationGroupText' ]
      @UI.hidden: true
      @Consumption.valueHelpDefinition.entity: { name:'C_CnsldtnGroupAllVH', element:'ConsolidationGroup' }
      ConsolidationGroupForEdit,

      @UI.lineItem: [{ position: 20 }]
      @ObjectModel.readOnly:true
      @UI.hidden: true
      @EndUserText: { label: 'Description' }
      _ConsolidationGroupText.ConsolidationGroupText,

      @UI.lineItem: [{ position: 30 }]
      @Consumption.valueHelpDefinition.entity: { name:'C_CnsldtnUnitValueHelp', element:'ConsolidationUnit' }
      ConsolidationUnitForEdit,

      @UI.lineItem: [{ position: 40 }]
      @ObjectModel.readOnly:true
      @EndUserText: { label: 'Description' }
      _CnsldtnUnitText.ConsolidationUnitText,

      @UI.lineItem: [{ position: 50 }]
      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_CLASSIFICATION_VH',
                                                    element: 'Classification' } }
      @ObjectModel.text.element: [ 'Classification']
      @UI.textArrangement: #TEXT_ONLY
      Classification,

      @UI.lineItem: [{ position: 60 }]
      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_TAXRATECHANGE_VH',
                                                    element: 'TaxRateChange' } }
      @ObjectModel.text.element: [ 'TaxRateChange']
      @UI.textArrangement: #TEXT_ONLY
      TaxRateChange,

      @UI.lineItem: [{ position: 70 }]
      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_DTARECOGNITION_VH',
                                                    element: 'DTARecognition' } }
      @ObjectModel.text.element: [ 'DTARecognition']
      @UI.textArrangement: #TEXT_ONLY
      DTARecognition,

      @UI.lineItem: [{ position: 80 }]
      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_DTICELIMINATION_VH',
                                                    element: 'DTIntracompanyElimination' } }
      @ObjectModel.text.element: [ 'DTIntracompanyElimination']
      @UI.textArrangement: #TEXT_ONLY
      DTIntracompanyElimination,

      @UI.lineItem: [{ position: 90 }]
      @EndUserText.label:'Created by'
      CreatedBy,

      @UI.lineItem: [{ position: 100 }]
      @EndUserText.label:'Created on'
      CreatedOn,

      @UI.lineItem: [{ position: 110 }]
      @EndUserText.label:'Changed by'
      ChangedBy,

      @UI.lineItem: [{ position: 120 }]
      @EndUserText.label:'Changed on'
      ChangedOn,

      /* Associations */
      @ObjectModel.association: { type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT] }
      _GGAAP,

      _Classification,
      _TaxRateChange,
      _DTARecognition,
      _DTICElimination
}

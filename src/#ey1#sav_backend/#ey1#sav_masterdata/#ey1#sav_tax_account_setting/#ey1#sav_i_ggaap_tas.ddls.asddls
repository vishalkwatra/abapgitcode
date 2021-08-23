@AbapCatalog.sqlViewName: '/EY1/GGAAPTAS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Interface View for Group GAAP Tax Account Settings'
@VDM.viewType: #TRANSACTIONAL

@ObjectModel: { compositionRoot:                true,
                modelCategory:                  #BUSINESS_OBJECT,
                transactionalProcessingEnabled: true,
                createEnabled:                 'EXTERNAL_CALCULATION',
                updateEnabled:                 'EXTERNAL_CALCULATION',
                deleteEnabled:                 'EXTERNAL_CALCULATION',
                semanticKey:                   'ConsolidationGroup',
                draftEnabled:                   true,
                writeDraftPersistence:          '/EY1/GGAAP_TAS_D' }

define view /EY1/SAV_I_GGAAP_TAS
  as select from /ey1/ggaap_tas

  association [0..*] to /EY1/SAV_I_SGAAP_TAS          as _SGAAP                  on  $projection.ConsolidationGroup = _SGAAP.ConsolidationGroup

  association [1..1] to I_CnsldtnGroupT               as _ConsolidationGroupText on  $projection.ConsolidationGroup   = _ConsolidationGroupText.ConsolidationGroup
                                                                                 and _ConsolidationGroupText.Language = $session.system_language

  association [1..1] to /EY1/SAV_I_CLASSIFICATION_VH  as _Classification         on  $projection.Classification = _Classification.Classification

  association [1..1] to /EY1/SAV_I_TaxRateChange_VH   as _TaxRateChange          on  $projection.TaxRateChange = _TaxRateChange.TaxRateChange

  association [1..1] to /EY1/SAV_I_DTARecognition_VH  as _DTARecognition         on  $projection.DTARecongnition = _DTARecognition.DTARecognition

  association [1..1] to /EY1/SAV_I_DTICElimination_VH as _DTICElimination        on  $projection.DTIntracompanyElimination = _DTICElimination.DTIntracompanyElimination

{ //EY1/GGAAP_TAS
      @ObjectModel.readOnly:true
  key rcongr          as ConsolidationGroup,

      @ObjectModel:{ readOnly:         'EXTERNAL_CALCULATION',
                     editableFieldFor: 'ConsolidationGroup' }
      @ObjectModel.mandatory: true
      rcongr          as ConsolidationGroupForEdit,

      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      _ConsolidationGroupText.ConsolidationGroupMediumText,

      @ObjectModel.mandatory: true
      classification  as Classification,

      @ObjectModel.mandatory: true
      tax_rate_change as TaxRateChange,

      @ObjectModel.mandatory: true
      dta_recognition as DTARecongnition,

      @ObjectModel.mandatory: true
      dtice           as DTIntracompanyElimination,

      @ObjectModel.readOnly: true
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,

      @ObjectModel.readOnly: true
      @Semantics.systemDateTime.createdAt: true
      created_on      as CreatedOn,

      @ObjectModel.readOnly:  true
      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      @Semantics.user.lastChangedBy: true
      changed_by      as ChangedBy,

      @ObjectModel.readOnly:  true
      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      @Semantics.systemDateTime.lastChangedAt: true
      changed_on      as ChangedOn,

      //Associations
      @ObjectModel: { association: { type: [#TO_COMPOSITION_CHILD] } }
      _SGAAP,

      _Classification,
      _TaxRateChange,
      _DTARecognition,
      _DTICElimination
}

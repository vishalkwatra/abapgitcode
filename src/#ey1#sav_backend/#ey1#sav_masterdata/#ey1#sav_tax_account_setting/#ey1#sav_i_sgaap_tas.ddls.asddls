@AbapCatalog.sqlViewName: '/EY1/SGAAPTAS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Statutory GAAP Tax Account Settings'

@ObjectModel: { transactionalProcessingEnabled: true,
                updateEnabled:                  'EXTERNAL_CALCULATION',
                createEnabled:                  true,
                deleteEnabled:                  'EXTERNAL_CALCULATION',
                semanticKey:                    ['ConsolidationGroup', 'ConsolidationUnit'],
                writeDraftPersistence:          '/EY1/SGAAP_TAS_D'}

define view /EY1/SAV_I_SGAAP_TAS
  as select from /ey1/sgaap_tas
  association [1..1] to /EY1/SAV_I_GGAAP_TAS as _GGAAP on $projection.ConsolidationGroup = _GGAAP.ConsolidationGroup

{ //EY1/SGAAP_TAS
      @ObjectModel.readOnly:true
  key rcongr          as ConsolidationGroup,

      @ObjectModel.readOnly:true
  key bunit           as ConsolidationUnit,

      rcongr          as ConsolidationGroupForEdit,

      @ObjectModel:{ readOnly: 'EXTERNAL_CALCULATION',
                     editableFieldFor: 'ConsolidationUnit' }
      @ObjectModel.mandatory: true
      bunit           as ConsolidationUnitForEdit,

      @ObjectModel.mandatory: true
      classification  as Classification,

      @ObjectModel.mandatory: true
      tax_rate_change as TaxRateChange,

      @ObjectModel.mandatory: true
      dta_recognition as DTARecognition,

      @ObjectModel.mandatory: true
      dtice           as DTIntracompanyElimination,

      @ObjectModel.readOnly: true
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,

      @ObjectModel.readOnly: true
      @Semantics.systemDateTime.createdAt: true
      created_on      as CreatedOn,

      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      @ObjectModel.readOnly: true
      @Semantics.user.lastChangedBy: true
      changed_by      as ChangedBy,

      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      @ObjectModel.readOnly: true
      @Semantics.systemDateTime.lastChangedAt: true
      changed_on      as ChangedOn,

      //Association
      @ObjectModel: { association: { type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT] } }
      _GGAAP
}

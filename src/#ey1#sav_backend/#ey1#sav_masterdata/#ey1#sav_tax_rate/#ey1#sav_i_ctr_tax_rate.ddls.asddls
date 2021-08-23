@AbapCatalog.sqlViewName: '/EY1/ICTRTAXRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Interface view for country tax rates'
@Analytics.dataCategory: #CUBE
@VDM.viewType: #TRANSACTIONAL

@ObjectModel: { compositionRoot:                true,
                modelCategory:                  #BUSINESS_OBJECT,
                transactionalProcessingEnabled: true,
                createEnabled:                 'EXTERNAL_CALCULATION',
                updateEnabled:                 'EXTERNAL_CALCULATION',
                deleteEnabled:                 'EXTERNAL_CALCULATION',
                semanticKey:                   ['rbunit', 'gjahr', 'intention' ],
                draftEnabled:                  true,
                writeDraftPersistence: '/EY1/I_TAX_R_D' }

define view /EY1/SAV_I_CTR_Tax_Rate
  as select from /ey1/tax_rates

{

      @ObjectModel.readOnly: true
  key rbunit,

      @ObjectModel.readOnly: true
  key gjahr,

      @ObjectModel.readOnly: true
  key intention,

//       @ObjectModel.readOnly:true
////      @UI.dataPoint: { title: 'Intention'}
////      concat(concat(concat(_IntentVH.IntentionDomText, ' ('), intention), ')') as intentionText,
//      concat(_IntentVH.IntentionDomText, intention) as intentionText,

      @ObjectModel:{ readOnly:         'EXTERNAL_CALCULATION',
                     editableFieldFor: 'rbunit' }
      @ObjectModel.mandatory: true
      rbunit as rbunitForEdit,

      @ObjectModel:{ readOnly: 'EXTERNAL_CALCULATION',
                     editableFieldFor: 'gjahr' }
      @ObjectModel.mandatory: true  
      //@Semantics.fiscal.year: true 
      cast(gjahr as abap.sstring( 4 )) as gjahrForEdit,

      @ObjectModel:{ readOnly: 'EXTERNAL_CALCULATION',
                     editableFieldFor: 'intention' }
      @ObjectModel.mandatory: true
      intention as intentionForEdit,

      @ObjectModel.mandatory: true
      current_tax_rate,
      concat_with_space( cast(current_tax_rate as abap.sstring( 10 )), '%', 1) as current_tax_rateForEdit,

      gaap_ob_dt_rate,

      @ObjectModel.readOnly: true
      concat_with_space( cast(gaap_ob_dt_rate as abap.sstring( 10 )), '%', 1)  as gaap_ob_dt_rateForEdit,

      gaap_cb_dt_rate,
      concat_with_space( cast(gaap_cb_dt_rate as abap.sstring( 10 )), '%', 1)  as gaap_cb_dt_rateForEdit,

      stat_ob_dt_rate,

      @ObjectModel.readOnly: true
      concat_with_space( cast(stat_ob_dt_rate as abap.sstring( 10 )), '%', 1)  as stat_ob_dt_rateForEdit,

      stat_cb_dt_rate,

      concat_with_space( cast(stat_cb_dt_rate as abap.sstring( 10 )), '%', 1)  as stat_cb_dt_rateForEdit,

      @ObjectModel.readOnly: true
      created_by,
      
      @ObjectModel.readOnly: true
      created_on,

      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      @ObjectModel.readOnly: true
      changed_by,

      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      @ObjectModel.readOnly: true
      changed_on
      
}

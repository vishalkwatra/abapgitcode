@AbapCatalog.sqlViewName: '/EY1/V_INTNSNVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@ClientDependent: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Intentions Value Help'
@Metadata.allowExtensions: true 
@Search.searchable: true

@ObjectModel.semanticKey: 'Intention'
@ObjectModel.representativeKey: 'Intention'

@VDM.viewType: #CONSUMPTION

define view /EY1/C_INTENTIONS_VH
with parameters 
@Environment.systemField: #CLIENT
@Consumption.hidden: true
 p_mandt: abap.clnt,
 p_bunit: fc_bunit,
 p_gjahr: gjahr
 as select from /EY1/I_INTENTIONS_VH( p_mandt:$parameters.p_mandt,p_bunit:$parameters.p_bunit,p_gjahr:$parameters.p_gjahr ) {
    @ObjectModel.readOnly: true
    @UI.identification: { position: 10, importance: #HIGH  }
    @UI.lineItem: { position: 10, importance: #HIGH }
    key IntentionCode,
    
    @ObjectModel.readOnly: true
    @UI.identification: { position: 20, importance: #HIGH  }
    @UI.lineItem: { position: 20, importance: #HIGH }
    @Search.defaultSearchElement: true
    key Intention,
    
    @UI.identification: { position: 30, importance: #HIGH  }
    @UI.lineItem: { position: 30, importance: #HIGH }
    @Search.defaultSearchElement: true
    Description,
    
    PeriodTo 
} where Status = ' '

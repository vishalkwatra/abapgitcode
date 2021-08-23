@AbapCatalog.sqlViewName: '/EY1/V_INTENTION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@ClientDependent: true
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true 
@Search.searchable: true
@EndUserText.label: 'Intention Values with Status'

@ObjectModel.semanticKey: 'Intention'
@ObjectModel.representativeKey: 'Intention'

@VDM.viewType: #CONSUMPTION

define view /EY1/C_INTENTIONS_VALUES
with parameters 
@Environment.systemField: #CLIENT
@Consumption.hidden: true
 p_mandt: abap.clnt,
 p_bunit: fc_bunit,
 p_gjahr: gjahr
as select from /EY1/INTENTIONS_TF( p_mandt:$parameters.p_mandt,p_gjahr:$parameters.p_gjahr,p_bunit:$parameters.p_bunit ) {   
    @ObjectModel.readOnly: true
    @UI.identification: { position: 10, importance: #HIGH  }
    @UI.lineItem: { position: 10, importance: #HIGH }
    key code as IntentionCode,
    
    @ObjectModel.readOnly: true
    @UI.identification: { position: 20, importance: #HIGH  }
    @UI.lineItem: { position: 20, importance: #HIGH }
    @Search.defaultSearchElement: true
    key intent as Intention,
    
    @UI.identification: { position: 30, importance: #HIGH  }
    @UI.lineItem: { position: 30, importance: #HIGH }
    @Search.defaultSearchElement: true
    description as Description,
    
    @UI.identification: { position: 40, importance: #HIGH  }
    @UI.lineItem: { position: 40, importance: #HIGH }
    @Search.defaultSearchElement: true 
    case status 
    when 'X' then 'Closed'
    else 'Open' end as Status,
    
    periodto as PeriodTo
    
}

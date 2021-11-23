@AbapCatalog.sqlViewName: '/EY1/C_JOUENT_VH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Journal Entry Type - Value Help'


@VDM.viewType: #CONSUMPTION
@Search.searchable: true

@ObjectModel.semanticKey: 'DocumentType'
@ObjectModel.representativeKey: 'DocumentType'
@ObjectModel.usageType.dataClass: #CUSTOMIZING      // Table T001 is customizing
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.dataCategory:#VALUE_HELP

@ClientHandling.algorithm: #SESSION_VARIABLE

define view /EY1/C_JOURNAL_ENTRY_TYPE_VH as select from FISCDS_BLART_VH {
 
    @Semantics.language: true
    key spras as Language,
    
    @ObjectModel.text.element:  [ 'DocumentType' ]
    @Search: { defaultSearchElement: true, ranking: #HIGH }
    key blart as CADocumentType,
    
    @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
    ltext as CADocumentTypeName
    
}

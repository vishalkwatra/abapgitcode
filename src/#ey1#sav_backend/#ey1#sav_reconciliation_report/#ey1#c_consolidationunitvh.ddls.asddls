@AbapCatalog.sqlViewName: '/EY1/CCSUNITVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #CONSUMPTION
@ObjectModel.dataCategory:#VALUE_HELP
@ObjectModel.semanticKey: 'ConsolidationUnit'
@ObjectModel.representativeKey: 'ConsolidationUnit'
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #S
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Consolidation Unit Value Help'
define view /EY1/C_ConsolidationUnitVH as select from C_CnsldtnUnitValueHelp as a
 inner join /ey1/globalparam as b
 on a.ConsolidationUnit = b.bunit
 inner join I_CnsldtnUnit as _c
 on a.ConsolidationUnit = _c.ConsolidationUnit{
      @ObjectModel.text.element:  [ 'ConsolidationUnitText' ]
       @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.6  }
  key  a.ConsolidationUnit,
       @UI.hidden: true
       a.ConsolidationDimension,

       @Semantics.text: true
       @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.7 }
       a.ConsolidationUnitText,
       
       _c.Country
} where b.uname = $session.user 

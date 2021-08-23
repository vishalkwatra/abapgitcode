@AbapCatalog.sqlViewName: '/EY1/SAVIFINT'
@Search.searchable: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TEST VIEW'
@Metadata.allowExtensions: true
@OData.publish: true


@ObjectModel.semanticKey: 'gjahr'
@ObjectModel.representativeKey: 'guid'
@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.compositionRoot: true
@ObjectModel.transactionalProcessingEnabled: true
@ObjectModel.createEnabled: true
@ObjectModel.deleteEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.draftEnabled: true
@ObjectModel.writeActivePersistence: '/ey1/fiscl_intnt'
@ObjectModel.writeDraftPersistence: '/ey1/fis_intnt_d'

define view /EY1/SAV_I_FiscIntention

  as select from /ey1/fiscl_intnt
{

  key guid,
  @Search.defaultSearchElement: true
  key gjahr,
      intention,
      seqnr_flb,
      period_to,
      created_by,
      created_on,
      changed_by,
      changed_on
      
}

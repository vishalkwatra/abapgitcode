@AbapCatalog.sqlViewName: '/EY1/SAVINTST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view to fetch Intentions and states'


@Metadata.allowExtensions: true
@VDM.viewType: #TRANSACTIONAL


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
@ObjectModel.writeDraftPersistence: '/EY1/INT_STAT_D'


define view /EY1/SAV_I_Intentions
  //as select from /ey1/tax_rates{
  //key rbunit as Rbunit,
  //key gjahr as Gjahr,
  //key intention as Intention,
  //current_tax_rate as CurrentTaxRate,
  //gaap_ob_dt_rate as GaapObDtRate,
  //gaap_cb_dt_rate as GaapCbDtRate,
  //stat_ob_dt_rate as StatObDtRate,
  //stat_cb_dt_rate as StatCbDtRate,
  //created_by as CreatedBy,
  //created_on as CreatedOn,
  //changed_by as ChangedBy,
  //changed_on as ChangedOn,
  //entry_date as EntryDate
  //}
  as select from /ey1/fiscl_intnt
{

  key guid,
  key gjahr,
      intention,
      seqnr_flb,
      period_to,
      created_by,
      created_on,
      changed_by,
      changed_on
}

@AbapCatalog.sqlViewName: '/EY1/SAVCINTST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption view to fetch Intentions and states'
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION


@ObjectModel.semanticKey: 'FiscalYear'
@ObjectModel.representativeKey: 'Guid'
@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.compositionRoot: true
@ObjectModel.transactionalProcessingDelegated: true
@ObjectModel.createEnabled: true
@ObjectModel.deleteEnabled: true
@ObjectModel.updateEnabled: true
@ObjectModel.draftEnabled: true


define view /EY1/SAV_C_Intentions
  //    as select from /ey1/tax_rates
  //  {
  //    key rbunit as Rbunit,
  //    key gjahr as Gjahr,
  //    key intention as Intention,
  //    current_tax_rate as CurrentTaxRate,
  //    gaap_ob_dt_rate as GaapObDtRate,
  //    gaap_cb_dt_rate as GaapCbDtRate,
  //    stat_ob_dt_rate as StatObDtRate,
  //    stat_cb_dt_rate as StatCbDtRate,
  //    created_by as CreatedBy,
  //    created_on as CreatedOn,
  //    changed_by as ChangedBy,
  //    changed_on as ChangedOn,
  //    entry_date as EntryDate
  //
  //  }
  as select from /EY1/SAV_I_Intentions
{
  key guid       as Guid,
  @UI.identification: { position: 10, importance: #HIGH  }
  @UI.lineItem: { position: 10, importance: #HIGH }
  key gjahr      as FiscalYear,
      
      @UI.identification: { position: 20, importance: #HIGH  }
      @UI.lineItem: { position: 20, importance: #HIGH }
      intention  as Intention,
      
      @UI.identification: { position: 30, importance: #HIGH  }
      @UI.lineItem: { position: 30, importance: #HIGH }
      seqnr_flb  as SerialNumber,
      
      @UI.identification: { position: 40, importance: #HIGH  }
      @UI.lineItem: { position: 40, importance: #HIGH }
      period_to  as PeriodTo,
      
      created_by as CreatedBy,
      created_on as CreatedOn,
      changed_by as ChangedBy,
      changed_on as ChangedOn
      
}

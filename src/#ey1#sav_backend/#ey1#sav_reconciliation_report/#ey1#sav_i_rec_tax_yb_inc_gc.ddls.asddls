@AbapCatalog.sqlViewName: '/EY1/TAXYBINC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for TAX YB Calculation Including CTA'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_YB_Inc_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_Rec_TAX_YB_PL_GC( p_ryear:  $parameters.p_ryear,
                                               p_fromyb: $parameters.p_fromyb,
                                               p_toyb:   $parameters.p_toyb,
                                               p_taxintention: $parameters.p_taxintention)
  //                                               p_specialperiod: $parameters.p_specialperiod)
{ //EY_SAV_I_GLACC_TAX_YB_PL_GC
  key ConsolidationLedger,
  key ConsolidationDimension,
  key FiscalYear,
      GLAccount,
      TaxMvmntIncCTA,
      ChartOfAccounts,
      ConsolidationUnit,
      GroupCurrency
}
union all select from /EY1/SAV_I_Rec_TAX_YB_NPL_GC( p_ryear:  $parameters.p_ryear,
                                                     p_fromyb: $parameters.p_fromyb,
                                                     p_toyb:   $parameters.p_toyb,
                                                     p_taxintention: $parameters.p_taxintention)
//                                                     p_specialperiod: $parameters.p_specialperiod)
{ //EY_SAV_I_GLACC_TAX_YB_NPL_GC
  key ConsolidationLedger,
  key ConsolidationDimension,
  key FiscalYear,
      GLAccount,
      TaxMvmntIncCTA,
      ChartOfAccounts,
      ConsolidationUnit,
      GroupCurrency
}

@AbapCatalog.sqlViewName: '/EY1/IRECONLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I- View Reconciliation LC & GC Union'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Recon_LC_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention

  as select from /EY1/SAV_Union_Recon_LC_GC( p_ryear: $parameters.p_ryear,
                                             p_fromyb: $parameters.p_fromyb,
                                             p_toyb: $parameters.p_toyb,
                                             p_switch: $parameters.p_switch,
                                             p_taxintention: $parameters.p_taxintention,
                                             p_intention: $parameters.p_intention)
  //                                             p_specialperiod: $parameters.p_specialperiod)
{
      //ZEY_SAV_U_RECONCILIATION
  key GLAccount,
  key FinancialStatementItem,
  key AccountClassCode,
  key FiscalYear,
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
      ConsolidationUnit,
      MainCurrency,
      GaapOpeningBalance,
      GaapYearBalance,
      GaapCTA,
      GaapClosingBalance,
      GaapToStatPL,
      GaapToStatPmnt,
      GaapToStatEQ,
      GaapToStatOtherPL,
      GaapToStatOtherPmnt,
      GaapToStatOtherEQ,
      G2SCTA,
      StatOpeningBalance,
      StatPYA,
      StatYearBalance,
      StatCTA,
      StatClosingBalance,
      StatToTaxPL,
      StatToTaxPmnt,
      StatToTaxEQ,
      StatToTaxOtherPL,
      StatToTaxOtherPmnt,
      StatToTaxOtherEQ,
      S2TCTA,
      TaxOpeningBalance,
      TaxPYA,
      TaxYearBalance,
      TaxCTA,
      TaxClosingBalance,
      TaxPTA,
      BsEqPl,
      CurrType,
      Period
}

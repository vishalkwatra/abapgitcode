@AbapCatalog.sqlViewName: '/EY1/URECONLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Union View Reconciliation LC&GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_Union_Recon_LC_GC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_Rec_LC( p_ryear: $parameters.p_ryear,
                                    p_fromyb: $parameters.p_fromyb,
                                    p_toyb: $parameters.p_toyb,
                                     p_taxintention: $parameters.p_taxintention)
  //                                    p_specialperiod: $parameters.p_specialperiod)
{
      //ZEY_SAV_I_Recon_LC
  key GLAccount,
  key FinancialStatementItem,
  key AccountClassCode,
  key FiscalYear,
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
      ConsolidationUnit,
      LocalCurrency as MainCurrency,

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

union all select from /EY1/SAV_I_Rec_GC( p_ryear: $parameters.p_ryear,
                                         p_fromyb: $parameters.p_fromyb,
                                         p_toyb: $parameters.p_toyb,
                                         p_switch: $parameters.p_switch,
                                          p_taxintention: $parameters.p_taxintention)
//                                         p_specialperiod: $parameters.p_specialperiod)
{
      //ZEY_SAV_I_Recon_GC
  key GLAccount,
  key FinancialStatementItem,
  key AccountClassCode,
  key FiscalYear,
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
      ConsolidationUnit,
      GroupCurrency as MainCurrency,

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

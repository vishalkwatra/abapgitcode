@AbapCatalog.sqlViewName: '/EY1/IRECONANALT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I view for analytical query'
@Analytics.dataCategory: #CUBE

define view /EY1/SAV_I_RECON_ANALT
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
      @DefaultAggregation: #SUM
      GaapOpeningBalance,
      @DefaultAggregation: #SUM
      GaapYearBalance,
      @DefaultAggregation: #SUM
      GaapCTA,
      @DefaultAggregation: #SUM
      GaapClosingBalance,
      @DefaultAggregation: #SUM
      GaapToStatPL,
      @DefaultAggregation: #SUM
      GaapToStatPmnt,
      @DefaultAggregation: #SUM
      GaapToStatEQ,
      @DefaultAggregation: #SUM
      GaapToStatOtherPL,
      @DefaultAggregation: #SUM
      GaapToStatOtherPmnt,
      @DefaultAggregation: #SUM
      GaapToStatOtherEQ,
      @DefaultAggregation: #SUM
      G2SCTA,
      @DefaultAggregation: #SUM
      StatOpeningBalance,
      @DefaultAggregation: #SUM
      StatPYA,
      @DefaultAggregation: #SUM
      StatYearBalance,
      @DefaultAggregation: #SUM
      StatCTA,
      @DefaultAggregation: #SUM
      StatClosingBalance,
      @DefaultAggregation: #SUM
      StatToTaxPL,
      @DefaultAggregation: #SUM
      StatToTaxPmnt,
      @DefaultAggregation: #SUM
      StatToTaxEQ,
      @DefaultAggregation: #SUM
      StatToTaxOtherPL,
      @DefaultAggregation: #SUM
      StatToTaxOtherPmnt,
      @DefaultAggregation: #SUM
      StatToTaxOtherEQ,
      @DefaultAggregation: #SUM
      S2TCTA,
      @DefaultAggregation: #SUM
      TaxOpeningBalance,
      @DefaultAggregation: #SUM
      TaxPYA,
      @DefaultAggregation: #SUM
      TaxYearBalance,
      @DefaultAggregation: #SUM
      TaxCTA,
      @DefaultAggregation: #SUM
      TaxClosingBalance,
      @DefaultAggregation: #SUM
      TaxPTA,
      BsEqPl,
      Upper(CurrType) as CurrType,
      Period
}

@AbapCatalog.sqlViewName: '/EY1/ITRFANLT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Temp Roll Forward'
@Analytics.dataCategory: #CUBE
//@Search.searchable: true
//@Analytics.query: true
define view /EY1/SAV_I_TRF_ANLT


  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
     p_taxintention : zz1_taxintention,
    //    p_p_taxintention : zz1_p_taxintention,
    p_rbunit       : fc_bunit
    
 
//   
  as select from /EY1/SAV_I_TRF_RS_GAAP_Union( p_toperiod :$parameters.p_toperiod,
                                               p_ryear:$parameters.p_ryear,
                                               p_taxintention :$parameters.p_taxintention,
                                               p_rbunit:$parameters.p_rbunit  ) as RSGaap


{ //RGaapUnion
  key ChartOfAccounts,
  key RSGaap.ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key RSGaap.FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,

      MainCurrency,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      @DefaultAggregation: #SUM
      EqOpeningBalance,
      @DefaultAggregation: #SUM
      PlOpeningBalance,
      @DefaultAggregation: #SUM
      PmntOpeningBalance,
      @DefaultAggregation: #SUM
      TempDiffOpeningBalance,

      //Year Balance
      @DefaultAggregation: #SUM
      PlYearBalance,
      @DefaultAggregation: #SUM
      PmntYearBalance,
      @DefaultAggregation: #SUM
      EqYearBalance,
      @DefaultAggregation: #SUM
      OPlYearBalance,
      @DefaultAggregation: #SUM
      OPmntYearBalance,
      @DefaultAggregation: #SUM
      OEqYearBalance,
      @DefaultAggregation: #SUM
      TempTransType,
      @DefaultAggregation: #SUM
      TempOtherTransType,
      @DefaultAggregation: #SUM
      CurrentYearMvmnt,

      //Closing Balance
      @DefaultAggregation: #SUM
      PlClosingBalance,
      @DefaultAggregation: #SUM
      PmntClosingBalance,
      @DefaultAggregation: #SUM
      EqClosingBalance,
      @DefaultAggregation: #SUM
      ClosingBalance,

      //CTA
      @DefaultAggregation: #SUM
      CTAPl,
      @DefaultAggregation: #SUM
      CTAPmnt,
      @DefaultAggregation: #SUM
      CTAEq,
      @DefaultAggregation: #SUM
      CTA,

      //PYA
      @DefaultAggregation: #SUM
      PYAPl,
      @DefaultAggregation: #SUM
      PYAPmnt,
      @DefaultAggregation: #SUM
      PYAEq,
      @DefaultAggregation: #SUM
      PYAOpl,
      @DefaultAggregation: #SUM
      PYAOpmnt,
      @DefaultAggregation: #SUM
      PYAOeq,
      @DefaultAggregation: #SUM
      PYA,

      Upper(CurrencyType) as CurrencyType,
      BsEqPl,
      TaxEffected,
      // @Search.defaultSearchElement: true
      ReportingType

}

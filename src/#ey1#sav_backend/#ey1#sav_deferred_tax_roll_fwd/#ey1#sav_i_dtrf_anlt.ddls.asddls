@AbapCatalog.sqlViewName: '/EY1/IDTRFANLT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I view For DeferredTaxRollFrwd'
@Analytics.dataCategory: #CUBE
define view /EY1/SAV_I_DTRF_ANLT

  with parameters
    p_rbunit        : fc_bunit,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    //p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_DTRF_RS_GAAP_Union( p_rbunit :$parameters.p_rbunit,
                                                p_toperiod :$parameters.p_toperiod,
                                                p_ryear:$parameters.p_ryear,
                                                p_taxintention :$parameters.p_taxintention )
{
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,

      MainCurrency,

      // OB & CB Class
      OBClass,
      CBClass,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      @DefaultAggregation: #SUM
      //EqOpeningBalance,
      cast( EqOpeningBalance as abap.dec(11,2) )     as EqOpeningBalance,
      @DefaultAggregation: #SUM
      cast( PlOpeningBalance as abap.dec(11,2) )     as PlOpeningBalance,
      //      PlOpeningBalance,
      @DefaultAggregation: #SUM
      //      OpeningBalanceDTADTL,
      cast( OpeningBalanceDTADTL as abap.dec(11,2) ) as OpeningBalanceDTADTL,
      //Year Balance
      @DefaultAggregation: #SUM
      //PlYearBalance,
      cast( PlYearBalance as abap.dec(11,2) )        as PlYearBalance,
      @DefaultAggregation: #SUM
      //EqYearBalance,
      cast( EqYearBalance as abap.dec(11,2) )        as EqYearBalance,
      @DefaultAggregation: #SUM
      //OPlYearBalance,
      cast( OPlYearBalance as abap.dec(11,2) )       as OPlYearBalance,
      @DefaultAggregation: #SUM
      //OEqYearBalance,
      cast( OEqYearBalance as abap.dec(11,2) )       as OEqYearBalance,
      @DefaultAggregation: #SUM
      //TempTransType,
      cast( TempTransType as abap.dec(11,2) )        as TempTransType,
      @DefaultAggregation: #SUM
      //TempOtherTransType,
      cast( TempOtherTransType as abap.dec(11,2) )   as TempOtherTransType,
      @DefaultAggregation: #SUM
      //CurrentYearMvmnt,
      cast( CurrentYearMvmnt as abap.dec(11,2) )     as CurrentYearMvmnt,

      //Closing Balance
      @DefaultAggregation: #SUM
      //PlClosingBalance,
      cast( PlClosingBalance as abap.dec(11,2) )     as PlClosingBalance,
      @DefaultAggregation: #SUM
      //EqClosingBalance,
      cast( EqClosingBalance as abap.dec(11,2) )     as EqClosingBalance,
      @DefaultAggregation: #SUM
      //ClosingBalanceDTADTL,
      cast( ClosingBalanceDTADTL as abap.dec(11,2) ) as ClosingBalanceDTADTL,

      //CTA
      @DefaultAggregation: #SUM
      //CTAPl,
      cast( CTAPl as abap.dec(11,2) )                as CTAPl,
      @DefaultAggregation: #SUM
      //CTAEq,
      cast( CTAEq as abap.dec(11,2) )                as CTAEq,
      @DefaultAggregation: #SUM
      //CTA,
      cast( CTA as abap.dec(11,2) )                  as CTA,

      //PYA
      @DefaultAggregation: #SUM
      //PYAPl,
      cast( PYAPl as abap.dec(11,2) )                as PYAPl,
      @DefaultAggregation: #SUM
      //PYAEq,
      cast( PYAEq as abap.dec(11,2) )                as PYAEq,
      @DefaultAggregation: #SUM
      //PYAOpl,
      cast(PYAOpl as abap.dec(11,2) )                as PYAOpl,
      @DefaultAggregation: #SUM
      //PYAOeq,
      cast( PYAOeq as abap.dec(11,2) )               as PYAOeq,
      @DefaultAggregation: #SUM
      //PYA,
      cast( PYA as abap.dec(11,2) )                  as PYA,

      //TRC
      @DefaultAggregation: #SUM
      //TRCPl,
      cast( TRCPl as abap.dec(11,2) )                as TRCPl,
      @DefaultAggregation: #SUM
      //TRCEq,
      cast( TRCEq as abap.dec(11,2) )                as TRCEq,
      @DefaultAggregation: #SUM
      //TRC,
      cast( TRC as abap.dec(11,2) )                  as TRC,

      Upper(CurrencyType)                            as CurrencyType,
      BsEqPl,
      TaxEffected,
      ReportingType

}

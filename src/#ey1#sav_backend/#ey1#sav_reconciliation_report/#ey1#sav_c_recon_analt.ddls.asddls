@AbapCatalog.sqlViewName : '/EY1/CRECONANALT'
@Analytics.query: true
@OData.publish: true
@EndUserText.label: 'Analytics - Reconciliation Report'

define view /EY1/SAV_C_RECON_ANALT
  with parameters
    @Consumption.hidden :false
    @Consumption.valueHelpDefinition: [{ entity: { name:    'C_CnsldtnFiscalYearVH',
                                                   element: 'FiscalYear' } }]
    @AnalyticsDetails.query.variableSequence : 03
    p_ryear        : gjahr,

    @EndUserText.label: 'Period From'
    @Consumption.defaultValue: '001'
    @Consumption.hidden: true
    p_fromyb       : poper,

    @Consumption.defaultValue: '#'
    @EndUserText.label: 'CTA for P&L'
    @Consumption.hidden :false
    @Consumption.valueHelpDefinition: [{ entity: { name:    '/EY1/SAV_CTAforPL_VH',
                                                   element: 'value' } }]
    p_switch       : char1,

    //    @Consumption.defaultValue: '#'
    //    @EndUserText.label: 'Intention'
    //    @Consumption.quickInfoElement: 'please select from 1-12'
    //    @Consumption.hidden :false
    //    p_specialperiod : zz1_specialperiod,

    @Consumption.defaultValue: '#'
    @EndUserText.label: 'Intention'
    @Consumption.quickInfoElement: 'please select from 1-12'
    @Consumption.hidden :false
    p_taxintention : zz1_taxintention,

    @EndUserText.label: 'To Period'
    @Consumption.hidden : false
    @Consumption.defaultValue: '12'
    p_toyb         : poper,

    @Consumption.hidden :false
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.valueHelpDefinition: [{ entity: { name:    '/EY1/SAV_CONSLDUNIT_VH',
                                                   element: 'ConsolidationUnit' } }]
    p_consldunit   : fc_bunit,

    @Consumption.hidden :false
    @EndUserText.label: 'Currency Type'
    @Consumption.valueHelpDefinition: [{  entity: { name:    '/EY1/SAV_CURRENCYTYPE_VH',
                                                    element: 'currency_type' } }]
    p_currencytype : /ey1/ctype_name

  as select from /EY1/SAV_I_RECON_ANALT(p_ryear:$parameters.p_ryear,
                                        p_fromyb:$parameters.p_fromyb,
                                        p_toyb:$parameters.p_toyb,
                                        p_switch:$parameters.p_switch,
                                        p_taxintention: $parameters.p_taxintention)
  //                                        p_specialperiod:$parameters.p_specialperiod)
{
  key FiscalYear,
  key FinancialStatementItem,

      @AnalyticsDetails.query.axis:#ROWS
      @EndUserText.label: 'Account '
  key GLAccount,

      @AnalyticsDetails.query.axis:#ROWS
  key AccountClassCode,

  key ConsolidationChartofAccounts,
  key ChartOfAccounts,

      @AnalyticsDetails.query.axis:#ROWS
      @AnalyticsDetails.query.variableSequence : 01
      ConsolidationUnit,

      @EndUserText.label: 'Currency'
      @AnalyticsDetails.query.axis:#ROWS
      MainCurrency,

      @EndUserText.label: 'CCY'
      @AnalyticsDetails.query.axis:#ROWS
      CurrType,

      //GAAP
      @EndUserText.label: 'GAAP OB'
      GaapOpeningBalance,

      @EndUserText.label: 'GAAP Mvmnt'
      GaapYearBalance,

      @EndUserText.label: 'GAAP CTA'
      GaapCTA,

      @EndUserText.label: 'GAAP CB'
      GaapClosingBalance,

      @EndUserText.label: 'G2S P&L'
      GaapToStatPL,

      @EndUserText.label: 'G2S PERM'
      GaapToStatPmnt,

      @EndUserText.label: 'G2S EQ'
      GaapToStatEQ,

      @EndUserText.label: 'G2S OTH P&L'
      GaapToStatOtherPL,

      @EndUserText.label: 'G2S OTH PERM'
      GaapToStatOtherPmnt,

      @EndUserText.label: 'G2S OTH EQ'
      GaapToStatOtherEQ,

      @EndUserText.label: 'G2S CTA'
      G2SCTA,

      //STAT
      @EndUserText.label: 'STAT OB'
      StatOpeningBalance,

      @EndUserText.label: 'STAT PYA'
      StatPYA,

      @EndUserText.label: 'STAT Mvmnt'
      StatYearBalance,

      @EndUserText.label: 'STAT CTA'
      StatCTA,

      @EndUserText.label: 'STAT CB'
      StatClosingBalance,

      @EndUserText.label: 'S2T P&L'
      StatToTaxPL,

      @EndUserText.label: 'S2T PERM'
      StatToTaxPmnt,

      @EndUserText.label: 'S2T EQ'
      StatToTaxEQ,

      @EndUserText.label: 'S2T OTH P&L'
      StatToTaxOtherPL,

      @EndUserText.label: 'S2T OTH PERM'
      StatToTaxOtherPmnt,

      @EndUserText.label: 'S2T OTH EQ'
      StatToTaxOtherEQ,

      @EndUserText.label: 'S2T CTA'
      S2TCTA,

      //TAX
      @EndUserText.label: 'TAX OB'
      TaxOpeningBalance,

      @EndUserText.label: 'TAX PYA'
      TaxPYA,

      @EndUserText.label: 'TAX Mvmnt'
      TaxYearBalance,

      @EndUserText.label: 'TAX CTA'
      TaxCTA,

      @EndUserText.label: 'TAX CB'
      TaxClosingBalance,

      @EndUserText.label: 'PTA'
      TaxPTA,

      BsEqPl,
      Period
}
where
      ConsolidationUnit = :p_consldunit
  and CurrType          = :p_currencytype

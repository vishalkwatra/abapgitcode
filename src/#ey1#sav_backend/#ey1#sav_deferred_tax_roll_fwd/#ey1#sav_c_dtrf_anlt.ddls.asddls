@AbapCatalog.sqlViewName : '/EY1/CDTRFANLT'
@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.preserveKey: true
@Analytics.query: true
@OData.publish: true
@EndUserText.label: 'Analytics - Deferred Tax Roll Forward'
define view /EY1/SAV_C_DTRF_ANLT
  with parameters
    @Consumption.defaultValue: '012'
    @Consumption.hidden :false
    @EndUserText.label: 'To Period'
    @AnalyticsDetails.query.variableSequence : 04
    p_toperiod     : poper,
    @Consumption.hidden :false
    @AnalyticsDetails.query.variableSequence : 02
    @Consumption.valueHelpDefinition: [{
          entity: {
            name: 'C_CnsldtnFiscalYearVH',
            element: 'FiscalYear'
          }
        }]
    p_ryear        : gjahr,
    @AnalyticsDetails.query.variableSequence : 03
    //@Consumption.quickInfoElement: ''
    //@Consumption.labelElement: 'SELECT FROM'
    //@EndUserText:{label : 'Intent' , quickInfo: 'please select from 1-12'}
    //    @Consumption.defaultValue: '#'
    //    @EndUserText.label: 'Intention'
    @Consumption.hidden :false
    //p_specialperiod : zz1_specialperiod,
    @EndUserText.label: 'Tax Intention'
    @Consumption.defaultValue: '101'
    p_taxintention : zz1_taxintention,
    @Consumption.hidden :false
    @EndUserText.label: 'Reporting Type'
    @Consumption.valueHelpDefinition: [{
          entity: {
            name: '/EY1/SAV_REPORTINGTYPE_VH',
            element: 'reporting_type'
          }
        }]


    p_reporting    : /ey1/rtype_name,
    @Consumption.hidden :false
    @AnalyticsDetails.query.variableSequence : 01
    @Consumption.valueHelpDefinition: [{
          entity: {
            name: '/EY1/SAV_CONSLDUNIT_VH',
            element: 'ConsolidationUnit'
          }
        }]

    p_consldunit   : fc_bunit,
    @Consumption.hidden :false
    @EndUserText.quickInfo: 'hello'
    @EndUserText.label: 'Currency Type'
    @Consumption.valueHelpDefinition: [{
          entity: {
            name: '/EY1/SAV_CURRENCYTYPE_VH',
            element: 'currency_type'
          }
        }]
    p_currencytype : /ey1/ctype_name

  as select from /EY1/SAV_I_DTRF_ANLT(p_rbunit:$parameters.p_consldunit,
                 p_toperiod:$parameters.p_toperiod,
                 p_ryear:$parameters.p_ryear,
                 p_taxintention:$parameters.p_taxintention)

{
  key ChartOfAccounts,
      @AnalyticsDetails.query.axis:#ROWS
      @AnalyticsDetails.query.variableSequence : 01
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
      @AnalyticsDetails.query.axis:#ROWS
      @EndUserText.label: 'Account'
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,
      ConsolidationDimension,
      FinancialStatementItem,

      @AnalyticsDetails.query.axis:#ROWS
      @EndUserText.label: 'Currency'
      MainCurrency,

      // OB & CB Class
      CBClass,
      OBClass,
      //Tax Rates
      @EndUserText.label: 'OB DT Rate'
      OBRate,
      @EndUserText.label: 'CB DT Rate'
      CBRate,

      //Opening Balance
      @EndUserText.label: 'OB P&L'
      PlOpeningBalance,
      @EndUserText.label: 'OB EQ'
      EqOpeningBalance,
      @EndUserText.label: 'OB DTA/DTL'
      OpeningBalanceDTADTL,

      //Year Balance
      @EndUserText.label: 'CY P&L'
      PlYearBalance,
      @EndUserText.label: 'CY EQ'
      EqYearBalance,
      @EndUserText.label: 'CY OTH P&L'
      OPlYearBalance,
      @EndUserText.label: 'CY OTH EQ'
      OEqYearBalance,

      //TempOtherTransType,
      @Consumption.hidden : true
      TempOtherTransType,
      //TempTransType,
      @Consumption.hidden : true
      TempTransType,

      //Closing Balance
      @EndUserText.label: 'CB P&L'
      PlClosingBalance,
      @EndUserText.label: 'CB EQ'
      EqClosingBalance,
      @EndUserText.label: 'CB DTA/DTL'
      ClosingBalanceDTADTL,

      //CTA
      @EndUserText.label: 'CTA P&L'
      CTAPl,
      @EndUserText.label: 'CTA EQ'
      CTAEq,
      CTA,

      //PYA
      @EndUserText.label: 'PYA P&L'
      PYAPl,
      @EndUserText.label: 'PYA EQ'
      PYAEq,
      @EndUserText.label: 'PYA OTH P&L'
      PYAOpl,
      @EndUserText.label: 'PYA OTH EQ'
      PYAOeq,
      PYA,

      //TempTransType,
      @EndUserText.label: 'TRC P&L'
      TRCPl,
      @EndUserText.label: 'TRC EQ'
      TRCEq,
      TRC,

      //CurrentYearMvmnt,
      @EndUserText.label: 'CY Mvmnt'
      CurrentYearMvmnt,
      @EndUserText.label: 'CCY'
      @AnalyticsDetails.query.axis:#ROWS
      CurrencyType,
      @AnalyticsDetails.query.axis:#ROWS
      @EndUserText.label: 'Reporting Type'
      @AnalyticsDetails.query.display: #KEY_TEXT
      @AnalyticsDetails.query.totals: #SHOW
      ReportingType,
      BsEqPl,
      TaxEffected


}
where
      ReportingType     = :p_reporting
  and ConsolidationUnit = :p_consldunit
  and CurrencyType      = :p_currencytype

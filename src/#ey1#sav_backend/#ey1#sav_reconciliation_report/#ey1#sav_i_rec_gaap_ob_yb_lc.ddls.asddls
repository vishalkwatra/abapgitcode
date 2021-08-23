@AbapCatalog.sqlViewName: '/EY1/GLOBYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Gaap OB YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_GAAP_OB_YB_LC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention

  as select distinct from /EY1/SAV_I_Rec_GlAcCUnit_GAAP as GLAccnt

    left outer join       /EY1/SAV_I_Rec_GAAP_OB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention:$parameters.p_taxintention
                          //                          p_specialperiod : $parameters.p_specialperiod

                           )                            as GaapOB on  GaapOB.GLAccount         = GLAccnt.GLAccount
                                                                  and GaapOB.FiscalYear        = GLAccnt.FiscalYear
                                                                  and GaapOB.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_Rec_GAAP_YB_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_fromyb:$parameters.p_fromyb,
                          p_toyb:$parameters.p_toyb,
                          p_taxintention:$parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                             as GaapYB on  GaapYB.GLAccount         = GLAccnt.GLAccount
                                                                  and GaapYB.FiscalYear        = GLAccnt.FiscalYear
                                                                  and GaapYB.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
  key GLAccnt.GLAccount,
  key AccountClassCode,
  key GLAccnt.ConsolidationLedger,
  key GLAccnt.FiscalYear,
      GLAccnt.ConsolidationChartOfAccounts,
      GLAccnt.FinancialStatementItem,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,

      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapOpeningBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      GaapYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case
        when GaapYearBalance is null then GaapOpeningBalance
        when GaapOpeningBalance is null then GaapYearBalance
        else GaapOpeningBalance + GaapYearBalance end as abap.curr( 23, 2 )) as GaapClosingBalance,
      cast (0 as abap.curr( 23, 2))                                          as GaapCTA

}

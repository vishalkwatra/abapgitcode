@AbapCatalog.sqlViewName: '/EY1/TAXOBYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Account - Tax OB YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_OB_YB_LC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_intention    : /ey1/sav_intent

  as select distinct from /EY1/SAV_I_RecGlAccCUnit_TAX                  as GLAccnt
    left outer join       /EY1/SAV_I_Rec_TAX_OBNR_LC
                    ( p_ryear:$parameters.p_ryear,
                          p_periodto: $parameters.p_toyb,
                           p_taxintention: $parameters.p_taxintention,
                            p_intention: $parameters.p_intention
                          //                          p_specialperiod : $parameters.p_specialperiod
                          )                                             as TaxOB  on  TaxOB.GLAccount         = GLAccnt.GLAccount
                                                                                  and TaxOB.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and TaxOB.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_Rec_TAX_YB_LC
                    ( p_ryear : $parameters.p_ryear,
                          p_fromyb: $parameters.p_fromyb,
                          p_toyb  : $parameters.p_toyb,
                          p_taxintention: $parameters.p_taxintention
                          //                          p_specialperiod: $parameters.p_specialperiod
                          )                                             as TaxYB  on  TaxYB.GLAccount         = GLAccnt.GLAccount
                                                                                  and TaxYB.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and TaxYB.ConsolidationUnit = GLAccnt.ConsolidationUnit

  //    left outer join       /EY1/SAV_I_Recon_Adj         as ReconAdj on  ReconAdj.racct = GLAccnt.GLAccount
  //                                                                   and ReconAdj.ryear = GLAccnt.FiscalYear


    left outer join       /EY1/SAV_I_Rec_TAX_PYA_LC( p_toyb: $parameters.p_toyb,
                              p_fromyb: $parameters.p_fromyb,
                              p_ryear: $parameters.p_ryear,
                              p_taxintention: $parameters.p_intention ) as TaxPYA on  TaxPYA.GLAccount         = GLAccnt.GLAccount
                                                                                  and TaxPYA.FiscalYear        = GLAccnt.FiscalYear
                                                                                  and TaxPYA.ConsolidationUnit = GLAccnt.ConsolidationUnit
{
  key GLAccnt.GLAccount,
  key AccountClassCode,
  key GLAccnt.ConsolidationLedger,
  key GLAccnt.ConsolidationDimension,
  key GLAccnt.FiscalYear,

      GLAccnt.FinancialStatementItem,
      GLAccnt.ChartOfAccounts,
      GLAccnt.ConsolidationUnit,

      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      TaxOpeningBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      TaxYearBalance,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      TaxPYALC                                                                                 as TaxPYA,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when TaxYearBalance is null then cast( case when TaxPYALC is null then TaxOpeningBalance
                                                             when TaxOpeningBalance is null then TaxPYALC
                                                             else TaxOpeningBalance + TaxPYALC end as abap.curr(23,2))

                 when TaxOpeningBalance is null then cast(case when TaxPYALC is null then TaxYearBalance
                                                               when TaxYearBalance is null then TaxPYALC
                                                               else TaxYearBalance + TaxPYALC end as abap.curr(23,2))

                 when TaxPYALC is null then cast(case when TaxYearBalance is null then TaxOpeningBalance
                                                      when TaxOpeningBalance is null then TaxYearBalance
                                                      else TaxOpeningBalance + TaxYearBalance end as abap.curr(23,2))

                 else TaxPYALC + TaxOpeningBalance + TaxYearBalance end as abap.curr( 23, 2 )) as TaxClosingBalance,

      cast (0 as abap.curr( 23, 2))                                                            as TaxCTA
}

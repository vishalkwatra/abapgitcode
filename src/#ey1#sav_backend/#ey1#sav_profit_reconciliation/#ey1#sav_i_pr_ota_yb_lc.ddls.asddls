@AbapCatalog.sqlViewName: '/EY1/PROTAYBLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- OTA - Year Mvmnt LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_OTA_YB_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ProfitRec_MD
                 ( p_ryear:$parameters.p_ryear )                     as GLAccnt
    left outer join /EY1/SAV_I_PR_OTA_PL_YB_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention)     as OTAPLYBLC   on  OTAPLYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and OTAPLYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and OTAPLYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax     = ''
                                                                                    and GLAccnt.TaxEffected         = 'X'
                                                                                    and BsEqPl                      = 'EQ'
    left outer join /EY1/SAV_I_PR_OTA_Pmnt_YB_LC
                        ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention) as OTAPmntYBLC on  OTAPmntYBLC.GLAccount         = GLAccnt.GLAccount
                                                                                    and OTAPmntYBLC.FiscalYear        = GLAccnt.FiscalYear
                                                                                    and OTAPmntYBLC.ConsolidationUnit = GLAccnt.ConsolidationUnit
                                                                                    and GLAccnt.ProfitBeforeTax       = ''
                                                                                    and GLAccnt.TaxEffected           = 'X'
                                                                                    and BsEqPl                        = 'EQ'
{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.FiscalYear,
  key GLAccnt.GLAccount,
  key AccountClassCode,
      GLAccnt.ConsolidationDimension,
      @Semantics.currencyCode: true
      GLAccnt.LocalCurrency,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OTALedgerPL                                                             as OTATransactionsPL,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      OTALedgerPmnt                                                           as OTATransactionsPmnt,
      @Semantics.amount.currencyCode: 'LocalCurrency'
      cast (case when OTALedgerPL is null then OTALedgerPmnt
                 when OTALedgerPmnt is null then OTALedgerPL
                 else OTALedgerPL + OTALedgerPmnt  end as abap.curr( 23, 2 )) as TransactionTotal

}
where
      GLAccnt.ProfitBeforeTax = ''
  and GLAccnt.TaxEffected     = 'X'
  and BsEqPl                  = 'EQ'

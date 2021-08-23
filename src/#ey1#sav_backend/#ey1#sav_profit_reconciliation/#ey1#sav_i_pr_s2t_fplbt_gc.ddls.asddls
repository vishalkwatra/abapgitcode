@AbapCatalog.sqlViewName: '/EY1/PRS2TFBTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-PR-S2T-Taxable Profit/Loss Before Tax GC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_S2T_FPLBT_GC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_G2S_SILBT_GC
                 ( p_toperiod:$parameters.p_toperiod,
                       p_ryear:$parameters.p_ryear,
                       p_taxintention:$parameters.p_taxintention)  as StatIncLossBeforeTax

    left outer join /EY1/SAV_I_PR_S2T_Total_GC ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,

                        p_taxintention:$parameters.p_taxintention) as TotalS2T on  StatIncLossBeforeTax.ChartOfAccounts              = TotalS2T.ChartOfAccounts
                                                                                 and StatIncLossBeforeTax.ConsolidationChartofAccounts = TotalS2T.ConsolidationChartofAccounts
                                                                                 and StatIncLossBeforeTax.ConsolidationUnit            = TotalS2T.ConsolidationUnit
                                                                                 and StatIncLossBeforeTax.FiscalYear                   = TotalS2T.FiscalYear
{
      //GaapIncLossBeforeTax
  key StatIncLossBeforeTax.ChartOfAccounts,
  key StatIncLossBeforeTax.ConsolidationUnit,
  key StatIncLossBeforeTax.ConsolidationChartofAccounts,
  key StatIncLossBeforeTax.FiscalYear,
      StatIncLossBeforeTax.ConsolidationDimension,
      @Semantics.currencyCode: true
      StatIncLossBeforeTax.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case
          when STATIncomeLossBT is null then TotalS2T
          when TotalS2T is null then STATIncomeLossBT
          else STATIncomeLossBT + TotalS2T
      end as FiscalIncomeLossBT
}

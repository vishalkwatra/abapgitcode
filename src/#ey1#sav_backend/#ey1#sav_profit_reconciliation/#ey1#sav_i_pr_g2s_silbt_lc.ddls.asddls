@AbapCatalog.sqlViewName: '/EY1/PRG2SSBTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- PR- G2S-STAT Inc/Loss Before Tax LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_G2S_SILBT_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_CYTE_GILBT_LC
                 ( p_toperiod:$parameters.p_toperiod,
                       p_ryear:$parameters.p_ryear,
                       p_taxintention:$parameters.p_taxintention)  as GaapIncLossBeforeTax

    left outer join /EY1/SAV_I_PR_G2S_Total_LC ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention) as TotalG2S on  GaapIncLossBeforeTax.ChartOfAccounts              = TotalG2S.ChartOfAccounts
                                                                                 and GaapIncLossBeforeTax.ConsolidationChartofAccounts = TotalG2S.ConsolidationChartofAccounts
                                                                                 and GaapIncLossBeforeTax.ConsolidationUnit            = TotalG2S.ConsolidationUnit
                                                                                 and GaapIncLossBeforeTax.FiscalYear                   = TotalG2S.FiscalYear
{
      //GaapIncLossBeforeTax
  key GaapIncLossBeforeTax.ChartOfAccounts,
  key GaapIncLossBeforeTax.ConsolidationUnit,
  key GaapIncLossBeforeTax.ConsolidationChartofAccounts,
  key GaapIncLossBeforeTax.FiscalYear,
      GaapIncLossBeforeTax.ConsolidationDimension,
      @Semantics.currencyCode: true
      GaapIncLossBeforeTax.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case
          when GAAPIncomeLossBT is null then TotalG2S
          when TotalG2S is null then GAAPIncomeLossBT
          else GAAPIncomeLossBT + TotalG2S
      end as STATIncomeLossBT
}

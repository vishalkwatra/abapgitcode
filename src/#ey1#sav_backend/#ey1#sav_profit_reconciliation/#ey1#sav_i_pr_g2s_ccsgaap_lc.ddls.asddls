@AbapCatalog.sqlViewName: '/EY1/PRG2SCCSGLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- G2S - Details Cross Check SGAAP LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_G2S_CCSGAAP_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_G2S_SILBT_LC
                 ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as SILBT
    left outer join /EY1/SAV_I_PR_G2S_ReconChk_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as ReconCheck on  ReconCheck.ChartOfAccounts              = SILBT.ChartOfAccounts
                                                                               and ReconCheck.ConsolidationUnit            = SILBT.ConsolidationUnit
                                                                               and ReconCheck.ConsolidationChartofAccounts = SILBT.ConsolidationChartofAccounts
                                                                               and ReconCheck.FiscalYear                   = SILBT.FiscalYear
{
  key ReconCheck.ChartOfAccounts,
  key ReconCheck.ConsolidationUnit,
  key ReconCheck.ConsolidationChartofAccounts,
  key ReconCheck.FiscalYear,
      ReconCheck.ConsolidationDimension,

      @Semantics.currencyCode: true
      ReconCheck.LocalCurrency,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      case
      when STATIncomeLossBT is null then cast( 0 as abap.curr(23,2)) - ReconciliationCheck
      when ReconciliationCheck is null then STATIncomeLossBT
      else STATIncomeLossBT - ReconciliationCheck
      end as ReconciliationCheck
}

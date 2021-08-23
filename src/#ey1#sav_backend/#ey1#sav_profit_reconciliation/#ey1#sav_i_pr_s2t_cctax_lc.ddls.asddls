@AbapCatalog.sqlViewName: '/EY1/PRS2TCCTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR - S2T -Details Cross Check Tax LC'
@VDM.viewType: #COMPOSITE
define view /EY1/SAV_I_PR_S2T_CCTax_LC
  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_S2T_FPLBT_LC
                 ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as FPLBT
    left outer join /EY1/SAV_I_PR_S2T_ReconChk_LC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as ReconCheck on  ReconCheck.ChartOfAccounts              = FPLBT.ChartOfAccounts
                                                                               and ReconCheck.ConsolidationUnit            = FPLBT.ConsolidationUnit
                                                                               and ReconCheck.ConsolidationChartofAccounts = FPLBT.ConsolidationChartofAccounts
                                                                               and ReconCheck.FiscalYear                   = FPLBT.FiscalYear
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
      when FiscalIncomeLossBT is null then cast( 0 as abap.curr(23,2)) - ReconciliationCheck
      when ReconciliationCheck is null then FiscalIncomeLossBT
      else FiscalIncomeLossBT - ReconciliationCheck
      end as ReconciliationCheck
}

@AbapCatalog.sqlViewName: '/EY1/PRCYTECCRGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- CYTE - Details Cross Check RGAAP GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CYTE_CCRGAAP_GC  with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_CYTE_GILBT_GC
                 ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as GILBT
    left outer join /EY1/SAV_I_PR_CYTE_ReconChk_GC
                    ( p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear,
                    p_taxintention:$parameters.p_taxintention) as ReconCheck on  ReconCheck.ChartOfAccounts              = GILBT.ChartOfAccounts
                                                                               and ReconCheck.ConsolidationUnit            = GILBT.ConsolidationUnit
                                                                               and ReconCheck.ConsolidationChartofAccounts = GILBT.ConsolidationChartofAccounts
                                                                               and ReconCheck.FiscalYear                   = GILBT.FiscalYear
{
  key ReconCheck.ChartOfAccounts,
  key ReconCheck.ConsolidationUnit,
  key ReconCheck.ConsolidationChartofAccounts,
  key ReconCheck.FiscalYear,
      ReconCheck.ConsolidationDimension,

      @Semantics.currencyCode: true
      ReconCheck.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case
      when GAAPIncomeLossBT is null then cast( 0 as abap.curr(23,2)) - ReconciliationCheck
      when ReconciliationCheck is null then GAAPIncomeLossBT
      else GAAPIncomeLossBT - ReconciliationCheck
      end as ReconciliationCheck
}

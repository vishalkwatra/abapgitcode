@AbapCatalog.sqlViewName: '/EY1/PRCYTEGBTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View - PR- CYTE - GAAP Inc/Loss Before Tax GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_PR_CYTE_GILBT_GC with parameters
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_PR_PBT_GC
                 ( p_toperiod:$parameters.p_toperiod,
                       p_ryear:$parameters.p_ryear,
                       p_taxintention:$parameters.p_taxintention)  as PBTGILCY

    left outer join /EY1/SAV_I_PR_CYTE_Total_GC ( p_toperiod:$parameters.p_toperiod,
                        p_ryear:$parameters.p_ryear,
                        p_taxintention:$parameters.p_taxintention) as ToatlCYTE on  PBTGILCY.ChartOfAccounts              = ToatlCYTE.ChartOfAccounts
                                                                                  and PBTGILCY.ConsolidationChartofAccounts = ToatlCYTE.ConsolidationChartofAccounts
                                                                                  and PBTGILCY.ConsolidationUnit            = ToatlCYTE.ConsolidationUnit
                                                                                  and PBTGILCY.FiscalYear                   = ToatlCYTE.FiscalYear
{
      //PBTGILCY
  key PBTGILCY.ChartOfAccounts,
  key PBTGILCY.ConsolidationUnit,
  key PBTGILCY.ConsolidationChartofAccounts,
  key PBTGILCY.FiscalYear,
      PBTGILCY.ConsolidationDimension,

      @Semantics.currencyCode: true
      PBTGILCY.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case
      when GAAPIncomeLossCY is null then cast( 0 as abap.curr(23,2)) - TotalCYTE
      when TotalCYTE is null then GAAPIncomeLossCY
      else GAAPIncomeLossCY - TotalCYTE
      end as GAAPIncomeLossBT
}

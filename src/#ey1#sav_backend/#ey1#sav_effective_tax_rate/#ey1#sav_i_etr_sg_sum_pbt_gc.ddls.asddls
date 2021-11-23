@AbapCatalog.sqlViewName: '/EY1/ETRSGPBTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- SGAAP- Summary Section- PBT GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_SUM_PBT_GC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_intention : /ey1/sav_intent
  as select from    /EY1/SAV_I_GlAcc_ETR_MD
                 ( p_ryear:$parameters.p_ryear )                   as GlAccMasterData
    left outer join /EY1/SAV_I_Rec_STAT_OB_YB_GC
                    ( p_ryear:$parameters.p_ryear,
                    p_fromyb:$parameters.p_fromperiod,
                    p_toyb:$parameters.p_toperiod,
                    p_switch:$parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_intention: $parameters.p_intention ) as SGAAPCB on  SGAAPCB.ChartOfAccounts              = GlAccMasterData.ChartOfAccounts
                                                                              and SGAAPCB.ConsolidationUnit            = GlAccMasterData.ConsolidationUnit
                                                                              and SGAAPCB.GLAccount                    = GlAccMasterData.GLAccount
                                                                              and SGAAPCB.AccountClassCode             = GlAccMasterData.AccountClassCode
                                                                              and SGAAPCB.FiscalYear                   = GlAccMasterData.FiscalYear
                                                                              and SGAAPCB.GroupCurrency                = GlAccMasterData.GroupCurrency
{
  key  GlAccMasterData.ConsolidationChartofAccounts,
  key  GlAccMasterData.ChartOfAccounts,
  key  GlAccMasterData.ConsolidationDimension,
  key  GlAccMasterData.FiscalYear,
  key  GlAccMasterData.ConsolidationUnit,
       GlAccMasterData.GroupCurrency,
       //RGAAPCB
       ConsolidationLedger,
       sum(StatClosingBalance) as PBT
}
group by
  GlAccMasterData.ConsolidationChartofAccounts,
  GlAccMasterData.ChartOfAccounts,
  GlAccMasterData.ConsolidationUnit,
  GlAccMasterData.ConsolidationDimension,
  ConsolidationLedger,
  GlAccMasterData.FiscalYear,
  GlAccMasterData.GroupCurrency

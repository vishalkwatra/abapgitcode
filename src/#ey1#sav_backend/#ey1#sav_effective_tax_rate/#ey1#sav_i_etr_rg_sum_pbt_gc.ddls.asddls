@AbapCatalog.sqlViewName: '/EY1/ETRSUMPBTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP- Summary Section- PBT GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RG_SUM_PBT_GC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod        : poper,
    p_toperiod          : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ETR_MD
                 ( p_ryear:$parameters.p_ryear )                   as GlAccMasterData
    left outer join /EY1/SAV_I_Rec_GAAP_OB_YB_GC
                    ( p_ryear:$parameters.p_ryear,
                    p_fromyb:$parameters.p_fromperiod,
                    p_toyb:$parameters.p_toperiod,
                    p_switch:$parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention ) as RGAAPCB on  RGAAPCB.ConsolidationChartOfAccounts = GlAccMasterData.ConsolidationChartofAccounts
                                                                              and RGAAPCB.ChartOfAccounts              = GlAccMasterData.ChartOfAccounts
                                                                              and RGAAPCB.ConsolidationUnit            = GlAccMasterData.ConsolidationUnit
                                                                              and RGAAPCB.GLAccount                    = GlAccMasterData.GLAccount
                                                                              and RGAAPCB.AccountClassCode             = GlAccMasterData.AccountClassCode
                                                                              and RGAAPCB.FiscalYear                   = GlAccMasterData.FiscalYear
                                                                              and RGAAPCB.GroupCurrency                = GlAccMasterData.GroupCurrency
{
  key  GlAccMasterData.ConsolidationChartofAccounts,
  key  GlAccMasterData.ChartOfAccounts,
  key  GlAccMasterData.ConsolidationDimension,
  key  GlAccMasterData.FiscalYear,
  key  GlAccMasterData.ConsolidationUnit,
       GlAccMasterData.GroupCurrency,
       //RGAAPCB
       ConsolidationLedger,
       sum(GaapClosingBalance) as PBT
}
group by
  GlAccMasterData.ConsolidationChartofAccounts,
  GlAccMasterData.ChartOfAccounts,
  GlAccMasterData.ConsolidationUnit,
  GlAccMasterData.ConsolidationDimension,
  ConsolidationLedger,
  GlAccMasterData.FiscalYear,
  GlAccMasterData.GroupCurrency

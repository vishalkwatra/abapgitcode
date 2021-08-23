@AbapCatalog.sqlViewName: '/EY1/ETRSGPBTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- SGAAP- Summary Section- PBT LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_SUM_PBT_LC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ETR_MD
                 ( p_ryear:$parameters.p_ryear )                   as GlAccMasterData
    left outer join /EY1/SAV_I_Rec_STAT_OB_YB_LC
                    ( p_ryear:$parameters.p_ryear,
                    p_toyb:$parameters.p_toperiod,
                    p_fromyb:$parameters.p_fromperiod,
                    p_taxintention: $parameters.p_taxintention ) as SGAAPCB on  SGAAPCB.ChartOfAccounts        = GlAccMasterData.ChartOfAccounts
                                                                              and SGAAPCB.ConsolidationDimension = GlAccMasterData.ConsolidationDimension
                                                                              and SGAAPCB.ConsolidationUnit      = GlAccMasterData.ConsolidationUnit
                                                                              and SGAAPCB.GLAccount              = GlAccMasterData.GLAccount
                                                                              and SGAAPCB.AccountClassCode       = GlAccMasterData.AccountClassCode
                                                                              and SGAAPCB.FiscalYear             = GlAccMasterData.FiscalYear
                                                                              and SGAAPCB.LocalCurrency          = GlAccMasterData.LocalCurrency
{
  key  GlAccMasterData.ConsolidationChartofAccounts,
  key  GlAccMasterData.ChartOfAccounts,
  key  GlAccMasterData.ConsolidationDimension,
  key  GlAccMasterData.FiscalYear,
  key  GlAccMasterData.ConsolidationUnit,
       GlAccMasterData.LocalCurrency,
       //SGAAPCB
       ConsolidationLedger,
       sum(StatClosingBalance) as PBT
}
group by
  GlAccMasterData.ConsolidationChartofAccounts,
  GlAccMasterData.ChartOfAccounts,
  GlAccMasterData.ConsolidationDimension,
  GlAccMasterData.ConsolidationUnit,
  ConsolidationLedger,
  GlAccMasterData.FiscalYear,
  GlAccMasterData.LocalCurrency

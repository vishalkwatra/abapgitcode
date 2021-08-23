@AbapCatalog.sqlViewName: '/EY1/ETRSUMPBTLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- RGAAP- Summary Section- PBT LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RG_SUM_PBT_LC
  with parameters
    p_ryear         : gjahr,
    p_fromperiod        : poper,
    p_toperiod          : poper,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_GlAcc_ETR_MD
                 ( p_ryear:$parameters.p_ryear )                   as GlAccMasterData
    left outer join /EY1/SAV_I_Rec_GAAP_OB_YB_LC
                    ( p_ryear:$parameters.p_ryear,
                    p_fromyb:$parameters.p_fromperiod,
                    p_toyb:$parameters.p_toperiod,
                    p_taxintention: $parameters.p_taxintention ) as RGAAPCB on  RGAAPCB.ConsolidationChartOfAccounts = GlAccMasterData.ConsolidationChartofAccounts
                                                                              and RGAAPCB.ChartOfAccounts              = GlAccMasterData.ChartOfAccounts
                                                                              and RGAAPCB.ConsolidationUnit            = GlAccMasterData.ConsolidationUnit
                                                                              and RGAAPCB.GLAccount                    = GlAccMasterData.GLAccount
                                                                              and RGAAPCB.AccountClassCode             = GlAccMasterData.AccountClassCode
                                                                              and RGAAPCB.FiscalYear                   = GlAccMasterData.FiscalYear
                                                                              and RGAAPCB.LocalCurrency                = GlAccMasterData.LocalCurrency
{
  key  GlAccMasterData.ConsolidationChartofAccounts,
  key  GlAccMasterData.ChartOfAccounts,
  key  ConsolidationDimension,
  key  GlAccMasterData.FiscalYear,
  key  GlAccMasterData.ConsolidationUnit,
       GlAccMasterData.LocalCurrency,
       //RGAAPCB
       ConsolidationLedger,
       sum(GaapClosingBalance) as PBT
}
group by
  GlAccMasterData.ConsolidationChartofAccounts,
  GlAccMasterData.ChartOfAccounts,
  GlAccMasterData.ConsolidationUnit,
  ConsolidationDimension,
  ConsolidationLedger,
  GlAccMasterData.FiscalYear,
  GlAccMasterData.LocalCurrency

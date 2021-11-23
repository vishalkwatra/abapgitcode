@AbapCatalog.sqlViewName: '/EY1/ETRSPYADTGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ETR SGaap PYA DTRF PL GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_PYA_DTRPL_GC
  with parameters
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit
  as select from    /EY1/SAV_I_GlAcc_BSEQTE_MD
                 ( p_ryear: $parameters.p_ryear)    as MasterData

  // Left outer join to map the Transaction Data
    left outer join /EY1/SAV_I_DTRF_SGAAP_PYA_PLGC(
                    p_ryear: $parameters.p_ryear,
                    p_taxintention: $parameters.p_taxintention,
                    p_toperiod:$parameters.p_toperiod ,
                    p_rbunit:$parameters.p_rbunit ) as PLTransactions on  PLTransactions.ConsolidationChartOfAccounts = MasterData.ConsolidationChartofAccounts
                                                                      and PLTransactions.ChartOfAccounts              = MasterData.ChartOfAccounts
                                                                      and PLTransactions.ConsolidationUnit            = MasterData.ConsolidationUnit
                                                                      and PLTransactions.GLAccount                    = MasterData.GLAccount
                                                                      and PLTransactions.FiscalYear                   = MasterData.FiscalYear
{

  key     MasterData.ConsolidationChartofAccounts,
  key     MasterData.ChartOfAccounts,
  key     MasterData.ConsolidationUnit,
  key     MasterData.GLAccount,
  key     AccountClassCode,
  key     MasterData.FiscalYear,
          MasterData.GroupCurrency,
          BsEqPl,
          TaxEffected,

          GAAPPYAGC                            as TaxAmount,
          fltp_to_dec( 0.01 as abap.dec(2,2) ) as MultiFactor



}

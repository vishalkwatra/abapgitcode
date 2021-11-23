@AbapCatalog.sqlViewName: '/EY1/STATOBNRGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Recon Stat OB Normalize GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_STAT_OBNR_GC
  with parameters
    p_ryear        : gjahr,
    p_periodto     : poper,
    p_taxintention : zz1_taxintention,
    p_intention    : /ey1/sav_intent
  as select from    /EY1/SAV_I_Rec_STAT_OB_GC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ) as OB
    left outer join /EY1/SAV_I_Rec_STAT_OBPYA_GC(
                    p_ryear:$parameters.p_ryear ,
                    p_periodto:$parameters.p_periodto,
                    p_taxintention:$parameters.p_intention  )   as OBPYA on  OBPYA.GLAccount         = OB.GLAccount
                                                                         and OBPYA.ConsolidationUnit = OB.ConsolidationUnit
{
  key OB.ConsolidationLedger,
  key OB.ConsolidationDimension,
  key OB.FiscalYear,
      OB.ChartOfAccounts,
      OB.ConsolidationUnit,
      OB.GLAccount,
      OB.ConsolidationVersion,
      cast( case when StatOpeningBalance is null then StatPYAOB
                           when StatPYAOB is null then StatOpeningBalance
                           else StatOpeningBalance + StatPYAOB end as abap.curr(23,2)) as StatOpeningBalance,

      OB.GroupCurrency
}

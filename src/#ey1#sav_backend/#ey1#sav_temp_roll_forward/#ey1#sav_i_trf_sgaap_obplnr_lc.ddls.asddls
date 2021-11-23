@AbapCatalog.sqlViewName: '/EY1/ISGOBPLNRLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP OB PL NR LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_OBPLNR_LC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select from    /EY1/SAV_I_TRF_SGAAP_OB_PL_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ) as OBPl
    left outer join /EY1/SAV_I_TRF_SGAAP_OBPYPL_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention,
                     p_toperiod :$parameters.p_toperiod )    as OBPYA on  OBPYA.GLAccount         = OBPl.GLAccount
                                                                         and OBPYA.ConsolidationUnit = OBPl.ConsolidationUnit
{

  key OBPl.ChartOfAccounts,
  key OBPl.ConsolidationUnit,
  key OBPl.ConsolidationChartOfAccounts,
  key OBPl.GLAccount,
      cast( case when PlOpeningBalance is null then PYAOBPl
                           when PYAOBPl is null then PlOpeningBalance
                           else PlOpeningBalance + PYAOBPl end as abap.curr(23,2)) as PlOpeningBalance,

      OBPl.LocalCurrency
}

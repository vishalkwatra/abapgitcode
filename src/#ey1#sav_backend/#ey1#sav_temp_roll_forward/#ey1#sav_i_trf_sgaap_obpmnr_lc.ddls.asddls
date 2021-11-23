@AbapCatalog.sqlViewName: '/EY1/ISGOBPMNRLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fws SGAAP OB Pmt Normalize LC'
define view /EY1/SAV_I_TRF_SGAAP_OBPmNR_LC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select from    /EY1/SAV_I_TRF_SGAAP_OB_PMT_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ) as OBPmt
    left outer join /EY1/SAV_I_TRF_SGAAP_OBPYPm_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention,
                     p_toperiod :$parameters.p_toperiod )    as OBPYA on  OBPYA.GLAccount         = OBPmt.GLAccount
                                                                         and OBPYA.ConsolidationUnit = OBPmt.ConsolidationUnit
{

  key OBPmt.ChartOfAccounts,
  key OBPmt.ConsolidationUnit,
  key OBPmt.ConsolidationChartOfAccounts,
  key OBPmt.GLAccount,
      cast( case when PmntOpeningBalance is null then PYAOBPmt
                           when PYAOBPmt is null then PmntOpeningBalance
                           else PmntOpeningBalance + PYAOBPmt end as abap.curr(23,2)) as PmntOpeningBalance,

      OBPmt.LocalCurrency
}

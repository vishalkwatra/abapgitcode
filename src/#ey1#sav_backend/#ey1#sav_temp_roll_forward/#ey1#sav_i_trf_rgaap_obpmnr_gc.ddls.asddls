@AbapCatalog.sqlViewName: '/EY1/IRGOBPMNRGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP OB Pmt Normalize GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_OBPmNR_GC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper 
  as select from    /EY1/SAV_I_TRF_RGAAP_OB_PMT_GC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ) as OBPmt
    left outer join /EY1/SAV_I_TRF_RGAAP_OBPYPm_GC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention,
                    p_toperiod :$parameters.p_toperiod  )    as OBPYA on  OBPYA.GLAccount         = OBPmt.GLAccount
                                                                         and OBPYA.ConsolidationUnit = OBPmt.ConsolidationUnit
{

  key OBPmt.ChartOfAccounts,
  key OBPmt.ConsolidationUnit,
  key OBPmt.ConsolidationChartOfAccounts,
  key OBPmt.GLAccount,
      cast( case when PmntOpeningBalance is null then PYAOBPmt
                           when PYAOBPmt is null then PmntOpeningBalance
                           else PmntOpeningBalance + PYAOBPmt end as abap.curr(23,2)) as PmntOpeningBalance,

      OBPmt.GroupCurrency
}

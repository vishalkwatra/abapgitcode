@AbapCatalog.sqlViewName: '/EY1/ISGOBEQNRLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fws SGAAP OB EQ Normalize LC'
define view /EY1/SAV_I_TRF_SGAAP_OBEqNR_LC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select from    /EY1/SAV_I_TRF_SGAAP_OB_EQ_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ) as OBEq
    left outer join /EY1/SAV_I_TRF_SGAAP_OBPYEq_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention,
                     p_toperiod :$parameters.p_toperiod )    as OBPYA on  OBPYA.GLAccount         = OBEq.GLAccount
                                                                         and OBPYA.ConsolidationUnit = OBEq.ConsolidationUnit
{

  key OBEq.ChartOfAccounts,
  key OBEq.ConsolidationUnit,
  key OBEq.ConsolidationChartOfAccounts,
  key OBEq.GLAccount,
      cast( case when EqOpeningBalance is null then PYAOBEq
                           when PYAOBEq is null then EqOpeningBalance
                           else EqOpeningBalance + PYAOBEq end as abap.curr(23,2)) as EqOpeningBalance,

      OBEq.LocalCurrency
}

@AbapCatalog.sqlViewName: '/EY1/IRGPYANRMGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd RGAAP PYA Normalize GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_RGAAP_PYA_NR_GC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select distinct from /EY1/SAV_I_GlAcc_TRF_MD
                          ( p_ryear:$parameters.p_ryear )           as GLAccnt

    left outer join       /EY1/SAV_I_TRF_RGAAP_PYA_PL_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )      as PYAPl  on  PYAPl.GLAccount         = GLAccnt.GLAccount
                                                                              and PYAPl.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_TRF_RGAAP_PYA_OP_GC
                    ( p_ryear:$parameters.p_ryear,
                              p_taxintention :$parameters.p_taxintention,
                              p_toperiod :$parameters.p_toperiod  ) as PYAOPl on  PYAOPl.GLAccount         = GLAccnt.GLAccount
                                                                              and PYAOPl.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_RGAAP_PYA_Pm_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod  )     as PYAPm  on  PYAPm.GLAccount         = GLAccnt.GLAccount
                                                                              and PYAPm.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_TRF_RGAAP_PY_OPm_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )      as PYAOPm on  PYAOPm.GLAccount         = GLAccnt.GLAccount
                                                                              and PYAOPm.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_I_TRF_RGAAP_PYA_Eq_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )      as PYAEq  on  PYAEq.GLAccount         = GLAccnt.GLAccount
                                                                              and PYAEq.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_TRF_RGAAP_PYA_OE_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )      as PYAOEq on  PYAOEq.GLAccount         = GLAccnt.GLAccount
                                                                              and PYAOEq.ConsolidationUnit = GLAccnt.ConsolidationUnit


{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAPLAmount is null then PlaceholderCurrency
      else PYAPLAmount end  as PYAPLAmount,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAOPLAmount is null then PlaceholderCurrency
      else PYAOPLAmount end as PYAOpl,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAPmnt is null then PlaceholderCurrency
      else PYAPmnt end      as PYAPmnt,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAEq is null then PlaceholderCurrency
      else PYAEq end        as PYAEq,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAOpmnt is null then PlaceholderCurrency
      else PYAOpmnt end     as PYAOpmnt,
      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAOeq is null then PlaceholderCurrency
      else PYAOeq end       as PYAOeq

}

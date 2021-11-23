@AbapCatalog.sqlViewName: '/EY1/ISGPYANRMGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Temp Roll Fwd SGAAP PYA Normalize GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_TRF_SGAAP_PYA_NR_GC
  with parameters
    p_ryear        : gjahr,
    //    p_specialperiod : zz1_specialperiod
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper
  as select distinct from /EY1/SAV_I_GlAcc_TRF_MD
                          ( p_ryear:$parameters.p_ryear )                 as GLAccnt

    left outer join       /EY1/SAV_I_TRF_SGAAP_PYA_PL_GC
                    ( p_ryear:$parameters.p_ryear,
                          p_taxintention :$parameters.p_taxintention,
                          p_toperiod :$parameters.p_toperiod )            as PYAPl   on  PYAPl.GLAccount         = GLAccnt.GLAccount
                                                                                     and PYAPl.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_I_TRF_SGAAP_PYA_OP_GC
                    ( p_ryear:$parameters.p_ryear,
                              p_taxintention :$parameters.p_taxintention,
                              p_toperiod :$parameters.p_toperiod  )       as PYAOPl  on  PYAOPl.GLAccount         = GLAccnt.GLAccount
                                                                                     and PYAOPl.ConsolidationUnit = GLAccnt.ConsolidationUnit


    left outer join       /EY1/SAV_ITRF_SGAAP_PYA_Pmt_GC
                    ( p_ryear:$parameters.p_ryear,
                                     p_taxintention :$parameters.p_taxintention,
                                     p_toperiod :$parameters.p_toperiod ) as PYAPMT  on  PYAPMT.GLAccount         = GLAccnt.GLAccount
                                                                                     and PYAPMT.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_ITRF_SGAAP_PYA_EQ_GC
                    ( p_ryear:$parameters.p_ryear,
                                    p_taxintention :$parameters.p_taxintention,
                                    p_toperiod :$parameters.p_toperiod )  as PYAEQ   on  PYAEQ.GLAccount         = GLAccnt.GLAccount
                                                                                     and PYAEQ.ConsolidationUnit = GLAccnt.ConsolidationUnit
    left outer join       /EY1/SAV_ITRF_SGAAP_PYAOpmt_GC
                    ( p_ryear:$parameters.p_ryear,
                                    p_taxintention :$parameters.p_taxintention,
                                    p_toperiod :$parameters.p_toperiod )  as PYAOpmt on  PYAOpmt.GLAccount         = GLAccnt.GLAccount
                                                                                     and PYAOpmt.ConsolidationUnit = GLAccnt.ConsolidationUnit

    left outer join       /EY1/SAV_ITRF_SGAAP_PYAOEQ_GC
                    ( p_ryear:$parameters.p_ryear,
                                    p_taxintention :$parameters.p_taxintention,
                                    p_toperiod :$parameters.p_toperiod )  as PYAOEQ  on  PYAOEQ.GLAccount         = GLAccnt.GLAccount
                                                                                     and PYAOEQ.ConsolidationUnit = GLAccnt.ConsolidationUnit



{
  key GLAccnt.ChartOfAccounts,
  key GLAccnt.ConsolidationUnit,
  key GLAccnt.ConsolidationChartofAccounts,
  key GLAccnt.GLAccount,

      GLAccnt.ConsolidationDimension,
      GLAccnt.FinancialStatementItem,
      @Semantics.currencyCode: true
      GLAccnt.GroupCurrency,

      //      //@Semantics.amount.currencyCode: 'LocalCurrency'
      //      case when EqOpeningBalance is null then PlaceholderCurrency
      //      else EqOpeningBalance end   as EqOpeningBalance,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAPLAmount is null then PlaceholderCurrency
      else PYAPLAmount end            as PYAPLAmount,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAOPLAmount is null then PlaceholderCurrency
      else PYAOPLAmount end           as PYAOpl,


      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAPMT.PYAPMTAmount is null then PlaceholderCurrency
      else PYAPMT.PYAPMTAmount end    as PYAPmnt,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAEQ.PYAEqAmount is null then PlaceholderCurrency
      else PYAEQ.PYAEqAmount end      as PYAEq,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAOpmt.PYAOpmntAmount is null then PlaceholderCurrency
      else PYAOpmt.PYAOpmntAmount end as PYAOpmnt,

      @Semantics.amount.currencyCode: 'GroupCurrency'
      case when PYAOEQ.PYAOEQAmount is null then PlaceholderCurrency
      else PYAOEQ.PYAOEQAmount end    as PYAOeq


      //      //@Semantics.amount.currencyCode: 'LocalCurrency'
      //      case when PmntOpeningBalance is null then PlaceholderCurrency
      //      else PmntOpeningBalance end as PmntOpeningBalance
}

@AbapCatalog.sqlViewName: '/EY1/IDRGPYANRGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View DTRF PYA Normalize GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_RGAAP_PYANR_GC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper,
    p_rbunit       : fc_bunit
  as select from    /EY1/SAV_I_GlAcc_DTRF_MD (p_ryear : $parameters.p_ryear)             as GLAccnt
    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_PLGC(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit ) as PYA

                                                                                                   on  GLAccnt.ConsolidationUnit = PYA.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYA.GLAccount

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_EQGC(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit)  as PYAEQ  on  GLAccnt.ConsolidationUnit = PYAEQ.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYAEQ.GLAccount

    left outer join /EY1/SAV_I_DTRF_RGAAPPYA_OPlGC(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit)  as PYAOPl on  GLAccnt.ConsolidationUnit = PYAOPl.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYAOPl.GLAccount

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYAOEqGC(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit)  as PYAOeq on  GLAccnt.ConsolidationUnit = PYAOeq.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYAOeq.GLAccount
{
        //GLAccnt
  key   GLAccnt.ChartOfAccounts,
  key   GLAccnt.ConsolidationUnit,
  key   GLAccnt.ConsolidationChartofAccounts,
  key   GLAccnt.GLAccount,
  key   GLAccnt.FiscalYear,
  key   GLAccnt.ConsolidationDimension,
        GLAccnt.FinancialStatementItem,

        PYA.GroupCurrency,


        @Semantics.amount.currencyCode: 'GroupCurrency'
        case when PYA.GAAPPYAGC  is null then cast (0 as abap.curr( 23, 2))
        else PYA.GAAPPYAGC  end          as PYAPl,


        @Semantics.amount.currencyCode: 'GroupCurrency'
        case when  PYAEQ.GAAPPYAGC   is null then cast (0 as abap.curr( 23, 2))
        else  PYAEQ.GAAPPYAGC   end      as PYAEq,



        @Semantics.amount.currencyCode: 'GroupCurrency'
        case when   PYAOPl.GAAPPYAGC     is null then cast (0 as abap.curr( 23, 2))
        else   PYAOPl.GAAPPYAGC     end  as PYAOpl,


        @Semantics.amount.currencyCode: 'GroupCurrency'
        case when    PYAOeq.GAAPPYAGC       is null then cast (0 as abap.curr( 23, 2))
        else   PYAOeq.GAAPPYAGC      end as PYAOeq
}
where
  GLAccnt.FiscalYear = :p_ryear

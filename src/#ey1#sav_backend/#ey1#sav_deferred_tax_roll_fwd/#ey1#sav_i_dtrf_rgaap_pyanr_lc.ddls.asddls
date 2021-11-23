@AbapCatalog.sqlViewName: '/EY1/IDRGPYANRLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View DTRF PYA Normalize LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_RGAAP_PYANR_LC
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention,
    p_toperiod     : poper,
    p_rbunit       : fc_bunit
  as select from    /EY1/SAV_I_GlAcc_DTRF_MD (p_ryear : $parameters.p_ryear)             as GLAccnt
    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_PL(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit ) as PYA

                                                                                                   on  GLAccnt.ConsolidationUnit = PYA.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYA.GLAccount

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_EQ(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit)  as PYAEQ  on  GLAccnt.ConsolidationUnit = PYAEQ.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYAEQ.GLAccount

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_OPl(p_ryear : $parameters.p_ryear,
                                                 p_taxintention : $parameters.p_taxintention,
                                                 p_toperiod     : $parameters.p_toperiod,
                                                 p_rbunit       : $parameters.p_rbunit)  as PYAOPl on  GLAccnt.ConsolidationUnit = PYAOPl.ConsolidationUnit
                                                                                                   and GLAccnt.GLAccount         = PYAOPl.GLAccount

    left outer join /EY1/SAV_I_DTRF_RGAAP_PYA_OEq(p_ryear : $parameters.p_ryear,
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
        PYA.LocalCurrency,


        @Semantics.amount.currencyCode: 'LocalCurrency'
        case when PYA.GAAPPYALC  is null then cast (0 as abap.curr( 23, 2))
        else PYA.GAAPPYALC  end          as PYAPl,


        @Semantics.amount.currencyCode: 'LocalCurrency'
        case when  PYAEQ.GAAPPYALC   is null then cast (0 as abap.curr( 23, 2))
        else  PYAEQ.GAAPPYALC   end      as PYAEq,



        @Semantics.amount.currencyCode: 'LocalCurrency'
        case when   PYAOPl.GAAPPYALC     is null then cast (0 as abap.curr( 23, 2))
        else   PYAOPl.GAAPPYALC     end  as PYAOpl,


        @Semantics.amount.currencyCode: 'LocalCurrency'
        case when    PYAOeq.GAAPPYALC       is null then cast (0 as abap.curr( 23, 2))
        else   PYAOeq.GAAPPYALC      end as PYAOeq

        //        ( PYA.GAAPPYALC + PYAEQ.GAAPPYALC + PYAOPl.GAAPPYALC + PYAOeq.GAAPPYALC ) as PYA
        //        --cast (0 as abap.curr( 23, 2)) as PYA
}
where
  GLAccnt.FiscalYear = :p_ryear

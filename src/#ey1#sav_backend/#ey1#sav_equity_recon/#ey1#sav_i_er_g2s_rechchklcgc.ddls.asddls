@AbapCatalog.sqlViewName: '/EY1/ERG2SRCLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ER G2S Rec Check LC GC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_G2S_RechChkLCGC
  with parameters
    p_ryear        : gjahr,
    p_fromyb       : poper,
    p_toyb         : poper,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention

  as select from    /EY1/SAV_I_ER_G2S_CB_RCHK_LCGC(p_ryear:$parameters.p_ryear,
                                                   p_fromyb:$parameters.p_fromyb,
                                                   p_toyb:$parameters.p_toyb,
                                                   p_switch:$parameters.p_switch,
                                                   p_taxintention: $parameters.p_taxintention,
                                                   p_intention: $parameters.p_intention
                                                   )                                           as GLAcc

    left outer join /EY1/SAV_I_ER_G2S_OB_RCHK_LCGC(p_ryear:$parameters.p_ryear,
                                                   p_fromyb:$parameters.p_fromyb,
                                                   p_toyb:$parameters.p_toyb,
                                                   p_switch:$parameters.p_switch,
                                                   p_taxintention: $parameters.p_taxintention,
                                                   p_intention: $parameters.p_intention) as OBRchk on  OBRchk.GLAccount                    = GLAcc.GLAccount
                                                                                                         and OBRchk.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                         and OBRchk.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                         and OBRchk.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                         and OBRchk.FiscalYear                   = GLAcc.FiscalYear
                                                                                                         and OBRchk.CurrencyType                 = GLAcc.CurrencyType
    left outer join /EY1/SAV_I_ER_G2S_YB_RCHK_LCGC(p_ryear:$parameters.p_ryear,
                                                   p_fromyb:$parameters.p_fromyb,
                                                   p_toyb:$parameters.p_toyb,
                                                   p_switch:$parameters.p_switch,
                                                   p_taxintention: $parameters.p_taxintention,
                                                   p_intention: $parameters.p_intention) as YBRchk on  YBRchk.GLAccount                    = GLAcc.GLAccount
                                                                                                         and YBRchk.ConsolidationUnit            = GLAcc.ConsolidationUnit
                                                                                                         and YBRchk.ConsolidationChartofAccounts = GLAcc.ConsolidationChartofAccounts
                                                                                                         and YBRchk.ChartOfAccounts              = GLAcc.ChartOfAccounts
                                                                                                         and YBRchk.FiscalYear                   = GLAcc.FiscalYear
                                                                                                         and YBRchk.CurrencyType                 = GLAcc.CurrencyType
{
      //key GLAcc.GLAccount,
  key GLAcc.ConsolidationDimension,
  key GLAcc.FiscalYear,
      GLAcc.ChartOfAccounts,
      GLAcc.ConsolidationUnit,
      GLAcc.MainCurrency,
      GLAcc.ConsolidationChartofAccounts,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(StatOpeningBalance) as StatOpeningBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(YBClosingBalance)   as YBClosingBalance,

      @Semantics.amount.currencyCode: 'MainCurrency'
      sum(CBClosingBalance)   as CBClosingBalance,

      GLAcc.CurrencyType
}
group by
  GLAcc.ConsolidationDimension,
  GLAcc.FiscalYear,
  GLAcc.ChartOfAccounts,
  GLAcc.ConsolidationUnit,
  GLAcc.MainCurrency,
  GLAcc.ConsolidationChartofAccounts,
  GLAcc.CurrencyType

@AbapCatalog.sqlViewName: '/EY1/ETRSGDDCTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- SGAAP- Diff Deferred & CTR- TempDiff'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_DDCTRTD 
with parameters
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit,
    p_intention     : /ey1/sav_intent
  as select from    /EY1/SAV_I_ETR_SG_DDCTRTDYB
                 ( p_toperiod:$parameters.p_toperiod ,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ,
                    p_rbunit:$parameters.p_rbunit ) as GlAccount

    left outer join /EY1/SAV_I_ETR_SG_SUM_ExpTaxEB
                    ( p_ryear: $parameters.p_ryear,
                    p_fromperiod: $parameters.p_fromperiod,
                    p_toperiod: $parameters.p_toperiod,
                    p_switch: $parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_rbunit: $parameters.p_rbunit,
                    p_intention: $parameters.p_intention) as PBT on  PBT.ConsolidationChartofAccounts = GlAccount.ConsolidationChartofAccounts
                                                           and PBT.ChartOfAccounts              = GlAccount.ChartOfAccounts
                                                           and PBT.ConsolidationUnit            = GlAccount.ConsolidationUnit
                                                           and PBT.FiscalYear                   = GlAccount.FiscalYear
                                                           and PBT.MainCurrency                 = GlAccount.MainCurrency
                                                           and PBT.CurrType                     = GlAccount.CurrencyType
{
  key GlAccount.ConsolidationChartofAccounts,
  key GlAccount.ChartOfAccounts,
  key GlAccount.ConsolidationUnit,
  key GlAccount.ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key GlAccount.FiscalYear,
      GlAccount.MainCurrency,
      ConsolidationLedger,

      PlYearBalance                                                                                                                            as Amount,
      Rate,

      // Tax = (Amount * Rate) / 100
      PlYearBalance * Rate * MultiFactor                                                                                                       as Tax,

      // Percentage = (Tax / PBT) * 100
      case
        when PBT is null then cast(0 as /ey1/sav_rate)
        when PBT = 0 then cast(0 as /ey1/sav_rate)
        else
      ((cast( PlYearBalance * Rate * MultiFactor as abap.fltp(16,16)) / cast (PBT as abap.fltp(16,16))) *  cast (100 as abap.fltp(16,16))) end as Percentage,


      BsEqPl,
      TaxEffected,

      CurrencyType
}

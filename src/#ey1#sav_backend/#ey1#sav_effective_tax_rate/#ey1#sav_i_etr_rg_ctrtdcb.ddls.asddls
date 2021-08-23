@AbapCatalog.sqlViewName: '/EY1/ETRRGCTCBPL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-RGAAP-Change in Tax Rate Effect Temp Diff CB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RG_CTRTDCB
  with parameters
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit
  as select from    /EY1/SAV_I_ETR_RG_CTRTDCBPL
                 ( p_toperiod:$parameters.p_toperiod ,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ,
                    p_rbunit:$parameters.p_rbunit ) as GlAccount

    left outer join /EY1/SAV_I_ETR_RG_SUM_ExpTaxEB
                    ( p_ryear: $parameters.p_ryear,
                    p_fromperiod: $parameters.p_fromperiod,
                    p_toperiod: $parameters.p_toperiod,
                    p_switch: $parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_rbunit: $parameters.p_rbunit) as PBT on  PBT.ConsolidationChartofAccounts = GlAccount.ConsolidationChartofAccounts
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

      PlClosingBalance                                                                                                                            as Amount,
      Rate,

      // Tax = (Amount * Rate) / 100
      PlClosingBalance * Rate * MultiFactor                                                                                                       as Tax,

      // Percentage = (Tax / PBT) * 100
      case
        when PBT is null then cast(0 as /ey1/sav_rate)
        when PBT = 0 then cast(0 as /ey1/sav_rate)
        else
      ((cast( PlClosingBalance * Rate * MultiFactor as abap.fltp(16,16)) / cast (PBT as abap.fltp(16,16))) *  cast (100 as abap.fltp(16,16))) end as Percentage,


      BsEqPl,
      TaxEffected,

      CurrencyType
}

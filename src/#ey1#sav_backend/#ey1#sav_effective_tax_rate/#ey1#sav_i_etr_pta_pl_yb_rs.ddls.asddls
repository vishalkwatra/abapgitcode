@AbapCatalog.sqlViewName: '/EY1/ETRPTARS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-ETR-PTA PL Movement RS for PBT YB'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_PTA_PL_YB_RS
  with parameters
    p_fromperiod    : poper,
    p_ryear         : gjahr,
    p_toperiod      : poper,
    p_rbunit        : fc_bunit,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_reportingType : char5
  as select from    /EY1/SAV_I_ETR_PTA_PL_YB_LCGC( p_ryear:$parameters.p_ryear ,
                    p_toperiod: $parameters.p_toperiod,
                    p_rbunit:$parameters.p_rbunit,
                    p_taxintention:$parameters.p_taxintention ) as PTA

    left outer join /EY1/SAV_I_ETR_RS_SUM_ExpTaxEB( p_ryear:$parameters.p_ryear ,
                    p_fromperiod:$parameters.p_fromperiod ,
                    p_toperiod: $parameters.p_toperiod,
                    p_switch:$parameters.p_switch ,
                    p_taxintention:$parameters.p_taxintention ,
                    p_rbunit:$parameters.p_rbunit )               as PBT on  PBT.ConsolidationChartofAccounts = PTA.ConsolidationChartofAccounts
                                                                         and PBT.ChartOfAccounts              = PTA.ChartOfAccounts
                                                                         and PBT.ConsolidationUnit            = PTA.ConsolidationUnit
                                                                         and PBT.FiscalYear                   = PTA.FiscalYear
                                                                         and PBT.MainCurrency                 = PTA.MainCurrency
                                                                         and PBT.CurrType                     = PTA.CurrencyType
{
  key PTA.ConsolidationChartofAccounts,
  key PTA.ChartOfAccounts,
  key PTA.ConsolidationUnit,
  key PTA.ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key PTA.FiscalYear,
      PTA.MainCurrency,
      ConsolidationLedger,
      PTAAmount,
      Rate,
      // Tax = (Amount * Rate) / 100
      PTAAmount * Rate * MultiFactor                                                                                                       as Tax,

      // Percentage = (Tax / PBT) * 100
      case
        when PBT is null then cast(0 as /ey1/sav_rate)
        when PBT = 0 then cast(0 as /ey1/sav_rate)
        else
      ((cast( PTAAmount * Rate * MultiFactor as abap.fltp(16,16)) / cast (PBT as abap.fltp(16,16))) *  cast (100 as abap.fltp(16,16))) end as Percentage,
      BsEqPl,
      PBT,
      ProfitBeforeTax,
      CurrencyType
}
where
  ReportingType = $parameters.p_reportingType

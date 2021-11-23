@AbapCatalog.sqlViewName: '/EY1/ETRSUMTPNML'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- Summary- Tax & Percentage Normalize'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SUM_ETRTE_TP_NL
  with parameters
    p_cntry        : land1,
    p_ryear        : gjahr,
    p_fromperiod   : poper,
    p_toperiod     : poper,
    p_intention    : /ey1/sav_intent,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit

  as select from    /EY1/SAV_I_ETR_RS_SUM_ExpTaxEB
                 ( p_ryear:$parameters.p_ryear ,
                                  p_fromperiod: $parameters.p_fromperiod,
                                  p_toperiod: $parameters.p_toperiod,
                                  p_switch: $parameters.p_switch,
                                  p_taxintention: $parameters.p_taxintention,
                                  p_rbunit: $parameters.p_rbunit,
                                  p_intention: $parameters.p_intention) as ExpTaxExpBenefit

    left outer join /EY1/SAV_I_ETR_SUM_ITDCTRTotal
                    ( p_cntry: $parameters.p_cntry,
                        p_ryear: $parameters.p_ryear,
                        p_intention: $parameters.p_intention)           as IncTaxAtDiffCTRTotal     on  IncTaxAtDiffCTRTotal.ConsolidationChartofAccounts = ExpTaxExpBenefit.ConsolidationChartofAccounts
                                                                                                    and IncTaxAtDiffCTRTotal.ChartOfAccounts              = ExpTaxExpBenefit.ChartOfAccounts
                                                                                                    and IncTaxAtDiffCTRTotal.FiscalYear                   = ExpTaxExpBenefit.FiscalYear
                                                                                                    and IncTaxAtDiffCTRTotal.ConsolidationUnit            = ExpTaxExpBenefit.ConsolidationUnit
                                                                                                    and IncTaxAtDiffCTRTotal.MainCurrency                 = ExpTaxExpBenefit.MainCurrency

    left outer join /EY1/SAV_I_ETR_SUM_DDCTRTotal
                    ( p_fromperiod: $parameters.p_fromperiod,
                    p_toperiod: $parameters.p_toperiod,
                    p_ryear: $parameters.p_ryear,
                    p_switch: $parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_rbunit: $parameters.p_rbunit,
                    p_intention: $parameters.p_intention)               as DiffDefAndCTETotal       on  DiffDefAndCTETotal.ConsolidationChartofAccounts = ExpTaxExpBenefit.ConsolidationChartofAccounts
                                                                                                    and DiffDefAndCTETotal.ChartOfAccounts              = ExpTaxExpBenefit.ChartOfAccounts
                                                                                                    and DiffDefAndCTETotal.FiscalYear                   = ExpTaxExpBenefit.FiscalYear
                                                                                                    and DiffDefAndCTETotal.ConsolidationUnit            = ExpTaxExpBenefit.ConsolidationUnit
                                                                                                    and DiffDefAndCTETotal.MainCurrency                 = ExpTaxExpBenefit.MainCurrency
                                                                                                    and DiffDefAndCTETotal.CurrencyType                 = ExpTaxExpBenefit.CurrType
                                                                                                    and DiffDefAndCTETotal.ReportingType                = ExpTaxExpBenefit.ReportingType

    left outer join /EY1/SAV_I_ETR_BDTPD_BDDTTotal( p_fromperiod: $parameters.p_fromperiod,
                    p_toperiod:$parameters.p_toperiod ,
                    p_ryear: $parameters.p_ryear,
                    p_switch: $parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_rbunit: $parameters.p_rbunit,
                    p_intention: $parameters.p_intention)               as BasDiffNoDeffTaxCalTotal on  BasDiffNoDeffTaxCalTotal.ConsolidationChartofAccounts = ExpTaxExpBenefit.ConsolidationChartofAccounts
                                                                                                    and BasDiffNoDeffTaxCalTotal.ChartOfAccounts              = ExpTaxExpBenefit.ChartOfAccounts
                                                                                                    and BasDiffNoDeffTaxCalTotal.FiscalYear                   = ExpTaxExpBenefit.FiscalYear
                                                                                                    and BasDiffNoDeffTaxCalTotal.ConsolidationUnit            = ExpTaxExpBenefit.ConsolidationUnit
                                                                                                    and BasDiffNoDeffTaxCalTotal.MainCurrency                 = ExpTaxExpBenefit.MainCurrency
                                                                                                    and BasDiffNoDeffTaxCalTotal.CurrencyType                 = ExpTaxExpBenefit.CurrType
                                                                                                    and BasDiffNoDeffTaxCalTotal.ReportingType                = ExpTaxExpBenefit.ReportingType


    left outer join /EY1/SAV_I_ETR_PTA_Total( p_fromperiod:$parameters.p_fromperiod ,
                    p_ryear:$parameters.p_ryear
                    , p_toperiod:$parameters.p_toperiod ,
                    p_rbunit: $parameters.p_rbunit,
                    p_switch: $parameters.p_switch,
                    p_taxintention:$parameters.p_taxintention,
                    p_intention: $parameters.p_intention)               as PTATotal                 on  PTATotal.ConsolidationChartofAccounts = ExpTaxExpBenefit.ConsolidationChartofAccounts
                                                                                                    and PTATotal.ChartOfAccounts              = ExpTaxExpBenefit.ChartOfAccounts
                                                                                                    and PTATotal.FiscalYear                   = ExpTaxExpBenefit.FiscalYear
                                                                                                    and PTATotal.ConsolidationUnit            = ExpTaxExpBenefit.ConsolidationUnit
                                                                                                    and PTATotal.MainCurrency                 = ExpTaxExpBenefit.MainCurrency
                                                                                                    and PTATotal.CurrencyType                 = ExpTaxExpBenefit.CurrType
                                                                                                    and PTATotal.ReportingType                = ExpTaxExpBenefit.ReportingType

    left outer join /EY1/SAV_I_ETR_CTRTDCBTotal
                    ( p_fromperiod: $parameters.p_fromperiod,
                    p_toperiod: $parameters.p_toperiod,
                    p_ryear: $parameters.p_ryear,
                    p_switch: $parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_rbunit: $parameters.p_rbunit)               as ChngTREffTempDiffTotal   on  ChngTREffTempDiffTotal.ConsolidationChartofAccounts = ExpTaxExpBenefit.ConsolidationChartofAccounts
                                                                                                    and ChngTREffTempDiffTotal.ChartOfAccounts              = ExpTaxExpBenefit.ChartOfAccounts
                                                                                                    and ChngTREffTempDiffTotal.FiscalYear                   = ExpTaxExpBenefit.FiscalYear
                                                                                                    and ChngTREffTempDiffTotal.ConsolidationUnit            = ExpTaxExpBenefit.ConsolidationUnit
                                                                                                    and ChngTREffTempDiffTotal.MainCurrency                 = ExpTaxExpBenefit.MainCurrency
                                                                                                    and ChngTREffTempDiffTotal.CurrencyType                 = ExpTaxExpBenefit.CurrType
                                                                                                    and ChngTREffTempDiffTotal.ReportingType                = ExpTaxExpBenefit.ReportingType
    left outer join /EY1/SAV_I_ETR_RS_PYATotal
                        ( p_fromperiod: $parameters.p_fromperiod,
                        p_toperiod: $parameters.p_toperiod,
                        p_ryear: $parameters.p_ryear,
                        p_switch: $parameters.p_switch,
                        p_taxintention: $parameters.p_taxintention,
                        p_rbunit: $parameters.p_rbunit)                 as PYADTRFTotal             on  PYADTRFTotal.ConsolidationChartofAccounts = ExpTaxExpBenefit.ConsolidationChartofAccounts
                                                                                                    and PYADTRFTotal.ChartOfAccounts              = ExpTaxExpBenefit.ChartOfAccounts
                                                                                                    and PYADTRFTotal.FiscalYear                   = ExpTaxExpBenefit.FiscalYear
                                                                                                    and PYADTRFTotal.ConsolidationUnit            = ExpTaxExpBenefit.ConsolidationUnit
                                                                                                    and PYADTRFTotal.MainCurrency                 = ExpTaxExpBenefit.MainCurrency
                                                                                                    and PYADTRFTotal.CurrencyType                 = ExpTaxExpBenefit.CurrType
                                                                                                    and PYADTRFTotal.ReportingType                = ExpTaxExpBenefit.ReportingType
{
  key   ExpTaxExpBenefit.ConsolidationDimension,
  key   ExpTaxExpBenefit.FiscalYear,
  key   ExpTaxExpBenefit.ConsolidationChartofAccounts,
  key   ExpTaxExpBenefit.ChartOfAccounts,
        ExpTaxExpBenefit.ConsolidationUnit,
        ExpTaxExpBenefit.PBT,

        //        IncTaxAtDiffCTRTotal.CountryKey,
        //        IncTaxAtDiffCTRTotal.Intention,
        ExpTaxExpBenefit.MainCurrency,

        // -----------------------  Percentage fields   ----------------------------
        case
          when IncTaxAtDiffCTRTotal.Percentage is null
          then cast(0 as /ey1/sav_rate)
          else IncTaxAtDiffCTRTotal.Percentage
        end as ITDCTRPercentage,

        case
          when ExpTaxExpBenefit.Percentage is null
          then cast(0 as /ey1/sav_rate)
          else ExpTaxExpBenefit.Percentage
        end as ETEBPercentage,

        case
          when DiffDefAndCTETotal.Percentage is null
          then cast(0 as /ey1/sav_rate)
          else DiffDefAndCTETotal.Percentage
        end as DDCTEPercentage,

        case
          when BasDiffNoDeffTaxCalTotal.Percentage is null
          then cast(0 as /ey1/sav_rate)
          else BasDiffNoDeffTaxCalTotal.Percentage
        end as BDDTPercentage,

        case
         when PTATotal.Percentage is null
         then cast(0 as /ey1/sav_rate)
         else PTATotal.Percentage
        end as PTAPercentage,

        case
         when ChngTREffTempDiffTotal.Percentage is null
         then cast(0 as /ey1/sav_rate)
         else ChngTREffTempDiffTotal.Percentage
        end as CTRTDPercentage,


        case
         when PYADTRFTotal.Percentage is null
         then cast(0 as /ey1/sav_rate)
         else PYADTRFTotal.Percentage
        end as PYADTRFPercentage,

        // -----------------------  TAX fields   ----------------------------
        case
          when IncTaxAtDiffCTRTotal.Tax is null
          then cast(0 as /ey1/sav_rate)
          else IncTaxAtDiffCTRTotal.Tax
        end as ITDCTRTax,

        case
          when ExpTaxExpBenefit.Tax is null
          then cast(0 as /ey1/sav_rate)
          else ExpTaxExpBenefit.Tax
        end as ETEBTax,

        case
          when DiffDefAndCTETotal.Tax is null
          then cast(0 as /ey1/sav_rate)
          else DiffDefAndCTETotal.Tax
        end as DDCTETax,

        case
          when BasDiffNoDeffTaxCalTotal.Tax is null
          then cast(0 as /ey1/sav_rate)
          else BasDiffNoDeffTaxCalTotal.Tax
        end as BDDTTax,

        case
         when PTATotal.Tax is null
         then cast(0 as /ey1/sav_rate)
         else PTATotal.Tax
        end as PTATax,

        case
        when ChngTREffTempDiffTotal.Tax is null
        then cast(0 as /ey1/sav_rate)
        else ChngTREffTempDiffTotal.Tax
        end as CTRTDTax,

        case
        when PYADTRFTotal.Tax is null
        then cast(0 as /ey1/sav_rate)
        else PYADTRFTotal.Tax
        end as PYADTRFTax,


        CurrType,
        ExpTaxExpBenefit.ReportingType
}

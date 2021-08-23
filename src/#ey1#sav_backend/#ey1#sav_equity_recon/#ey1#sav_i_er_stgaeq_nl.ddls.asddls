@AbapCatalog.sqlViewName: '/EY1/ERSGEINL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize ER Stat Gaap Equity Total of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_StGaEq_NL
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_taxintention : zz1_taxintention
  as select from    /EY1/SAV_I_ER_GAAPEQ_Total(p_ryear:$parameters.p_ryear,
                                                p_fromperiod:$parameters.p_fromperiod,
                                                p_toperiod:$parameters.p_toperiod,
                                                p_taxintention: $parameters.p_taxintention) as GAAPEQ
    left outer join /EY1/SAV_I_ER_G2STotal(p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)                              as G2S on  G2S.ConsolidationChartofAccounts = GAAPEQ.ConsolidationChartofAccounts
                                                                                                     and G2S.ChartOfAccounts              = GAAPEQ.ChartOfAccounts
                                                                                                     and G2S.FiscalYear                   = GAAPEQ.FiscalYear
                                                                                                     and G2S.ConsolidationUnit            = GAAPEQ.ConsolidationUnit
                                                                                                     and G2S.MainCurrency                 = GAAPEQ.MainCurrency


{
  key GAAPEQ.ChartOfAccounts,
  key GAAPEQ.ConsolidationUnit,
  key GAAPEQ.ConsolidationChartofAccounts,
  key GAAPEQ.FiscalYear,

      GAAPEQ.ConsolidationDimension,
      GAAPEQ.CurrencyType,
      @Semantics.currencyCode: 'true'
      GAAPEQ.MainCurrency,





      // -----------------------  OB fields   ----------------------------
      case
        when SumGaapOB is null
        then cast(0 as abap.curr( 23, 2))
        else SumGaapOB
      end as GaapOBBalance,

      case
        when SumG2SAdjustAmt is null
        then cast(0 as abap.curr( 23, 2))
        else SumG2SAdjustAmt
      end as G2SOBBalance,

      // -----------------------  PL fields   ----------------------------
      case
        when G2S.SumPlYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumPlYearBalance
      end as G2SPLBalance,

      // -----------------------  Permanent fields   ----------------------------
      case
        when G2S.SumPmtYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumPmtYearBalance
      end as G2SPMTBalance,

      // -----------------------  CYA fields   ----------------------------
      case
        when SumGaapYB is null
        then cast(0 as abap.curr( 23, 2))
        else SumGaapYB
      end as GaapYBBalance,

      case
        when SumG2SCYABalance is null
        then cast(0 as abap.curr( 23, 2))
        else SumG2SCYABalance
      end as G2SYBBalance,

      // -----------------------  EQ fields   ----------------------------
      case
        when SumGaapEQ is null
        then cast(0 as abap.curr( 23, 2))
        else SumGaapEQ
      end as GaapEQBalance,

      case
        when G2S.SumEqTotalYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumEqTotalYearBalance
      end as G2SEQBalance,

      // -----------------------  other fields   ----------------------------
      case
        when G2S.SumOthrTotalYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumOthrTotalYearBalance
      end as G2SOtherBalance,

      // -----------------------  CTA fields   ----------------------------
      case
        when SumGaapCTA is null
        then cast(0 as abap.curr( 23, 2))
        else SumGaapCTA
      end as GaapCTABalance,
      // -----------------------  CB fields   ----------------------------
      case
        when SumGaapCB is null
        then cast(0 as abap.curr( 23, 2))
        else SumGaapCB
      end as GaapCBBalance,

      case
        when G2S.SumCBYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumCBYearBalance
      end as G2SCBBalance


}

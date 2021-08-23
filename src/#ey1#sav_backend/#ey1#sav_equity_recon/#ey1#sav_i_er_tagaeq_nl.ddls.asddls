@AbapCatalog.sqlViewName: '/EY1/ERITGENL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View to Normalize ER TAX Gaap Equity Total of values'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ER_TAGaEq_NL
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

    left outer join /EY1/SAV_I_ER_S2TTotal(p_toperiod:$parameters.p_toperiod,
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention)                              as S2T on  S2T.ConsolidationChartofAccounts = GAAPEQ.ConsolidationChartofAccounts
                                                                                                     and S2T.ChartOfAccounts              = GAAPEQ.ChartOfAccounts
                                                                                                     and S2T.FiscalYear                   = GAAPEQ.FiscalYear
                                                                                                     and S2T.ConsolidationUnit            = GAAPEQ.ConsolidationUnit
                                                                                                     and S2T.MainCurrency                 = GAAPEQ.MainCurrency
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

      case
        when SumS2TAdjustAmt is null
        then cast(0 as abap.curr( 23, 2))
        else SumS2TAdjustAmt
      end as S2TOBBalance,

      // -----------------------  PL fields   ----------------------------
      case
        when G2S.SumPlYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumPlYearBalance
      end as G2SPLBalance,

      case
        when S2T.SumPlYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else S2T.SumPlYearBalance
      end as S2TPLBalance,

      // -----------------------  Permanent fields   ----------------------------
      case
        when G2S.SumPmtYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumPmtYearBalance
      end as G2SPMTBalance,

      case
        when S2T.SumPmtYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else S2T.SumPmtYearBalance
      end as S2TPMTBalance,

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

      case
        when SumS2TCYABalance is null
        then cast(0 as abap.curr( 23, 2))
        else SumS2TCYABalance
      end as S2TYBBalance,

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

      case
        when S2T.SumEqTotalYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else S2T.SumEqTotalYearBalance
      end as S2TEQBalance,

      // -----------------------  other fields   ----------------------------
      case
        when G2S.SumOthrTotalYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else G2S.SumOthrTotalYearBalance
      end as G2SOtherBalance,

      case
        when S2T.SumOthrTotalYearBalance is null
        then cast(0 as abap.curr( 23, 2))
        else S2T.SumOthrTotalYearBalance
      end as S2TOtherBalance,

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
      end as G2SCBBalance,

      case
       when S2T.SumCBYearBalance is null
       then cast(0 as abap.curr( 23, 2))
       else S2T.SumCBYearBalance
      end as S2TCBBalance


}

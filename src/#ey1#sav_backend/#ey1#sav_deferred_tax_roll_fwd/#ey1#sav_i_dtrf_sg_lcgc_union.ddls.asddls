@AbapCatalog.sqlViewName: '/EY1/DTRFSLCGC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward SGAAP LC-GC Union'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_SG_LCGC_UNION
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_DTRF_SGAAP_OBYBCBLC( p_rbunit :$parameters.p_rbunit,
                                                 p_toperiod :$parameters.p_toperiod,
                                                 p_ryear:$parameters.p_ryear,
                                                 p_taxintention :$parameters.p_taxintention ) as SGaapLC
{ //ZEY_SAV_I_TRF_RGAAP_OBYBCB_LC
  key ChartOfAccounts,
  key SGaapLC.ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key SGaapLC.FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      MainCurrency,

      //Tax Rates
      StatOBRate                                                                 as OBRate,
      StatCBRate                                                                 as CBRate,

      //Opening Balance
      EqOpeningBalance,
      PlOpeningBalance,
      OpeningBalanceDTADTL,

      case when OpeningBalanceDTADTL < 0
      then cast('DTL' as abap.char(3))
      else cast('DTA' as abap.char(3)) end                                       as OBClass,

      //Year Balance
      PlYearBalance,
      EqYearBalance,
      OPlYearBalance,
      OEqYearBalance,

      TempTransType,
      TempOtherTransType,

      //CurrentYearMvmnt,
      cast( case when TempTransType is null then TempOtherTransType
                 when TempOtherTransType is null then TempTransType
                 else TempTransType + TempOtherTransType end as abap.curr(23,2)) as CurrentYearMvmnt,

      //Closing Balance
      PlClosingBalance,
      EqClosingBalance,
      ClosingBalanceDTADTL,

      case when ClosingBalanceDTADTL < 0
      then cast('DTL' as abap.char(3))
      else cast('DTA' as abap.char(3)) end                                       as CBClass,

      //CTA
      CTAPl,
      CTAEq,
      CTA,

      //PYA
      PYAPl,
      PYAEq,
      PYAOpl,
      PYAOeq,
      PYA,

      //TRC
      TRCPl,
      TRCEq,
      TRC,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      cast ('SGAAP' as abap.char(5))                                             as ReportingType
}

union all select from /EY1/SAV_I_DTRF_SGAAP_OBYBCBGC( p_rbunit :$parameters.p_rbunit,
                                                      p_toperiod :$parameters.p_toperiod,
                                                      p_ryear:$parameters.p_ryear,
                                                      p_taxintention :$parameters.p_taxintention ) as SGaapGC
{     //ZEY_SAV_I_TRF_RGAAP_OBYBCB_GC
  key ChartOfAccounts,
  key SGaapGC.ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key SGaapGC.FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      MainCurrency,

      //Tax Rates
      StatOBRate                                                                 as OBRate,
      StatCBRate                                                                 as CBRate,

      //Opening Balance
      EqOpeningBalance,
      PlOpeningBalance,
      OpeningBalanceDTADTL,

      case when OpeningBalanceDTADTL < 0
      then cast('DTL' as abap.char(3))
      else cast('DTA' as abap.char(3)) end                                       as OBClass,

      //Year Balance
      PlYearBalance,
      EqYearBalance,
      OPlYearBalance,
      OEqYearBalance,

      TempTransType,
      TempOtherTransType,

      //Current Year Movement
      cast( case when TempTransType is null then TempOtherTransType
                 when TempOtherTransType is null then TempTransType
                 else TempTransType + TempOtherTransType end as abap.curr(23,2)) as CurrentYearMvmnt,

      //Closing Balance
      PlClosingBalance,
      EqClosingBalance,
      ClosingBalanceDTADTL,

      case when ClosingBalanceDTADTL < 0
      then cast( 'DTL' as abap.char(3))
      else cast('DTA' as abap.char(3)) end                                       as CBClass,

      //CTA
      CTAPl,
      CTAEq,
      CTA,

      //PYA
      PYAPl,
      PYAEq,
      PYAOpl,
      PYAOeq,
      PYA,

      //TRC
      TRCPl,
      TRCEq,
      TRC,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      cast ('SGAAP' as abap.char(5))                                             as ReportingType
}

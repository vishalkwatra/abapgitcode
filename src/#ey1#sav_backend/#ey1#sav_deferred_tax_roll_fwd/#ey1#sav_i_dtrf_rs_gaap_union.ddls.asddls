@AbapCatalog.sqlViewName: '/EY1/DTRFRSUNION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Deferred Tax Roll Forward RGAAP SGAAP Union'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_DTRF_RS_GAAP_Union
  with parameters
    p_rbunit       : fc_bunit,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
  as select from /EY1/SAV_I_DTRF_RG_LCGC_Union( p_rbunit :$parameters.p_rbunit,
                                               p_toperiod :$parameters.p_toperiod,
                                               p_ryear:$parameters.p_ryear,
                                               p_taxintention :$parameters.p_taxintention  )
{     //ZEY_SAV_I_TRF_RGAAP_LCGC_UNION
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      MainCurrency,

      Classification,
      CNC,

      // OB & CB Class
      case when TempOBClass = '' then TempOBClass
      //      cast('' as abap.char(3))
           else ( case when ( Classification = 'IFRS - NON-CURRENT' or Classification = 'US GAAP (NEW) - NON-CURRENT')
                     then concat(TempOBClass, concat('-', 'NC'))
                     when Classification = 'GAAP - CURRENT' then concat (TempOBClass, concat('-', 'C'))
                     else concat(TempOBClass, concat('-', CNC)) end )
                     end as OBClass,

      case when TempCBClass = '' then TempCBClass
      //      cast('' as abap.char(3))
           else ( case when ( Classification = 'IFRS - NON-CURRENT' or Classification = 'US GAAP (NEW) - NON-CURRENT')
                     then concat(TempCBClass, concat('-', 'NC'))
                     when Classification = 'GAAP - CURRENT' then concat (TempCBClass, concat('-', 'C'))
                     else concat(TempCBClass, concat('-', CNC)) end )
                     end as CBClass,


      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      EqOpeningBalance,
      PlOpeningBalance,
      OpeningBalanceDTADTL,

      //Year Balance
      PlYearBalance,
      EqYearBalance,
      OPlYearBalance,
      OEqYearBalance,
      TempTransType,
      TempOtherTransType,
      CurrentYearMvmnt,

      //Closing Balance
      PlClosingBalance,
      EqClosingBalance,
      ClosingBalanceDTADTL,

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
      ReportingType
}
union all select from /EY1/SAV_I_DTRF_SG_LCGC_UNION( p_rbunit :$parameters.p_rbunit,
                                                    p_toperiod :$parameters.p_toperiod,
                                                    p_ryear:$parameters.p_ryear,
                                                    p_taxintention :$parameters.p_taxintention  )
{     //ZEY_SAV_I_TRF_SGAAP_LCGC_UNION
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationChartofAccounts,
  key GLAccount,
  key FiscalYear,
  key AccountClassCode,

      ConsolidationDimension,
      FinancialStatementItem,
      MainCurrency,

      Classification,
      CNC,

      // OB & CB Class
      case when TempOBClass = '' then TempOBClass
      //      cast('' as abap.char(3))
           else ( case when ( Classification = 'IFRS - NON-CURRENT' or Classification = 'US GAAP (NEW) - NON-CURRENT')
                       then concat(TempOBClass, concat('-', 'NC'))
                       when Classification = 'GAAP - CURRENT' then concat (TempOBClass, concat('-', 'C'))
                       else concat(TempOBClass, concat('-', CNC)) end )
           end as OBClass,

      case when TempCBClass = '' then TempCBClass
      //      cast('' as abap.char(3))
           else ( case when ( Classification = 'IFRS - NON-CURRENT' or Classification = 'US GAAP (NEW) - NON-CURRENT')
                       then concat(TempCBClass, concat('-', 'NC'))
                       when Classification = 'GAAP - CURRENT' then concat (TempCBClass, concat('-', 'C'))
                       else concat(TempCBClass, concat('-', CNC)) end )
           end as CBClass,

      //Tax Rates
      OBRate,
      CBRate,

      //Opening Balance
      EqOpeningBalance,
      PlOpeningBalance,
      OpeningBalanceDTADTL,

      //Year Balance
      PlYearBalance,
      EqYearBalance,
      OPlYearBalance,
      OEqYearBalance,
      TempTransType,
      TempOtherTransType,
      CurrentYearMvmnt,

      //Closing Balance
      PlClosingBalance,
      EqClosingBalance,
      ClosingBalanceDTADTL,

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

      //CTA
      TRCPl,
      TRCEq,
      TRC,

      CurrencyType,
      BsEqPl,
      TaxEffected,
      ReportingType
}

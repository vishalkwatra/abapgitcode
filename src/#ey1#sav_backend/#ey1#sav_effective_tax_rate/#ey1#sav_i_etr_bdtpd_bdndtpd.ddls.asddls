@AbapCatalog.sqlViewName: '/EY1/ETRBDNDTPD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View-BDTPD-ETR--Diff for whch no Def tax is cal- PermDiff'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_BDTPD_BDNDTPD
  with parameters
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_ryear         : gjahr,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit,
    p_intention     : /ey1/sav_intent
  as select from /EY1/SAV_I_ETR_RS_BDNDTPD
                 ( p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,
                 p_ryear: $parameters.p_ryear, p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention, p_rbunit: $parameters.p_rbunit,
                 p_intention: $parameters.p_intention)
{
      ///EY1/SAV_I_ETR_RS_DDCTRTD
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key ConsolidationDimension,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,

      MainCurrency,
      ConsolidationLedger,

      Amount,
      Rate,
      Tax,
      fltp_to_dec(Percentage as /ey1/sav_rate) as Percentage,

      BsEqPl,
      TaxEffected,

      CurrencyType,
      ReportingType
}
where
  Amount != 0


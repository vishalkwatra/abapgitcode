@AbapCatalog.sqlViewName: '/EY1/ETRRSPYDTN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View ETR RS PYA DTRF PL'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_RS_PYADTRPL
  with parameters
    p_fromperiod   : poper,
    p_toperiod     : poper,
    p_ryear        : gjahr,
    p_switch       : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit       : fc_bunit
  as select from /EY1/SAV_I_ETR_RS_PYA_DTRPL_NR
                 ( p_fromperiod: $parameters.p_fromperiod, p_toperiod: $parameters.p_toperiod,
                 p_ryear: $parameters.p_ryear, p_switch: $parameters.p_switch,
                 p_taxintention: $parameters.p_taxintention, p_rbunit: $parameters.p_rbunit)
{
      ///EY1/SAV_I_ETR_RS_DDCTRTD
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationUnit,
  key GLAccount,
  key AccountClassCode,
  key FiscalYear,

      MainCurrency,
      ConsolidationLedger,
      Tax,
      fltp_to_dec(Percentage as /ey1/sav_rate) as Percentage,
      BsEqPl,
      TaxEffected,

      CurrencyType,
      ReportingType
}
where
  Tax != 0

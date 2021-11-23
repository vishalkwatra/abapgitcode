@AbapCatalog.sqlViewName: '/EY1/ETRSGETEB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View- ETR- SGAAP- Summary- Expected Tax Expense Benefit'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_ETR_SG_SUM_ExpTaxEB
  with parameters
    p_ryear         : gjahr,
    p_fromperiod    : poper,
    p_toperiod      : poper,
    p_switch        : char1,
    p_taxintention : zz1_taxintention,
    p_rbunit        : fc_bunit,
    p_intention     : /ey1/sav_intent
  as select from    /EY1/SAV_I_ETR_SG_SUM_PBT_LCGC
                 ( p_ryear:$parameters.p_ryear,
                    p_fromperiod:$parameters.p_fromperiod,
                    p_toperiod:$parameters.p_toperiod,
                    p_switch:$parameters.p_switch,
                    p_taxintention: $parameters.p_taxintention,
                    p_intention: $parameters.p_intention ) as ExpectedTaxExpenses

    left outer join /EY1/SAV_I_Get_Tax_Rate( p_toperiod: $parameters.p_toperiod,
                               p_ryear:$parameters.p_ryear ,
                               p_rbunit:$parameters.p_rbunit )     as TaxRates on  TaxRates.ConsolidationUnit = ExpectedTaxExpenses.ConsolidationUnit
                                                                               and TaxRates.FiscalYear        = ExpectedTaxExpenses.FiscalYear


{
      ///EY1/SAV_I_ETR_RG_SUM_PBT_LCGC
  key ConsolidationChartofAccounts,
  key ChartOfAccounts,
  key ConsolidationDimension,
  key ExpectedTaxExpenses.FiscalYear,
  key ExpectedTaxExpenses.ConsolidationUnit,
      ConsolidationLedger,
      MainCurrency,
      PBT,
      CurrType,

      CurrentTaxRate,

      // TAX = 'CurrentTaxRate' % of PBT
      PBT * CurrentTaxRate * MultiFactor                                                                                                       as Tax,

      // Percentage = (Tax / PBT) * 100
      case
      when PBT is null then cast(0 as /ey1/sav_rate)
      when PBT = 0 then cast(0 as /ey1/sav_rate)
      else
      ((cast( PBT * CurrentTaxRate * MultiFactor as abap.fltp(16,16)) / cast (PBT as abap.fltp(16,16))) *  cast (100 as abap.fltp(16,16))) end as Percentage
}
where
  ExpectedTaxExpenses.ConsolidationUnit = :p_rbunit

@AbapCatalog.sqlViewName: '/EY1/TAXPTALC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View TAX PTA for Local Currency'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_PTA_LC
  with parameters
    p_ryear        : gjahr,
    p_toperiod     : poper,
    p_taxintention : zz1_taxintention

  as select from /EY1/SAV_I_Rec_PTA as PTA

  //    left outer join /EY1/SAV_I_Rec_TAX_PTA_SI
  //                    (p_ryear:$parameters.p_ryear,
  //                    p_taxintention: $parameters.p_taxintention) as PTASI on  PTA.ConsolidationUnit = PTASI.ConsolidationUnit
  //                                                                         and PTA.FiscalYear        = PTASI.FiscalYear
{
      //ZEY_SAV_I_PTA
  key PTA.ConsolidationUnit,
  key PTA.FiscalYear,
  key GLAccount,

      @Semantics.amount.currencyCode: 'LocalCurrency'
      sum(AmountInLocalCurrency) as AmountInLocalCurrency,

      @Semantics.currencyCode: true
      LocalCurrency
}
where
       PTA.FiscalPeriod <= :p_toperiod
  and(
       TaxIntention     <= :p_taxintention
    or TaxIntention     =  ''
  )
  and  PTA.FiscalYear   =  :p_ryear

group by
  GLAccount,
  PTA.ConsolidationUnit,
  LocalCurrency,
  PTA.FiscalYear

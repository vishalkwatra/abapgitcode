@AbapCatalog.sqlViewName: '/EY1/TAXOBNRLC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View Recon Tax OB Normalize LC'
@VDM.viewType: #COMPOSITE

define view /EY1/SAV_I_Rec_TAX_OBNR_LC
  with parameters
    p_ryear        : gjahr,
    p_periodto     : poper,
    p_taxintention : zz1_taxintention,
    p_intention    : zz1_taxintention
  as select from    /EY1/SAV_I_Rec_TAX_OB_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_taxintention:$parameters.p_taxintention ) as OB
    left outer join /EY1/SAV_I_Rec_TAX_OBPYA_LC(
                    p_ryear:$parameters.p_ryear ,
                    p_periodto:$parameters.p_periodto,
                    p_taxintention:$parameters.p_intention  )   as OBPYA on  OBPYA.GLAccount         = OB.GLAccount
                                                                         and OBPYA.ConsolidationUnit = OB.ConsolidationUnit
{
  key OB.ConsolidationLedger,
  key OB.ConsolidationDimension,
  key OB.FiscalYear,
      OB.ChartOfAccounts,
      OB.ConsolidationUnit,
      OB.GLAccount,
      OB.ConsolidationVersion,
      cast( case when TaxOpeningBalance is null then TaxPYAOB
                           when TaxPYAOB is null then TaxOpeningBalance
                           else TaxOpeningBalance + TaxPYAOB end as abap.curr(23,2)) as TaxOpeningBalance,

      OB.LocalCurrency
}

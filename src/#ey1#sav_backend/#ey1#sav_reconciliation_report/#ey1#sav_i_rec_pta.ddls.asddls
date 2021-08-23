@AbapCatalog.sqlViewName: '/EY1/IRECONPTA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I- View Reconciliation PTA Table'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_Rec_PTA
  as select from /ey1/recon_pta
    inner join   t001 as CompanyCode on /ey1/recon_pta.rbunit = CompanyCode.rcomp
{
      //zrecon_pta
  key docnr             as DocumentNumber,
  key buzei             as LineItem,
  key rbunit            as ConsolidationUnit,
  key ryear             as FiscalYear,
      CompanyCode.ktopl as ChartofAccounts,
      racct             as GLAccount,
      fc_item           as FinancialStatementItem,
      budat             as PostingDate,
      budat             as PostingDateDisplay,
      poper             as FiscalPeriod,
      taxintention      as TaxIntention,
      
      @Semantics.amount.currencyCode: 'LocalCurrency'
      hsl               as AmountInLocalCurrency,
      
      @Semantics.currencyCode: true
      rhcur             as LocalCurrency,
      
      @Semantics.amount.currencyCode: 'GroupCurrency'
      ksl               as AmountInGroupCurrency,
      
      @Semantics.currencyCode: true
      rkcur             as GroupCurrency,
      
      sgtxt             as Text
}

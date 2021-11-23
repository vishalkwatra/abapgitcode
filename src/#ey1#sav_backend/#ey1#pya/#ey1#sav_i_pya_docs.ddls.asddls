@AbapCatalog.sqlViewName: '/EY1/I_PYADOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Priori Year Adjustment Document Details'


@VDM.viewType: #BASIC


define view /EY1/SAV_I_PYA_DOCS
  with parameters
    p_ryear        : gjahr,
    p_taxintention : zz1_taxintention
  as select from acdocu
    inner join   /ey1/reconledger               as ReconLedger on acdocu.rbunit = ReconLedger.bunit
    inner join   /EY1/I_TRANS_TYPE              as TransType   on acdocu.rmvct = TransType.trtyp
    inner join   /EY1/SAV_I_Get_Cnsldtn_Version as GetVersion  on(
       (
         GetVersion.ConsolidationLedger = ReconLedger.g2s
         and acdocu.rvers               = GetVersion.ConsolidationVersion
       )
       or(
         GetVersion.ConsolidationLedger = ReconLedger.s2t
         and acdocu.rvers               = GetVersion.ConsolidationVersion
       )
     )
{
  key  ktopl                     as ChartOfAccounts,
  key  rbunit                    as ConsolidationUnit,
  key  ritclg                    as ConsolidationChartOfAccounts,
  key  racct                     as GLAccount,
  key  ryear                     as FiscalYear,
       docnr                     as belnr,
       robukrs                   as bukrs,
       @Semantics.amount.currencyCode: 'LocalCurrency'
       sum(hsl)                  as YearBalance,
       TransType.rldnrassgnttype as TransactionType,
       @Semantics.currencyCode: true
       rhcur                     as LocalCurrency,
       GetVersion.ConsolidationLedger,
       zz1_taxintention_cje      as TaxIntention
}
where
          poper != '000'
  and     ryear                <  :p_ryear
  and(
          acdocu.rldnr         =  ReconLedger.g2s
    or(
          acdocu.rldnr         =  ReconLedger.s2t
      and zz1_ledgergroup_cje != 'G2S'
    )
  )
  and(
          zz1_taxintention_cje <= :p_taxintention
    and   zz1_taxintention_cje != ''
    and   zz1_taxintention_cje >= '101'
    //or    zz1_taxintention_cje =  ''
  )
group by
  ktopl,
  rbunit,
  ritclg,
  racct,
  ryear,
  rhcur,
  TransType.rldnrassgnttype,
  docnr,
  robukrs,
  ryear,
  GetVersion.ConsolidationLedger,
  zz1_taxintention_cje
//  rvers,
//  rldnr

@AbapCatalog.sqlViewName: '/EY1/GPCURR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View for Group Currency'
define view /EY1/I_Group_Currency
  as select from /ey1/reconledger
    join         A_CnsldtnLedger on /ey1/reconledger.gaap = A_CnsldtnLedger.ConsolidationLedger
{

      ///EY1/RECON_LEDGER
  key bunit,

      //A_CNSLDTNLEDGER
  key ConsolidationLedger,

      //A_CNSLDTNLEDGER
      GroupCurrency,

      /* Associations */
      //A_CNSLDTNLEDGER
      _CnsldtnLedgerT
}

@AbapCatalog.sqlViewName: '/EY1/GLACCTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - View GL Account Text'

define view /EY1/SAV_I_GlAccText
  as select from skat
{
      //skat
  key spras as Language,
  key ktopl as ChartOfAccounts,
  key saknr as GLAccount,
      txt20 as GLAccountText,
      txt50 as GLAccountMdmText,
      mcod1
}

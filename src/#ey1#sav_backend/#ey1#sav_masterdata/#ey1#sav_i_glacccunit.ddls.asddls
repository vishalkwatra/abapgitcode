@AbapCatalog.sqlViewName: '/EY1/ICSGLACC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GL Accounts - Consolidation Unit'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_GlAccCUnit
  as select distinct from fincs_fsimapitm as glaccnt
    left outer join       /EY1/SAV_I_FinancialStatItem    as fsitem on fsitem.item = glaccnt.ritem
{
  key glaccnt.racct     as GLAccount,
  key account_classcode as AccountClassCode,
      glaccnt.ritem     as FinancialStatementItem
}

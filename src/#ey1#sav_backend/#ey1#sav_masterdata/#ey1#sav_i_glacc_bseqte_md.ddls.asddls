@AbapCatalog.sqlViewName: '/EY1/GLBSEQTEMD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I-View GLAccount- BS,EQ,TaxEffected - MD'
@VDM.viewType: #BASIC

define view /EY1/SAV_I_GlAcc_BSEQTE_MD
  with parameters
    p_ryear : gjahr
  as select distinct from fincs_fsimapitm              as GLAccnt
    left outer join       /EY1/SAV_I_FinancialStatItem as fsitem        on fsitem.item = GLAccnt.ritem

    left outer join       acdocu                                        on  acdocu.racct = GLAccnt.racct
                                                                        and acdocu.ryear = :p_ryear

    left outer join       /EY1/SAV_I_Accounts_Class    as AccountsClass on fsitem.account_classcode = AccountsClass.acc_class_code

{
  key GLAccnt.racct            as GLAccount,
  key account_classcode        as AccountClassCode,
  key rdimen                   as ConsolidationDimension,
  key ryear                    as FiscalYear,

      GLAccnt.ritem            as FinancialStatementItem,
      GLAccnt.ktopl            as ChartOfAccounts,
      rbunit                   as ConsolidationUnit,
      rhcur                    as LocalCurrency,
      rkcur                    as GroupCurrency,
      GLAccnt.ritclg           as ConsolidationChartofAccounts,

      AccountsClass.bl_eq_pl   as BsEqPl,
      AccountsClass.cnc        as CNC,
      AccountsClass.tax_effect as TaxEffected,
      AccountsClass.profit     as PBT
}
where
      AccountsClass.tax_effect = 'X'
  and AccountsClass.bl_eq_pl != 'P&L'
  and GLAccnt.ritclg != ''
  and GLAccnt.ktopl != ''
  and rbunit != ''

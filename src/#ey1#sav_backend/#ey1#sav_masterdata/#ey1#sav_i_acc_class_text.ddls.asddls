@AbapCatalog.sqlViewName: '/EY1/ACCCLASSTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View Account Class Text'

define view /EY1/SAV_I_Acc_Class_Text
  as select from /ey1/acc_txt_tab
{
      //ZACC_TEXT_TAB
  key spras             as Language,
  key account_classcode as AccountClassCode,
      acc_txt           as AccountClassCodeText
}

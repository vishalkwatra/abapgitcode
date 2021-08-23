@AbapCatalog.sqlViewName: '/EY1/ACCCODETXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'I - View Account Class Code Text'
define view /EY1/SAV_I_AccClassText as select from /ey1/acc_txt_tab {
    //zacc_text_tab
    key spras as Language,
    key account_classcode as AccountClassCode,
    acc_txt as AccountClassCodeText
}

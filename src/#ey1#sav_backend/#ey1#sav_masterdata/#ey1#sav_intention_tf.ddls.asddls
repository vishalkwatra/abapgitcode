@EndUserText.label: 'CDS Table Function to fetch Intention based on "Period_To"'
define table function /EY1/SAV_Intention_TF
 with parameters
    @Environment.systemField: #CLIENT
    clnt       : abap.clnt,
    p_toperiod : poper
returns {
  client           : abap.clnt;
  PeriodTo         : poper;
  intention        : /ey1/sav_intent;
  
}
implemented by method 
/EY1/SAV_CL_Tax_Rates=>get_intention;

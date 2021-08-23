@EndUserText.label: 'Table Function for Spliting Data in Tiers'
define table function /EY1/SAV_ETR_Split_Tiers_TF
  with parameters
    @Environment.systemField: #CLIENT
    clnt          : abap.clnt,
    p_cntry       : land1,
    p_year        : gjahr,
    p_intention   : /ey1/sav_intent,
    //    p_seq         : seqnr_flb,
    p_TotalAmount : abap.curr( 23, 2 )
returns
{
  client     : s_mandt;
//  Country    : land1;
//  FiscalYear : gjahr;
//  Intention  : /ey1/sav_intent;
//  Sequence   : seqnr_flb;
  Amount     : abap.curr( 23, 2 );
}
implemented by method
  /EY1/SAV_CL_ETR_Summary=>get_split_amount;

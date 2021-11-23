@ClientDependent: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Intention Values - Table Function'
define table function /EY1/INTENTIONV_TF
with parameters
 @Environment.systemField: #CLIENT
    p_mandt: abap.clnt,
    p_bunit: fc_bunit
 returns {
 mandt: abap.clnt;
 gjahr: gjahr;
 periodto: /ey1/to_period;
 code: zz1_taxintention;
 intent: /ey1/sav_intent;
 description: zz1_taxintention_d;
 status: abap.string;
 seqnr_flb: seqnr_flb;
 curropenperiod: /ey1/to_period;
 isSelected: abap.char( 1 );
 } 
 implemented by method /ey1/cl_intentions_dropdown=>get_intention

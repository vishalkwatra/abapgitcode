@ClientDependent: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Savotta - Table Function for Global Par. Intention VH'
define table function /EY1/SAV_C_IntentionsVH
with parameters
 @Environment.systemField: #CLIENT
    p_mandt: abap.clnt
     returns {
 mandt: abap.clnt;
 bunit: fc_bunit;
 gjahr: gjahr;
 periodto: /ey1/to_period;
 code: zz1_taxintention;
 intent: /ey1/sav_intent;
 description: zz1_taxintention_d;
 status: char15;
 seqnr_flb: seqnr_flb;
 curropenperiod: /ey1/to_period;
 Intention: char70;
 } 
 implemented by method /ey1/cl_intentions_vh_amdp=>get_intention

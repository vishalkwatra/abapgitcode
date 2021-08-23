@ClientDependent: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Intentions Table Function'

define table function /EY1/INTENTIONS_TF 
with parameters 
    @Environment.systemField: #CLIENT
    p_mandt: abap.clnt,
    p_gjahr:gjahr,
    p_bunit: fc_bunit
returns {
 mandt: abap.clnt;
 periodto: /ey1/to_period;
 code: zz1_taxintention;
 intent: /ey1/sav_intent;
 description: zz1_taxintention_d;
 status: /ey1/active;
 seqnr_flb: seqnr_flb;
 } 
 implemented by method /ey1/cl_intentions_value_amdp=>get_intention;

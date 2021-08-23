CLASS /ey1/sav_cl_etr_summary DEFINITION PUBLIC.

PUBLIC SECTION.
INTERFACES if_amdp_marker_hdb.
CLASS-METHODS get_split_amount FOR TABLE FUNCTION /EY1/SAV_ETR_Split_Tiers_TF.

PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /EY1/SAV_CL_ETR_SUMMARY IMPLEMENTATION.


METHOD get_split_amount BY DATABASE FUNCTION FOR HDB LANGUAGE
                        SQLSCRIPT OPTIONS READ-ONLY USING /ey1/manage_tier.

     declare v_count integer;
     declare v_i integer;

    it_tiers = select * from "/EY1/MANAGE_TIER" where land1= p_cntry
                                                  and ryear=p_year
                                                  and intention=p_intention;

    SELECT COUNT (*) INTO v_count FROM :it_tiers;

    FOR v_i IN 1..v_count do

    IF ( p_TotalAmount <= :it_tiers.tier_amount[v_i] ) THEN





    END IF;

    END FOR;










    RETURN SELECT mandt AS client, tier_amount AS amount FROM "/EY1/MANAGE_TIER" where land1= p_cntry and ryear=p_year and
                                                                                       intention=p_intention;
*                                                                                        and seqnr_flb = p_seq;

ENDMETHOD.
ENDCLASS.

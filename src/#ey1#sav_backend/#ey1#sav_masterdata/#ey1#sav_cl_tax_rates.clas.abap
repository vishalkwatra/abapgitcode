CLASS /ey1/sav_cl_tax_rates DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS get_tax_rate FOR TABLE FUNCTION /ey1/sav_taxrate_tf.
    CLASS-METHODS get_intention FOR TABLE FUNCTION /ey1/sav_intention_tf.
*    CLASS-METHODS calculate_tax_rate_backup FOR TABLE FUNCTION /EY1/SAV_I_Tax_Rates_TF.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ey1/sav_cl_tax_rates IMPLEMENTATION.

  METHOD get_tax_rate BY DATABASE FUNCTION FOR HDB LANGUAGE
                          SQLSCRIPT OPTIONS READ-ONLY
                          USING /ey1/tax_rates.

    declare lv_intention string;
    declare lv_count integer;

    lt_intention = select case p_toperiod
                when  '001'
                then  'Q1'

                when  '002'

                then  'Q1'

                when  '003'

                then  'Q1'

                when  '004'

                then  'Q2'

                when  '005'

                then  'Q2'

                when  '006'

                then  'Q2'

                when  '007'

                then   'Q3'

                when  '008'

                then   'Q3'

                when  '009'

                then  'Q3'

                else  'TXP'

                end as intention

            from dummy;


        lt_tax_rate = select * from "/EY1/TAX_RATES" where intention in ( select intention from :lt_intention )
                                                     and   gjahr = :p_ryear
                                                     and   rbunit = :p_rbunit
                                                     and   mandt = :clnt;

        select count( * ) into lv_count from :lt_tax_rate;

        if( lv_count = 0) THEN

            lt_tax_rate = SELECT * FROM "/EY1/TAX_RATES" where intention = 'TXP'
                                                         and   gjahr = :p_ryear
                                                         and   rbunit = :p_rbunit
                                                         and   mandt = :clnt;
        END if;

            RETURN SELECT mandt AS client, rbunit,
              gjahr,
              intention,
              current_tax_rate,
              gaap_ob_dt_rate,
              gaap_cb_dt_rate,
              stat_ob_dt_rate,
              stat_cb_dt_rate from :lt_tax_rate;
  endmethod.




METHOD get_intention BY DATABASE FUNCTION FOR HDB LANGUAGE
                          SQLSCRIPT OPTIONS READ-ONLY.

  lt_intention = select CASE p_toperiod
                WHEN  '001'
                then  'Q1'

                WHEN  '002'

                then  'Q1'

                WHEN  '003'

                then  'Q1'

                WHEN  '004'

                then  'Q2'

                WHEN  '005'

                then  'Q2'

                WHEN  '006'

                then  'Q2'

                WHEN  '007'

                then   'Q3'

                WHEN  '008'

                then   'Q3'

                WHEN  '009'

                then  'Q3'

                ELSE  'TXP'

                END as intention,

                clnt   as client

            from dummy;

            RETURN SELECT client,
              p_toperiod AS PeriodTo,
              intention
              FROM :lt_intention;

  ENDMETHOD.












ENDCLASS.


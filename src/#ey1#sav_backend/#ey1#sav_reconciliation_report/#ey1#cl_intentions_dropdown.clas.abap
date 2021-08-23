CLASS /ey1/cl_intentions_dropdown DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES if_amdp_marker_hdb.

    CLASS-METHODS: get_intention FOR TABLE FUNCTION /EY1/INTENTIONV_TF.


PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /ey1/cl_intentions_dropdown IMPLEMENTATION.

METHOD get_intention BY DATABASE FUNCTION FOR HDB LANGUAGE
                          SQLSCRIPT
                          USING /EY1/INTENTION
                                /EY1/FISCL_INTNT
                                dd08l
                                dd01l
                                /EY1/IRINTENTVH.

   DECLARE lc_table "$ABAP.type( TABNAME )";
   DECLARE ls_str   "$ABAP.type( String )";
   DECLARE lt_ret TABLE (   CODE  "$ABAP.type( ZZ1_TAXINTENTION )",
                            LANGUAGE  "$ABAP.type( SYLANGU )",
                            DESCRIPTION  "$ABAP.type( ZZ1_TAXINTENTION_D )"
                        );
   DECLARE lc_seq_no "$ABAP.type( SEQNR_FLB )";
   DECLARE lc_count "$ABAP.type( i )";
   DECLARE v_i integer;
   DECLARE lt_gjahr_dist TABLE (
                                gjahr "$ABAP.type( gjahr )"
                              );
   DECLARE lv_gjahr "$ABAP.type( GJAHR )";

   DECLARE lt_reuslt1 TABLE (
                                mandt "$ABAP.type( MANDT )",
                                gjahr "$ABAP.type( GJAHR )",
                                periodto "$ABAP.type( /EY1/TO_PERIOD )",
                                code "$ABAP.type( ZZ1_TAXINTENTION )",
                                intent "$ABAP.type( /EY1/SAV_INTENT )",
                                description "$ABAP.type( ZZ1_TAXINTENTION_D )",
                                curropenperiod "$ABAP.type( /EY1/TO_PERIOD )",
                                Status "$ABAP.type( String )",
                                Seqnr_flb "$ABAP.type( SEQNR_FLB )"
                            );

   DECLARE lv_bool integer;
   DECLARE lv_periodto "$ABAP.type( /EY1/TO_PERIOD )";

  lt_result1 = select '' as mandt,
          '' as gjahr,
          '' as periodto,
          '' as code,
          '' as intent,
          '' as description,
          '' as curropenperiod,
          '' as Status,
          '' as Seqnr_flb FROM dummy;

   SELECT tabname
     INTO lc_table FROM DD08L
     WHERE
     CHECKTABLE = ( SELECT ENTITYTAB FROM DD01L WHERE DOMNAME = 'ZZ1_TAXINTENTION' )
       AND FRKART = 'TEXT'
       AND AS4LOCAL = 'A';

   SELECT CONCAT ('SELECT CODE, LANGUAGE, DESCRIPTION FROM ', lc_table ) "concat"
     INTO ls_str FROM DUMMY ;

  lt_intention = SELECT  * FROM "/EY1/FISCL_INTNT"
     WHERE bunit          = p_bunit;

   lt_intnt = select a.*,b.intnsn_act_flg,b.gjahr FROM "/EY1/INTENTION" AS a
               inner join :lt_intention AS b
               ON a.intent = b.intention;

   EXECUTE IMMEDIATE ls_str INTO lt_ret;


   lt_final = select a.*,b.code from :lt_intnt as a
                left outer join :lt_ret as b
                on a.description = b.description;

   --select count ( * ) into lc_count from :lt_final;

   lt_gjahr_dist = select distinct gjahr from :lt_final;

   select count ( * ) into lc_count from :lt_gjahr_dist;

   lt_gjahr = select ROW_NUMBER() OVER (ORDER BY gjahr DESC) as Row
   , gjahr from :lt_gjahr_dist
    order by gjahr;

   lt_new_intention = select * from "/EY1/IRINTENTVH";


    for v_i in 1..lc_count do

    lt_Final1 =  select * from :lt_final
                    where gjahr = ( select gjahr from :lt_gjahr where Row = v_i);


     select gjahr into lv_gjahr from :lt_gjahr where Row = v_i;

     select seqnr_flb into lc_seq_no
      from :lt_final where gjahr = ( select gjahr from :lt_gjahr where Row = v_i);


   lt_result = select a.*,b.code,b.description,b.seqnr_flb,
                  case b.intnsn_act_flg
                   WHEN 'X' THEN
                    'Closed'
                   ELSE
                    CASE WHEN a.SerialNumber < lc_seq_no
                      then 'Closed'
                      WHEN a.SerialNumber = lc_seq_no
                       then 'Open'
                      else
                       'Yet To Open' end
                   END as Status,
                   :lv_gjahr AS gjahr
                  from :lt_new_intention as a
                  left outer join :lt_Final1 as b
                  on a.intent = b.intent;

    select period_to INTO lv_periodto
     from "/EY1/FISCL_INTNT"
     where gjahr = :lv_gjahr
     and   bunit = :p_bunit;

  -- ADD CHECK IF PER is open
    SELECT COUNT(*) INTO lv_bool FROM :lt_result
    where intent = 'PER'
    AND Status = 'Open';
    IF lv_bool > 0 THEN
    lt_resu = select gjahr, periodto, code, intent, description,
        lv_periodto as curropenperiod,
        CASE WHEN Status = 'Yet To Open'
          THEN
           CASE WHEN intent = 'Q1' THEN
            CASE WHEN lv_periodto > ( ( select periodto from "/EY1/INTENTION" where intent = 'Q1' )   )
             THEN
               'Closed'
             ELSE
               Status
             END
            WHEN intent = 'Q2' THEN
             CASE WHEN lv_periodto > ( ( select periodto from "/EY1/INTENTION" where intent = 'Q2' )   )
             THEN
               'Closed'
             ELSE
               Status
             END
            WHEN intent = 'Q3' THEN
             CASE WHEN lv_periodto > ( ( select periodto from "/EY1/INTENTION" where intent = 'Q3' )   )
             THEN
               'Closed'
             ELSE
               Status
             END
            ELSE
             Status
            END
          ELSE
           Status
          END AS Status,
        Seqnr_flb
    from :lt_result;
    ELSE
        lt_resu = select gjahr, periodto, code, intent, description,
        lv_periodto as curropenperiod,Status,Seqnr_flb
    from :lt_result;
    END IF;

    lt_result1 = select mandt, gjahr, periodto, code, intent, description, curropenperiod, Status, Seqnr_flb from :lt_result1
                    UNION
                 select p_mandt AS mandt, gjahr, periodto, code, intent, description, curropenperiod, Status, Seqnr_flb from :lt_resu;

  end for;

   RETURN SELECT
                 p_mandt as mandt,
                 gjahr as gjahr,
                 periodto,
                 code,
                 intent,
                 description,
                 Status,
                 seqnr_flb,
                 curropenperiod
                 from :lt_result1;

  ENDMETHOD.



ENDCLASS.

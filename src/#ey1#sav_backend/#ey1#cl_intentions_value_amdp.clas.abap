CLASS /ey1/cl_intentions_value_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
 INTERFACES if_amdp_marker_hdb.

  CLASS-METHODS: get_intention FOR TABLE FUNCTION /EY1/INTENTIONS_TF.



PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /ey1/cl_intentions_value_amdp IMPLEMENTATION.
 METHOD get_intention BY DATABASE FUNCTION FOR HDB LANGUAGE
                          SQLSCRIPT
                          USING /EY1/INTENTION
                                /EY1/FISCL_INTNT
                                dd08l
                                dd01l.

   DECLARE lc_table "$ABAP.type( TABNAME )";
   DECLARE ls_str   "$ABAP.type( String )";
   DECLARE lt_ret TABLE (   CODE  "$ABAP.type( ZZ1_TAXINTENTION )",
                            LANGUAGE  "$ABAP.type( SYLANGU )",
                            DESCRIPTION  "$ABAP.type( ZZ1_TAXINTENTION_D )"
                        );

   SELECT tabname
     INTO lc_table FROM DD08L
     WHERE
     CHECKTABLE = ( SELECT ENTITYTAB FROM DD01L WHERE DOMNAME = 'ZZ1_TAXINTENTION' )
       AND FRKART = 'TEXT'
       AND AS4LOCAL = 'A';

   SELECT CONCAT ('SELECT CODE, LANGUAGE, DESCRIPTION FROM ', lc_table ) "concat"
     INTO ls_str FROM DUMMY ;


   lt_intnt =
   select a.*,b.intnsn_act_flg FROM "/EY1/INTENTION" AS a
   inner join (
    SELECT  * FROM "/EY1/FISCL_INTNT"
     WHERE gjahr          = :p_gjahr
     AND   bunit          = :p_bunit
     AND mandt = :p_mandt ) as b
     ON a.intent = b.intention;


   EXECUTE IMMEDIATE ls_str INTO lt_ret;

   lt_final = select a.periodto,
                     a.intent,
                     a.intnsn_act_flg,
                     b.code,
                     b.description,
                     a.seqnr_flb
                     from :lt_intnt as a
                     inner join :lt_ret as b
                     on a.taxintention = b.code;
   RETURN SELECT
                 p_mandt as mandt,
                 periodto,
                 code,
                 intent,
                 description,
                 intnsn_act_flg as status,
                 seqnr_flb
                 from :lt_final;

  ENDMETHOD.


ENDCLASS.

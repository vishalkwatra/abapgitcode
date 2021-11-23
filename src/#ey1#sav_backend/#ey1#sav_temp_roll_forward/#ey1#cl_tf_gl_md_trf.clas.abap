CLASS /ey1/cl_tf_gl_md_trf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
INTERFACES: IF_AMDP_MARKER_HDB.
CLASS-METHODS: get_data FOR TABLE FUNCTION /EY1/I_TF_GL_MD_TRF.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /ey1/cl_tf_gl_md_trf IMPLEMENTATION.
  METHOD get_data BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
    USING acdocu
          /EY1/PYA_AMOUNT.

     lt_data = select rclnt as mandt, racct ,rbunit,rdimen,ryear,ktopl,rcongr,rhcur,rkcur,ritclg,rldnr, rvers,rtcur
                      from acdocu where ryear = :p_ryear
                                  and rclnt = SESSION_CONTEXT( 'CLIENT' );


     lt_pya = SELECT * FROM
              (   select mandt, glaccount as racct,bunit as rbunit,'' as rdimen,pya_year as ryear,
                       ktopl,'' as rcongr,localcurrency as rhcur,groupcurrency as rkcur,
                       ritclg, ledger, rvers,'' as rtcur
                       from "/EY1/PYA_AMOUNT"
                       WHERE pya_year = :p_ryear
                       and mandt = SESSION_CONTEXT( 'CLIENT' )
                       and glaccount NOT IN ( select  racct as glaccount from :lt_data )
               );
     lt_data = select * from :lt_data
                UNION select * from :lt_pya;

       RETURN select * from :lt_data;

  ENDMETHOD.

ENDCLASS.

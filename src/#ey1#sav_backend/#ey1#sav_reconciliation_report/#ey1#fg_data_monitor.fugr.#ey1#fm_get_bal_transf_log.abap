FUNCTION /EY1/FM_GET_BAL_TRANSF_LOG.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_DIMEN) TYPE  FC_DIMEN OPTIONAL
*"     VALUE(IV_CONGR) TYPE  FC_CONGR OPTIONAL
*"     VALUE(IV_RVERS) TYPE  FC_RVERS OPTIONAL
*"     VALUE(IV_RYEAR) TYPE  FC_RYEAR OPTIONAL
*"     VALUE(IV_BUNIT) TYPE  FC_BUNIT OPTIONAL
*"     VALUE(IV_ITCLG) TYPE  FC_ITCLG OPTIONAL
*"     VALUE(IV_JOBNAME) TYPE  TBTCJOB-JOBNAME OPTIONAL
*"  EXPORTING
*"     REFERENCE(ET_TAB) TYPE REF TO  DATA
*"     REFERENCE(EV_CONGR) TYPE  FC_CONGR
*"----------------------------------------------------------------------

TYPES: BEGIN OF ty_col,
        col1  TYPE string,
        col2  TYPE string,
        col3  TYPE string,
        col4  TYPE string,
        col5  TYPE string,
        col6  TYPE string,
        col7  TYPE string,
        col8  TYPE string,
        col9  TYPE string,
        col10 TYPE string,
       END OF ty_col.
DATA: ls_col TYPE ty_col,
      lt_col TYPE TABLE OF ty_col,
      lv_pattern TYPE string VALUE '-------'.

CONSTANTS: con_opcode TYPE btch0000-int4 VALUE 36,
           raw        TYPE sood-objtp VALUE 'RAW',
           otf        TYPE sood-objtp VALUE 'OTF'.

DATA: lv_jobcount   TYPE tbtcjob-jobcount,
      lt_steps      TYPE TABLE OF tbtcstep,
      lt_spool      TYPE TABLE OF bapixmspoolid,
      ls_spool      TYPE bapixmspoolid,
      lv_name       TYPE rspo2name,
      desired_type  TYPE sood-objtp.

DATA: real_type     TYPE sood-objtp,
      objcont       TYPE TABLE OF soli.

    SELECT SINGLE * FROM tbtco WHERE jobname = @iv_jobname
      INTO @DATA(ls_job).
    IF sy-subrc = 0.
      lv_jobcount = ls_job-jobcount.
    ENDIF.


    CALL FUNCTION 'BP_JOB_READ'
       EXPORTING
            job_read_jobcount     = lv_jobcount
            job_read_jobname      = iv_jobname
            job_read_opcode       = con_opcode
*        IMPORTING
*            JOB_READ_JOBHEAD      =
       TABLES
            job_read_steplist     = lt_steps
            spool_attributes      = lt_spool
       EXCEPTIONS
            invalid_opcode        = 1
            job_doesnt_exist      = 2
            job_doesnt_have_steps = 3
            OTHERS                = 4.

    READ TABLE lt_spool INTO ls_spool INDEX 1.
    IF sy-subrc = 0.
         desired_type = raw.
         CALL FUNCTION 'RSPO_RETURN_SPOOLJOB'
         EXPORTING
              rqident      = ls_spool-spoolid
              desired_type = desired_type
         IMPORTING
              real_type    = real_type
         TABLES
              buffer       = objcont
         EXCEPTIONS
              no_such_job          = 14
              type_no_match        = 94
              job_contains_no_data = 54
              no_permission        = 21
              can_not_access       = 21
              read_error           = 54.
    ENDIF.


DATA: lv_congr  TYPE fc_congr,
      lv_string TYPE string,
      lv_desc   TYPE string,
      lv_length TYPE i.

 LOOP AT objcont INTO DATA(ls_objcont) FROM 12.
   IF sy-tabix = 12.
     lv_length = strlen( ls_objcont-line ).
     FIND FIRST OCCURRENCE OF '|' IN ls_objcont-line MATCH OFFSET DATA(lv_offset).
     IF sy-subrc = 0.
       lv_offset = lv_offset + 2.
       lv_length = lv_length - 2.
       FIND FIRST OCCURRENCE OF '|' IN ls_objcont-line+lv_offset(lv_length) MATCH OFFSET DATA(lv_last).
       lv_desc = ls_objcont+lv_offset(lv_last).
       CONDENSE lv_desc.
       SPLIT lv_desc AT space INTO lv_congr lv_desc.
     ENDIF.
   ELSEIF sy-tabix = 14.

   ELSEIF sy-tabix = 20. "Column Names
     REPLACE FIRST OCCURRENCE OF '|' IN ls_objcont-line WITH space.
     REPLACE FIRST OCCURRENCE OF '|' IN ls_objcont-line WITH space.
     CONDENSE ls_objcont-line.
     ls_col-col1 = ls_objcont-line.
     DO.
       IF ls_col-col2 IS INITIAL.
         SPLIT ls_col-col1 AT '|' INTO ls_col-col1 ls_col-col2.
       ELSEIF ls_col-col3 IS INITIAL.
         SPLIT ls_col-col2 AT '|' INTO ls_col-col2 ls_col-col3.
       ELSEIF ls_col-col4 IS INITIAL.
         SPLIT ls_col-col3 AT '|' INTO ls_col-col3 ls_col-col4.
       ELSEIF ls_col-col5 IS INITIAL.
         SPLIT ls_col-col4 AT '|' INTO ls_col-col4 ls_col-col5.
       ELSEIF ls_col-col6 IS INITIAL.
         SPLIT ls_col-col5 AT '|' INTO ls_col-col5 ls_col-col6.
       ELSEIF ls_col-col7 IS INITIAL.
         SPLIT ls_col-col6 AT '|' INTO ls_col-col6 ls_col-col7.
       ELSEIF ls_col-col8 IS INITIAL.
         SPLIT ls_col-col7 AT '|' INTO ls_col-col7 ls_col-col8.
       ELSEIF ls_col-col9 IS INITIAL.
         SPLIT ls_col-col8 AT '|' INTO ls_col-col8 ls_col-col9.
       ELSEIF ls_col-col10 IS INITIAL.
         SPLIT ls_col-col9 AT '|' INTO ls_col-col9 ls_col-col10.
       ELSE.
         REPLACE ALL OCCURRENCES OF '|' IN ls_col-col10 WITH space.
         CONDENSE: ls_col-col1,ls_col-col2,ls_col-col3,ls_col-col4,ls_col-col5,ls_col-col6,ls_col-col7,ls_col-col8,ls_col-col9,ls_col-col10.
         APPEND ls_col TO lt_col.
         CLEAR: ls_col.
         EXIT.
       ENDIF.
     ENDDO.
   ELSEIF sy-tabix >= 22.
     DATA(zv_str) = ls_objcont-line.
     REPLACE ALL OCCURRENCES OF '|' IN zv_str WITH space.
     CONDENSE zv_str NO-GAPS.
     IF zv_str CA '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
       REPLACE FIRST OCCURRENCE OF '|' IN ls_objcont-line WITH space.
       REPLACE FIRST OCCURRENCE OF '|' IN ls_objcont-line WITH space.
       CONDENSE ls_objcont-line.
       ls_col-col1 = ls_objcont-line.
       DO.
        IF ls_col-col2 IS INITIAL.
          SPLIT ls_col-col1 AT '|' INTO ls_col-col1 ls_col-col2.
        ELSEIF ls_col-col3 IS INITIAL.
          SPLIT ls_col-col2 AT '|' INTO ls_col-col2 ls_col-col3.
        ELSEIF ls_col-col4 IS INITIAL.
          SPLIT ls_col-col3 AT '|' INTO ls_col-col3 ls_col-col4.
        ELSEIF ls_col-col5 IS INITIAL.
          SPLIT ls_col-col4 AT '|' INTO ls_col-col4 ls_col-col5.
        ELSEIF ls_col-col6 IS INITIAL.
          SPLIT ls_col-col5 AT '|' INTO ls_col-col5 ls_col-col6.
        ELSEIF ls_col-col7 IS INITIAL.
          SPLIT ls_col-col6 AT '|' INTO ls_col-col6 ls_col-col7.
        ELSEIF ls_col-col8 IS INITIAL.
          SPLIT ls_col-col7 AT '|' INTO ls_col-col7 ls_col-col8.
        ELSEIF ls_col-col9 IS INITIAL.
          SPLIT ls_col-col8 AT '|' INTO ls_col-col8 ls_col-col9.
        ELSEIF ls_col-col10 IS INITIAL.
          SPLIT ls_col-col9 AT '|' INTO ls_col-col9 ls_col-col10.
        ELSE.
          REPLACE ALL OCCURRENCES OF '|' IN ls_col-col10 WITH space.
          CONDENSE: ls_col-col1,ls_col-col2,ls_col-col3,ls_col-col4,ls_col-col5,ls_col-col6,ls_col-col7,ls_col-col8,ls_col-col9,ls_col-col10.
          APPEND ls_col TO lt_col.
          CLEAR: ls_col.
          EXIT.
        ENDIF.
       ENDDO.
       ELSE.
        CONTINUE.
      ENDIF.
   ENDIF.
 ENDLOOP.

 FIELD-SYMBOLS: <ls_data> TYPE any.

 CREATE DATA et_tab LIKE lt_col.
 ASSIGN et_tab->* TO <ls_data>.
 <ls_data> = lt_col.
 ev_congr = lv_congr.

*DATA: BEGIN OF so_bunit OCCURS 1,
*        sign   TYPE c LENGTH 1,
*        option TYPE c LENGTH 2,
*        low    TYPE fc_bunit,
*        high   TYPE fc_bunit,
*      END OF so_bunit,
*
*      BEGIN OF it_bunit OCCURS 1,
*        bunit TYPE fc_bunit,
*      END OF it_bunit,
*      it_select     TYPE fc00_t_sel,
*      gd_perid      LIKE fc01base-perid_disp,
*      it_cg_cu      TYPE fc01_t_cg_cu,
*      it_cu_curr    TYPE fc00_t_bcf_cu_curr,
*      lv_rldnr      TYPE fc_rldnr,
*      lv_curr       LIKE tf184-curr,
*      lv_rvers      TYPE fc_rvers,
*      lv_perid      TYPE poper VALUE '001'.
*
*it_bunit-bunit = iv_bunit.
*APPEND it_bunit.
*
*so_bunit-sign = 'I'.
*so_bunit-option = 'EQ'.
*so_bunit-low = iv_bunit.
*APPEND so_bunit.
*
*
*
*PERFORM select_orgunits_fill IN PROGRAM ficbcf00
*                               TABLES   it_bunit
*                                        so_bunit            "xrp160698
*                               USING    iv_dimen
*                                        iv_congr
*                                        iv_rvers
*                                        iv_ryear
*                               CHANGING it_select
*                                        gd_perid
*                                        it_cg_cu
*                                        it_cu_curr.
*
*BREAK-POINT.
*
*TYPES: BEGIN OF s_bcf_transl,
*        ryear TYPE fc_ryear,
*        perid TYPE fc_perid.
*INCLUDE TYPE fc00_s_bcf.
*TYPES: END OF s_bcf_transl,
*       t_bcf_transl TYPE s_bcf_transl OCCURS 0.
*
*DATA: BEGIN OF it_acdocu OCCURS 0.
*        INCLUDE STRUCTURE fc05_s_acdocu.
*DATA: END OF it_acdocu.
*
*DATA: it_tf620_del LIKE tf620 OCCURS 0,
*      it_tf620_ins LIKE tf620 OCCURS 0,
*      it_tf620_upd LIKE tf620 OCCURS 0,
*      it_tf630_del LIKE tf630 OCCURS 0,
*      it_tf630_ins LIKE tf630 OCCURS 0,
*      it_tf630_upd LIKE tf630 OCCURS 0.
*
*DATA: it_bcf             TYPE fc00_t_bcf,
*      lt_cg_cu           TYPE fc01_t_cg_cu,
*      lt_ecmca_jen_orig  TYPE fc05_t_acdocu,
*      lt_ecmca_jen_tran  TYPE fc05_t_acdocu,
*      lt_messages        TYPE fc05_t_ipi_message,
*      it_status          TYPE fc02_t_status,
*      lt_cu_lcurr        TYPE fc05_t_cu_curr,
*      it_data            LIKE TABLE OF fc03list,
*      it_bcf_transl      TYPE t_bcf_transl,
*      l_dimen_src        TYPE fc_dimen,
*      it_plevl           TYPE fc00_t_ra_plevl,
*      it_select_wa       LIKE LINE OF it_select,
*      ld_leave_program   TYPE c LENGTH 1.
*
*
*PERFORM select_orgunits_fill IN PROGRAM ficbcf00
*                             TABLES   it_bunit
*                                      so_bunit
*                             USING    iv_dimen
*                                      iv_congr
*                                      iv_rvers
*                                      iv_ryear
*                             CHANGING it_select
*                                      lv_perid
*                                      it_cg_cu
*                                      it_cu_curr.
*
*PERFORM select_plevl_fill IN PROGRAM ficbcf00
*                         TABLES   it_plevl
*                         CHANGING it_select.
*
*PERFORM select_dimen_fill IN PROGRAM ficbcf00
*                         USING    iv_dimen
*                                  iv_ryear                 "josCC1908
*                         CHANGING it_select
*                                  l_dimen_src.
*
*MOVE:     'RBUNIT'  TO it_select_wa-fieldname,
*          'I'       TO it_select_wa-sign,
*          'EQ'      TO it_select_wa-option,
*          iv_bunit  TO it_select_wa-low.
*APPEND it_select_wa TO it_select.
*
*PERFORM group_currency_get IN PROGRAM ficbcf00
*                            USING iv_dimen
*                                  iv_congr
*                                  iv_rvers
*                                  iv_ryear
*                            CHANGING
*                                  lv_curr
*                                  lv_rvers.
*
*PERFORM rldnr_get IN PROGRAM ficbcf00
*                      USING    iv_dimen
*                               iv_rvers
*                               iv_congr
*                               iv_ryear
*                      CHANGING it_select
*                               lv_rldnr.
*
*
* PERFORM status_check IN PROGRAM ficbcf00
*                      USING iv_dimen
*                            iv_itclg
*                            iv_rvers
*                            iv_ryear
*                            lv_perid
*                            lv_rldnr
*                            'X'
*                            space
*                       CHANGING
*                            it_cg_cu
*                            ld_leave_program
*                            it_status.
*
*PERFORM create_cf_data IN PROGRAM ficbcf00 TABLES it_acdocu
*                                  it_tf620_del
*                                  it_tf620_ins
*                                  it_tf620_upd
*                                  it_tf630_del
*                                  it_tf630_ins
*                                  it_tf630_upd
*                           USING it_select
*                                 it_cg_cu
*                                 it_cu_curr
*                                 lv_rldnr
*                                 'X'
*                                 iv_dimen
*                                 iv_rvers
*                                 iv_ryear
*                                 iv_itclg
*                                 lv_curr
*                                 'X'
*                                 space
*                       CHANGING  lt_ecmca_jen_orig          "xrp030299
*                                 lt_ecmca_jen_tran          "xrp030299
*                                 it_bcf                     "xrp030299
*                                 lt_messages                "xrp021199
*                                 it_status                  "xrp030701
*                                 lt_cu_lcurr.
*
*
*  PERFORM list_fill_data IN PROGRAM ficbcf00
*                       TABLES it_data
*                       USING  iv_dimen
*                              iv_itclg
*                              lv_curr
*                              lt_cg_cu
*                              it_cu_curr
*                              it_bcf_transl
*                              it_bcf.

ENDFUNCTION.

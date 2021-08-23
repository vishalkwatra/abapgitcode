class /EY1/CL_DATA_MONITOR_CURR_TRAN definition
  public
  inheriting from /EY1/CL_DATA_MONITOR_ABSTRACT
  final
  create private .

public section.

  class-methods GET_INSTANCE
    importing
      !BUNIT type FC_BUNIT optional
      !RYEAR type FC_RYEAR optional
      !INTENTION type /EY1/SAV_INTENT optional
      !PERIOD_FROM type POPER optional
      !PERIOD_TO type POPER optional
      !LOCAL_CURRENCY type FINS_VHCUR12 optional
      !LOCAL_CURRENCY_TYPE type FC_CURR optional
      !GROUP_CURRENCY type GCURR optional
      !GROUP_CURRENCY_TYPE type FINCS_GROUPCURRENCY optional
      !ITCLG type FC_ITCLG optional
      !RVERS type FC_RVERS optional
      !RLDNR type RLDNR optional
    returning
      value(RO_DATA_MON) type ref to /EY1/CL_DATA_MONITOR_ABSTRACT .

  methods /EY1/IF_DATA_MONITOR~SUBMIT_ACTION
    redefinition .
  methods /EY1/IF_DATA_MONITOR~VALIDATE
    redefinition .
protected section.
private section.

  methods CONSTRUCTOR .
  methods GENERATE_URL
    changing
      !CV_LOG type FINCS_LOGNUMBER
      !CV_URL type CHAR1024 .
ENDCLASS.



CLASS /EY1/CL_DATA_MONITOR_CURR_TRAN IMPLEMENTATION.


METHOD /EY1/IF_DATA_MONITOR~SUBMIT_ACTION.

    CONSTANTS: lc_text     TYPE string VALUE 'Currency Translation(1100): No Log Generated For Version ',##NO_TEXT
               lc_suc_text TYPE string VALUE 'Currency Translation(1100): Log Generated For Version '.##NO_TEXT

    TYPES: BEGIN        OF ts_bunit,
                sign    TYPE char1,
                option  TYPE char2,
                low     TYPE fc_bunit,
                high    TYPE fc_bunit,
           END          OF ts_bunit.

    DATA:  ls_msg       TYPE bapiret2.

    DATA:  ra_bunit     TYPE TABLE OF ts_bunit,
           ls_bunit     TYPE ts_bunit.

    DATA:  lt_log       TYPE TABLE OF fincs_log_header,
           ls_log       TYPE fincs_log_header,
           lt_log_itm   TYPE TABLE OF fincs_log_item,
           ls_log_itm   TYPE fincs_log_item.

    DATA:  lv_time      TYPE sy-uzeit,
           lv_lines     TYPE i.


    DATA: jobname       TYPE tbtcjob-jobname VALUE
                             'CURR_TRANS'.
    DATA: jobcount      TYPE tbtcjob-jobcount,
          host          TYPE msxxlist-host.
    TYPES: BEGIN OF ts_starttime.
            INCLUDE TYPE tbtcstrt.
    TYPES: END OF ts_starttime.
    DATA: starttime TYPE ts_starttime.
    DATA: starttimeimmediate TYPE btch0000-char1 VALUE 'X'.
    DATA: lt_tf184           TYPE TABLE OF tf184,
          ls_tf184           TYPE tf184.
*    DATA: lv_year     TYPE gjahr,
*          lv_year_inv TYPE fc_ryear.

      "New
*      lv_year = gs_global_params-ryear.
*      CALL FUNCTION '/EY1/CONVERT_DATE_TO_INV_DATE'
*        EXPORTING
*          iv_year           = lv_year
*        IMPORTING
*         ev_year_inv        = lv_year_inv.
*
*      SELECT SINGLE rvers FROM tf184
*          INTO gs_global_params-rvers
*          WHERE dimen = gs_tf004-dimen
*          AND   congr = gs_tf004-congr
*          AND   rldnr = gs_tf004-rldnr
*          AND   ryear = lv_year_inv.
      SELECT  rvers FROM tf184
        UP TO 1 ROWS
        INTO CORRESPONDING FIELDS OF TABLE lt_tf184
        WHERE dimen = gs_tf004-dimen
        AND   congr = gs_tf004-congr
        AND   rldnr = gs_tf004-rldnr
        ORDER BY ryear ASCENDING.
     IF sy-subrc = 0.
       READ TABLE lt_tf184 TRANSPORTING rvers INTO ls_tf184 INDEX 1.
       IF sy-subrc = 0.
          gs_global_params-rvers = ls_tf184-rvers.
       ENDIF.
     ENDIF.

      "End

      lv_time = sy-uzeit.
      CONCATENATE jobname lv_time INTO jobname SEPARATED BY ':'.
      CALL FUNCTION '/EY1/FM_DATA_MONITOR_CURR_TRAN' IN UPDATE TASK
        EXPORTING
          iv_dimen             =  gs_tf004-dimen
          iv_congr             =  gs_tf004-congr
          iv_bunit             =  gs_global_params-bunit
          iv_rvers             =  gs_global_params-rvers
          iv_ryear             =  gs_global_params-ryear
          iv_period_from       =  gs_global_params-period_from
          iv_period_to         =  gs_global_params-period_to
          iv_jobname           =  jobname
          iv_rldnr             =  gs_tf004-rldnr
                .

      COMMIT WORK AND WAIT.


     DO 20 TIMES.
       SELECT SINGLE * FROM tbtco
         INTO @DATA(ls_job)
         WHERE jobname = @jobname.
       IF sy-subrc = 0.
         IF ls_job-status = 'A' OR ls_job-status = 'F'.
           EXIT.
         ELSE.
           WAIT UP TO 1 SECONDS.
         ENDIF.
       ELSE.
         WAIT UP TO 1 SECONDS.
       ENDIF.
     ENDDO.

     SELECT cnsldtnlognumber cnsldtnlogdate cnsldtnlogtime
       FROM fincs_log_header
       INTO CORRESPONDING FIELDS OF TABLE lt_log
       WHERE cnsldtntasktype  = '05'
       AND   cnsldtndimension = gs_tf004-dimen
       AND   cnsldtngroup     = gs_tf004-congr
       AND   cnsldtnledger    = gs_tf004-rldnr
       AND   cnsldtnversion   = gs_global_params-rvers
       AND   fiscalyear       = gs_global_params-ryear
       AND   fiscalperiod     = gs_global_params-period_to
       AND   userid           = sy-uname
       AND   cnsldtnlogdate   = sy-datum
       "AND   cnsldtnlogtime   GT lv_time
       AND   status           = 'S'
       ORDER BY cnsldtnlogdate cnsldtnlogtime DESCENDING."#EC CI_NOFIELD
      IF sy-subrc = 0.
        DESCRIBE TABLE lt_log LINES lv_lines.
        IF lv_lines GE 1.
          READ TABLE lt_log INTO ls_log INDEX 1.
          IF sy-subrc = 0.
            SELECT cnsldtngroup,
                   cnsldtnmethod,
                   cnsldtnsetidentification,
                   cnsldtnlineitemtype,
                   cnsldtnfinstmntitm,
                   cnsldtnfinstmntsubitmcat,
                   cnsldtnfinstmntsubitm,
                   cnsldtnfinstmntitmr,
                   currencytranskey,
                   exchangerate,
                   SUM( amountinlocalcrcy ) AS amountinlocalcrcy,
                   cnsldtnlocalcurrency,
                   SUM( amountingroupcrcy ) AS amountingroupcrcy,
                   cnsldtngroupcurrency,
                   SUM( diffamount ) AS diffamount,
                   SUM( reffamount ) AS reffamount
              FROM fincs_log_item
              INTO TABLE @et_log
              WHERE cnsldtnlognumber = @ls_log-cnsldtnlognumber
              AND cnsldtnlineitemtype = 'CU'
              GROUP BY cnsldtngroup, cnsldtnmethod, cnsldtnsetidentification, cnsldtnlineitemtype,
              cnsldtnfinstmntitm, cnsldtnfinstmntsubitmcat, cnsldtnfinstmntsubitm,cnsldtnfinstmntitmr,
              currencytranskey, exchangerate, cnsldtnlocalcurrency, cnsldtngroupcurrency."#EC CI_NOFIELD
            IF sy-subrc <> 0.
              "Message - No Log
              ls_msg-type         = 'E'.
              ls_msg-id           = '/EY1/'."##NO_TEXT
              ls_msg-number       = '001'."##NO_TEXT
              ls_msg-message      = lc_text && space &&  gs_global_params-rvers.
            ELSE.
              ls_msg-type         = 'S'.
              ls_msg-id           = '/EY1/'."##NO_TEXT
              ls_msg-number       = '001'."##NO_TEXT
              ls_msg-message      = lc_suc_text && gs_global_params-rvers.
              ls_msg-message      = | { lc_suc_text } | && |{ gs_global_params-rvers }| && | With Log Number | && | { ls_log-cnsldtnlognumber } |.
              cv_log              = ls_log-cnsldtnlognumber.
              me->generate_url(
                CHANGING
                  cv_log          = cv_log
                  cv_url          = cv_url ).
            ENDIF.
          ELSE.
            "Message - No Log
             ls_msg-type      = 'E'.
             ls_msg-id        = '/EY1/'."##NO_TEXT
             ls_msg-number    = '001'."##NO_TEXT
             ls_msg-message   = lc_text && space && gs_global_params-rvers.
          ENDIF.
        ELSE.
          "Return Message Accordingly.
           ls_msg-type        = 'E'.
           ls_msg-id          = '/EY1/'."##NO_TEXT
           ls_msg-number      = '001'."##NO_TEXT
           ls_msg-message     = lc_text && space && gs_global_params-rvers.
        ENDIF.
      ELSE.
        ls_msg-type        = 'E'.
        ls_msg-id          = '/EY1/'."##NO_TEXT
        ls_msg-number      = '001'."##NO_TEXT
        ls_msg-message     = lc_text && space && gs_global_params-rvers.
      ENDIF.

      IF ls_msg IS NOT INITIAL.
        APPEND ls_msg TO et_message.
      ENDIF.

ENDMETHOD.


 method /EY1/IF_DATA_MONITOR~VALIDATE.
*CALL METHOD SUPER->ZIF_DATA_MONITOR~VALIDATE
**  IMPORTING
**    et_message =
*    .
  endmethod.


  METHOD CONSTRUCTOR.
    super->constructor( ).
  ENDMETHOD.


  METHOD GENERATE_URL.

    data lo_nwbc_runtime    type ref to if_nwbc_runtime.
    data: lr_server type ref to cl_http_server_net.
    data lv_ibn_location type cl_lsapi_manager=>url.
    data ls_params type line of tihttpnvp.

    data:
      lt_fields          type tihttpnvp,
      lv_window_features type string,
      lv_window_id       type string,
      lv_window_title    type string,
      lv_report_type     type string,
      lv_navigation_mode like if_wd_portal_integration=>co_show_inplace.

      lv_ibn_location = cl_lsapi_manager=>create_ibn_url( object = 'ConsolidationLog' action = 'log' ).

      create object lr_server.
      lo_nwbc_runtime = cl_nwbc_factory=>get_nwbc_runtime( io_server = lr_server ).

      lo_nwbc_runtime->epcm_do_navigate( exporting target           = lv_ibn_location
                                               importing target_url       = lv_ibn_location
                                                         report_type      = lv_report_type
                                               changing  windows_features = lv_window_features
                                                         windows_name     = lv_window_id
                                                         windows_title    = lv_window_title
                                                         mode             = lv_navigation_mode
                                                         post_body        = lt_fields ).

      cv_url = lv_ibn_location.
      cv_url = cv_url && |&/LogHeaderSet/| && cv_log.


  ENDMETHOD.


  METHOD GET_INSTANCE.
   DATA: lr_obj TYPE REF TO /ey1/cl_data_monitor_curr_tran.

   IF gr_data_mon IS NOT INITIAL.
     FREE gr_data_mon.
   ENDIF.

   CREATE OBJECT lr_obj.

   gr_data_mon ?= lr_obj.

    "Get Global Param Reference
   gr_data_mon->gr_global_param = /ey1/sav_cl_global_params=>get_instance( ).

   gr_data_mon->read_global_params( ).


   IF bunit IS NOT INITIAL.
     gr_data_mon->gs_global_params-bunit = bunit.
   ENDIF.

   IF ryear IS NOT INITIAL.
     gr_data_mon->gs_global_params-ryear = ryear.
   ENDIF.

   IF intention IS NOT INITIAL.
     gr_data_mon->gs_global_params-intention = intention.
   ENDIF.

   IF period_from IS NOT INITIAL.
     gr_data_mon->gs_global_params-period_from = period_from.
   ENDIF.

   IF period_to IS NOT INITIAL.
     gr_data_mon->gs_global_params-period_to = period_to.
   ENDIF.

   IF local_currency IS NOT INITIAL.
     gr_data_mon->gs_global_params-local_currency = local_currency.
   ENDIF.

   IF local_currency_type IS NOT INITIAL.
     gr_data_mon->gs_global_params-local_currency_type = local_currency_type.
   ENDIF.

   IF group_currency IS NOT INITIAL.
     gr_data_mon->gs_global_params-group_currency = group_currency.
   ENDIF.

   IF group_currency_type IS NOT INITIAL.
     gr_data_mon->gs_global_params-group_currency_type = group_currency_type.
   ENDIF.

   IF itclg IS NOT INITIAL.
     gr_data_mon->gs_global_params-itclg = itclg.
   ENDIF.

   IF rvers IS NOT INITIAL.
     gr_data_mon->gs_global_params-rvers = rvers.
   ENDIF.

   IF rldnr IS NOT INITIAL.
     gr_data_mon->gs_tf004-rldnr = rldnr.
   ENDIF.

   ro_data_mon ?= gr_data_mon.

  ENDMETHOD.
ENDCLASS.

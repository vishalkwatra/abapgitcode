class /EY1/CL_DATA_MONITOR_BAL_TRANS definition
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
ENDCLASS.



CLASS /EY1/CL_DATA_MONITOR_BAL_TRANS IMPLEMENTATION.


METHOD /EY1/IF_DATA_MONITOR~SUBMIT_ACTION.

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
                             'BAL_TRANS'.
    DATA: jobcount      TYPE tbtcjob-jobcount,
          host          TYPE msxxlist-host.
    TYPES: BEGIN OF ts_starttime.
            INCLUDE TYPE tbtcstrt.
    TYPES: END OF ts_starttime.
    DATA: starttime TYPE ts_starttime.
    DATA: starttimeimmediate TYPE btch0000-char1 VALUE 'X'.
    DATA: lt_tf184           TYPE TABLE OF tf184,
          ls_tf184           TYPE tf184.

    SELECT  rvers FROM tf184
        UP TO 1 ROWS
        INTO CORRESPONDING FIELDS OF TABLE lt_tf184
        WHERE dimen = gs_tf004-dimen
        AND   congr = gs_global_params-congr
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
      CALL FUNCTION '/EY1/FM_DATA_MONITOR_BAL_TRANS' IN UPDATE TASK
        EXPORTING
          iv_dimen             =  gs_tf004-dimen
          iv_congr             =  gs_global_params-congr
          iv_bunit             =  gs_global_params-bunit
          iv_rvers             =  gs_global_params-rvers
          iv_ryear             =  gs_global_params-ryear
          iv_period_from       =  gs_global_params-period_from
          iv_period_to         =  gs_global_params-period_to
          iv_jobname           =  jobname
          iv_rldnr             =  gs_tf004-rldnr
          iv_itclg             =  gs_global_params-itclg
                .
     COMMIT WORK AND WAIT.

     DO 20 TIMES.
       SELECT SINGLE * FROM tbtco
         INTO @DATA(ls_job)
         WHERE jobname = @jobname.
       IF sy-subrc = 0.
         IF ls_job-status = 'A' OR ls_job-status = 'F'.
           "Read Log
           DATA: lv_congr TYPE congr.
           TYPES: BEGIN OF ty_data,
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
                 END OF ty_data.
            DATA: lt_data TYPE TABLE OF ty_data.
*           CALL FUNCTION '/EY1/FM_GET_BAL_TRANSF_LOG'
*            EXPORTING
**              IV_DIMEN         =
**              IV_CONGR         =
**              IV_RVERS         =
**              IV_RYEAR         =
**              IV_BUNIT         =
**              IV_ITCLG         =
*              iv_jobname       = jobname
*            IMPORTING
*              et_tab           = lt_data
*              ev_congr         = lv_congr
*                     .


           EXIT.
         ELSE.
           WAIT UP TO 1 SECONDS.
         ENDIF.
       ELSE.
         WAIT UP TO 1 SECONDS.
       ENDIF.
     ENDDO.

     DATA(lv_new_year) = gs_global_params-ryear + 1.
     IF sy-subrc = 0 AND ls_job-status = 'F'.
      ls_msg-id      = '/EY1/'.
      ls_msg-number  = '000'.
      ls_msg-type    = 'S'.
      ls_msg-message = | Balance Transfer(1010): Balance was carried forward successfully to Year | && lv_new_year && | and version | && gs_global_params-rvers.
     ELSEIF  ls_job-status = 'A'.
      ls_msg-id      = '/EY1/'.
      ls_msg-number  = '000'.
      ls_msg-type    = 'E'.
      ls_msg-message = | Balance Transfer(1010): Error in Balance carry forward to Year | && lv_new_year && | and version | && gs_global_params-rvers.
     ENDIF.

    APPEND ls_msg TO et_message.


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


  METHOD GET_INSTANCE.
   DATA: lr_obj TYPE REF TO /ey1/cl_data_monitor_bal_trans.

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

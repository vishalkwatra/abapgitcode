class /EY1/CL_DATA_MONITOR_UTIL definition
  public
  final
  create private .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_DATA_MON_UTIL) type ref to /EY1/CL_DATA_MONITOR_UTIL .
  methods EXECUTE_ACTION
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
      !ACTION type FC_CACTI
      !RLDNR type RLDNR optional
    exporting
      !ET_MESSAGE type BAPIRET2_T
      !ET_LOG type /EY1/TT_CUR_TRANS_LOG
    changing
      !CV_LOG type FINCS_LOGNUMBER optional
      !CV_URL type CHAR1024 optional .
  methods EXECUTE_ALL_ACTIONS
    importing
      !BUNIT type FC_BUNIT optional
      !RYEAR type FC_RYEAR optional
      !INTENTION type ZINTENT optional
      !PERIOD_FROM type POPER optional
      !PERIOD_TO type POPER optional
      !LOCAL_CURRENCY type FINS_VHCUR12 optional
      !LOCAL_CURRENCY_TYPE type FC_CURR optional
      !GROUP_CURRENCY type GCURR optional
      !GROUP_CURRENCY_TYPE type FINCS_GROUPCURRENCY optional
      !ITCLG type FC_ITCLG optional
      !RVERS type FC_RVERS optional
      !RLDNR type RLDNR optional
    exporting
      !ET_MESSAGE type BAPIRET2_T
    changing
      !CV_LOG type FINCS_LOGNUMBER optional
      !CV_URL type CHAR1024 optional .
  methods EXECUTE_ACTIONS_MANGE_INTNTN
    importing
      value(BUNIT) type FC_BUNIT optional
      value(RYEAR) type FC_RYEAR optional
      value(INTENTION) type ZINTENT optional
      value(PERIOD_FROM) type POPER optional
      value(PERIOD_TO) type POPER optional
      value(LOCAL_CURRENCY) type FINS_VHCUR12 optional
      value(LOCAL_CURRENCY_TYPE) type FC_CURR optional
      value(GROUP_CURRENCY) type GCURR optional
      value(GROUP_CURRENCY_TYPE) type FINCS_GROUPCURRENCY optional
      value(ITCLG) type FC_ITCLG optional
      value(RVERS) type FC_RVERS optional
      value(RLDNR) type RLDNR optional
    exporting
      value(ET_MESSAGE) type BAPIRET2_T
    changing
      value(CV_LOG) type FINCS_LOGNUMBER optional
      value(CV_URL) type CHAR1024 optional .
protected section.
private section.

  data GR_DATA_MON type ref to /EY1/CL_DATA_MONITOR_ABSTRACT .
  class-data GR_DATA_MON_UTIL type ref to /EY1/CL_DATA_MONITOR_UTIL .

  methods CONSTRUCTOR .
ENDCLASS.



CLASS /EY1/CL_DATA_MONITOR_UTIL IMPLEMENTATION.


  method CONSTRUCTOR.
  endmethod.


  METHOD EXECUTE_ACTION.

     CASE action.
      WHEN '1015'.
            gr_data_mon_util->gr_data_mon = /ey1/cl_data_monitor_jv_releas=>get_instance(
                                                                                        EXPORTING
                                                                                          bunit                 = bunit
                                                                                          period_from           = period_from
                                                                                          ryear                 = ryear
                                                                                          period_to             = period_to
                                                                                          local_currency        = local_currency
                                                                                          local_currency_type   = local_currency_type
                                                                                          group_currency        = group_currency
                                                                                          group_currency_type   = group_currency_type
                                                                                          itclg                 = itclg
                                                                                          rvers                 = rvers
                                                                                          rldnr                 = rldnr
                                                                                      ).
      WHEN '1100'.
            gr_data_mon_util->gr_data_mon = /ey1/cl_data_monitor_curr_tran=>get_instance(
                                                                                        EXPORTING
                                                                                          bunit                 = bunit
                                                                                          period_from           = period_from
                                                                                          ryear                 = ryear
                                                                                          period_to             = period_to
                                                                                          local_currency        = local_currency
                                                                                          local_currency_type   = local_currency_type
                                                                                          group_currency        = group_currency
                                                                                          group_currency_type   = group_currency_type
                                                                                          itclg                 = itclg
                                                                                          rvers                 = rvers
                                                                                          rldnr                 = rldnr
                                                                                      ).
      WHEN '1010'.
           gr_data_mon_util->gr_data_mon = /ey1/cl_data_monitor_bal_trans=>get_instance(
                                                                                        EXPORTING
                                                                                          bunit                 = bunit
                                                                                          period_from           = period_from
                                                                                          ryear                 = ryear
                                                                                          period_to             = period_to
                                                                                          local_currency        = local_currency
                                                                                          local_currency_type   = local_currency_type
                                                                                          group_currency        = group_currency
                                                                                          group_currency_type   = group_currency_type
                                                                                          itclg                 = itclg
                                                                                          rvers                 = rvers
                                                                                          rldnr                 = rldnr
                                                                                      ).
      WHEN OTHERS.
    ENDCASE.


    gr_data_mon_util->gr_data_mon->/ey1/if_data_monitor~validate(
                                                              IMPORTING
                                                                et_message = et_message
                                                            ).

   IF gr_data_mon_util IS NOT INITIAL.
    READ TABLE et_message TRANSPORTING NO FIELDS WITH KEY type = 'E'.
    IF sy-subrc <> 0.
      gr_data_mon_util->gr_data_mon->/ey1/if_data_monitor~submit_action(
                                                                    IMPORTING
                                                                      et_message = et_message
                                                                      et_log     = et_log
                                                                     CHANGING
                                                                      cv_log     = cv_log
                                                                      cv_url     = cv_url
                                                                    ).
    ENDIF.
   ENDIF.

  ENDMETHOD.


  METHOD execute_actions_mange_intntn.

   DATA: lt_cacti TYPE /EY1/tt_cacti,
         ls_cacti TYPE /EY1/ts_cacti.

   ls_cacti-cacti = '1015'.
   APPEND ls_cacti TO lt_cacti.
   ls_cacti-cacti = '1010'.
   APPEND ls_cacti TO lt_cacti.


   LOOP AT lt_cacti INTO ls_cacti.
     CALL METHOD execute_action(
                                  EXPORTING
                                    bunit                  = bunit
                                    ryear                  = ryear
                                    intention              = intention
                                    period_from            = period_from
                                    period_to              = period_to
                                    local_currency         = local_currency
                                    local_currency_type    = local_currency_type
                                    group_currency         = group_currency
                                    group_currency_type    = group_currency_type
                                    itclg                  = itclg
                                    rvers                  = rvers
                                    action                 = ls_cacti-cacti
                                    rldnr                  = rldnr
                                  IMPORTING
                                    et_message             = et_message
                                  CHANGING
                                    cv_log                 = cv_log
                                    cv_url                 = cv_url
                               ).
   ENDLOOP.


  ENDMETHOD.


  METHOD EXECUTE_ALL_ACTIONS.

   DATA: lt_cacti TYPE /EY1/tt_cacti,
         ls_cacti TYPE /EY1/ts_cacti.

   gr_data_mon_util->gr_data_mon = /ey1/cl_data_monitor_jv_releas=>get_instance(
                                                                                        EXPORTING
                                                                                          period_from           = period_from
                                                                                          ryear                 = ryear
                                                                                          period_to             = period_to
                                                                                          local_currency        = local_currency
                                                                                          local_currency_type   = local_currency_type
                                                                                          group_currency        = group_currency
                                                                                          group_currency_type   = group_currency_type
                                                                                          itclg                 = itclg
                                                                                          rvers                 = rvers
                                                                                          rldnr                 = rldnr
                                                                                      ).

   CALL METHOD gr_data_mon->read_consolidation_type(
                                                        IMPORTING
                                                          et_cacti = lt_cacti
                                                   ).

   LOOP AT lt_cacti INTO ls_cacti.
     CALL METHOD execute_action(
                                  EXPORTING
                                    bunit                  = bunit
                                    ryear                  = ryear
                                    intention              = intention
                                    period_from            = period_from
                                    period_to              = period_to
                                    local_currency         = local_currency
                                    local_currency_type    = local_currency_type
                                    group_currency         = group_currency
                                    group_currency_type    = group_currency_type
                                    itclg                  = itclg
                                    rvers                  = rvers
                                    action                 = ls_cacti-cacti
                                    rldnr                  = rldnr
                                  IMPORTING
                                    et_message             = et_message
                                  CHANGING
                                    cv_log                 = cv_log
                                    cv_url                 = cv_url
                               ).
   ENDLOOP.

  ENDMETHOD.


  METHOD GET_INSTANCE.

    IF gr_data_mon_util IS INITIAL.
      CREATE OBJECT gr_data_mon_util.
    ENDIF.

    ro_data_mon_util = gr_data_mon_util.

  ENDMETHOD.
ENDCLASS.

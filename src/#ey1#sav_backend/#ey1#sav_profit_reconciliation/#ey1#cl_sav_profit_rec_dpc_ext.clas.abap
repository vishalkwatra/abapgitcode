class /EY1/CL_SAV_PROFIT_REC_DPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_PROFIT_REC_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_PROFIT_REC_DPC_EXT IMPLEMENTATION.


   METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

********************************************************************************
*    Type Declaration
********************************************************************************

  TYPES: BEGIN OF ts_message,
     type       TYPE c LENGTH 1,
     id         TYPE c LENGTH 20,
     number     TYPE c LENGTH 3,
     message    TYPE c LENGTH 220,
     log_no     TYPE c LENGTH 20,
     log_msg_no TYPE c LENGTH 6,
     message_v1 TYPE c LENGTH 50,
     message_v2 TYPE c LENGTH 50,
     message_v3 TYPE c LENGTH 50,
     message_v4 TYPE c LENGTH 50,
     parameter  TYPE c LENGTH 32,
     row        TYPE i,
     field      TYPE c LENGTH 30,
     system     TYPE c LENGTH 10,
     guid       TYPE sysuuid_x,
     lognumber  TYPE sysuuid_x,
     url        TYPE string,
  END OF ts_message .
  TYPES: tt_message TYPE STANDARD TABLE OF ts_message.

********************************************************************************
*    Data Declaration
********************************************************************************
    DATA: lo_global_param       TYPE REF TO /ey1/cl_sav_profit_rec_mpc=>ts_globalparameter01,
          lo_glbparam_utility   TYPE REF TO /ey1/sav_cl_global_params,
          lo_data_mon_util      TYPE REF TO /ey1/cl_data_monitor_util,

          lt_log                TYPE /ey1/tt_cur_trans_log,
          lt_ret_log            TYPE tt_message,
          lt_message            TYPE bapiret2_t,

          ls_user_global_params TYPE /ey1/sav_str_glbl_params,
          ls_parameter          TYPE /iwbep/s_mgw_name_value_pair,
          ls_ret_log            TYPE ts_message,

          lv_action             TYPE fc_cacti,
          lv_cons_unit          TYPE fc_bunit,
          lv_ryear              TYPE fc_ryear,
          lv_lcl_cur            TYPE fc_curr,
          lv_grp_cur            TYPE gcurr,
          lv_per_frm            TYPE poper,
          lv_per_to             TYPE poper,
          lv_log                TYPE fincs_lognumber,
          lv_rldnr              TYPE rldnr,
          lv_url                TYPE c LENGTH 1024.

    CREATE DATA lo_global_param.

    CASE iv_action_name.

********************************************************************************
*    Global Parameter
********************************************************************************
      WHEN 'GlobalParameter'.

        lo_glbparam_utility = /ey1/sav_cl_global_params=>get_instance( ).

        CALL METHOD lo_glbparam_utility->get_user_settings
          IMPORTING
            es_user_global_params = ls_user_global_params.

*       Exception handling when no records found
        IF ls_user_global_params IS INITIAL.
*         Global parameter cannot be found for user: &1.
          mo_context->get_message_container( )->add_message( iv_msg_type   = 'E'
                                                             iv_msg_id     = /ey1/sav_if_constants=>c_msg_id_savotta
                                                             iv_msg_number = '016'
                                                             iv_msg_v1     = |{ sy-uname }| ).

          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              message_container = mo_context->get_message_container( ).
        ENDIF.

        lo_global_param->consolidationunit            = ls_user_global_params-bunit.
        lo_global_param->fiscalyear                   = ls_user_global_params-ryear.
        lo_global_param->intention                    = ls_user_global_params-intention.
        lo_global_param->periodfrom                   = ls_user_global_params-period_from.
        lo_global_param->periodto                     = ls_user_global_params-period_to.
        lo_global_param->localcurrency                = ls_user_global_params-local_currency.
        lo_global_param->localcurrencytype            = ls_user_global_params-local_currency_type.
        lo_global_param->groupcurrency                = ls_user_global_params-group_currency.
        lo_global_param->groupcurrencytype            = ls_user_global_params-group_currency_type.
        lo_global_param->consolidationchartofaccounts = ls_user_global_params-itclg.
        lo_global_param->consolidationgroup           = ls_user_global_params-congr.
*        lo_global_param->consolidationversion         = ls_user_global_params-rvers.

        er_data                                       = lo_global_param.

********************************************************************************
*     Data Monitor
********************************************************************************
      WHEN 'DataMonitorParameters'.

*        Reading function import parameters

*        Action
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'Action'.
            IF sy-subrc = 0.
              lv_action   = ls_parameter-value.
            ENDIF.

*        Consolidation Unut
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'ConsolidationUnit'.
            IF sy-subrc = 0.
              lv_cons_unit = ls_parameter-value.
            ENDIF.

*        Fiscal Year
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'FiscalYear'.
            IF sy-subrc = 0.
              lv_ryear = ls_parameter-value.
            ENDIF.

*        Group Currency
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'GroupCurrency'.
            IF sy-subrc = 0.
              lv_grp_cur = ls_parameter-value.
            ENDIF.

*        Local Currency
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'LocalCurrency'.
            IF sy-subrc = 0.
              lv_lcl_cur = ls_parameter-value.
            ENDIF.

*        Period from
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'PeriodFrom'.
            IF sy-subrc = 0.
              lv_per_frm = ls_parameter-value.
            ENDIF.

*        Period to
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'PeriodTo'.
            IF sy-subrc = 0.
              lv_per_to = ls_parameter-value.
            ENDIF.

*        Ledger
            READ TABLE it_parameter INTO ls_parameter WITH KEY name = 'Ledger'.
            IF sy-subrc = 0.
              lv_rldnr = ls_parameter-value.
            ENDIF.


            CALL METHOD lo_data_mon_util->execute_all_actions
              EXPORTING
                bunit               = lv_cons_unit    " Undefined range (can be used for patch levels)
                ryear               = lv_ryear        " Fiscal year
                period_from         = lv_per_frm      " Posting period
                period_to           = lv_per_to       " Posting period
                local_currency_type = lv_lcl_cur      " Amount in Company Code Currency
                group_currency_type = lv_grp_cur      " Currency key of the ledger currency
                rldnr               = lv_rldnr
              IMPORTING
                et_message          = lt_message      " Return table
              CHANGING
                cv_log              = lv_log
                cv_url              = lv_url.         " Table Type - Currency Translation Log

            LOOP AT lt_message INTO DATA(ls_msg).
              MOVE-CORRESPONDING ls_msg TO ls_ret_log.
              IF ls_msg-message CS '1100'.
               ls_ret_log-lognumber = lv_log.
               ls_ret_log-url       = lv_url.
              ENDIF.
              APPEND ls_ret_log TO lt_ret_log.
            ENDLOOP.

            copy_data_to_ref(
                            EXPORTING
                              is_data = lt_ret_log
                            CHANGING
                              cr_data = er_data
                            ).

********************************************************************************
*    Handling Others
********************************************************************************
      WHEN OTHERS.
        CALL METHOD super->/iwbep/if_mgw_appl_srv_runtime~execute_action
          EXPORTING
            iv_action_name          = iv_action_name
            it_parameter            = it_parameter
            io_tech_request_context = io_tech_request_context
          IMPORTING
            er_data                 = er_data.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

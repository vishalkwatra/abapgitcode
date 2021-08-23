class /EY1/CL_SAV_EFFECTIVE__DPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_EFFECTIVE__DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_EFFECTIVE__DPC_EXT IMPLEMENTATION.


   METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.
********************************************************************************
*    Data Declaration
********************************************************************************
    DATA: lo_global_param       TYPE REF TO /EY1/CL_SAV_PROFIT_REC_MPC=>ts_globalparameter01,
          lo_glbparam_utility   TYPE REF TO /ey1/sav_cl_global_params,
          ls_user_global_params TYPE /ey1/sav_str_glbl_params.

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

        er_data                                       = lo_global_param.

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

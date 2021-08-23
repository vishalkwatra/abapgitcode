class /EY1/CL_SAV_RECON_GAAP_DPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_RECON_GAAP_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.

  methods CONVERTCURRENCYS_GET_ENTITY
    redefinition .
  methods LEDGERSET_GET_ENTITYSET
    redefinition .
private section.

  methods HANDLE_CHANGESET_CREATE_ENTITY
    importing
      !IT_CHANGESET_REQUEST type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_REQUEST
    changing
      !CT_CHANGESET_RESPONSE type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_RESPONSE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods HANDLE_CHANGESET_UPDATE_G2S
    importing
      !IT_CHANGESET_REQUEST type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_REQUEST
    changing
      !CT_CHANGESET_RESPONSE type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_RESPONSE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
ENDCLASS.



CLASS /EY1/CL_SAV_RECON_GAAP_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_begin.
    cv_defer_mode = abap_true.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_end.
    COMMIT WORK.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_process.
    "Data Declaration
    DATA: ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          lt_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_t_changeset_request,
          ls_changeset          TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          lt_group_request      TYPE /iwbep/if_mgw_appl_types=>ty_t_changeset_request,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_data               TYPE /EY1/CL_SAV_RECON_GAAP_MPC=>ts_xey1xsav_c_rec_ptatype,
          lo_create_context     TYPE REF TO /iwbep/if_mgw_req_entity_c,
          lv_entity_type        TYPE string,
          lx_exception          TYPE REF TO /iwbep/cx_mgw_busi_exception,
          lv_exception          TYPE REF TO /iwbep/cx_mgw_tech_exception ##NEEDED.

    CONSTANTS: lc_entity_type TYPE string VALUE 'xEY1xSAV_C_Rec_PTAType'.

    lt_changeset_request[] = it_changeset_request.
    SORT lt_changeset_request ASCENDING BY operation_type.

*    TRY.
        LOOP AT lt_changeset_request INTO ls_changeset_request.
          "Downcasting from one more general source to specific target
          lo_create_context ?= ls_changeset_request-request_context.
          "Get entity type name
          lv_entity_type = lo_create_context->get_entity_type_name( ).
          MOVE-CORRESPONDING ls_changeset_request TO ls_changeset.
          IF lv_entity_type = lc_entity_type.
            APPEND ls_changeset_request TO lt_group_request.
          ENDIF.
          AT END OF operation_type.

            CASE ls_changeset_request-operation_type.
              WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-create_entity.
                handle_changeset_create_entity( EXPORTING it_changeset_request = lt_group_request
                                                CHANGING ct_changeset_response = ct_changeset_response ).
              WHEN OTHERS.
                "Extract information from the request
                ls_changeset-entry_provider->read_entry_data( IMPORTING es_data = ls_data ).

                copy_data_to_ref( EXPORTING is_data = ls_data
                                  CHANGING  cr_data = ls_changeset_response-entity_data ).
                ls_changeset_response-operation_no = ls_changeset-operation_no.
                INSERT ls_changeset_response INTO TABLE ct_changeset_response.
                CLEAR: ls_changeset_response.

                ls_changeset-msg_container->add_message( iv_msg_type               = 'E'
                                                         iv_msg_id                 = /ey1/sav_if_constants=>c_msg_id_savotta
                                                         iv_msg_number             = '014'
                                                         iv_msg_v1                 = /ey1/sav_if_constants=>C_MSG_RECON_PTA
                                                         iv_is_leading_message     = abap_false
                                                         iv_add_to_response_header = abap_true ).

                RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                  EXPORTING
                    message_container = ls_changeset-msg_container.
            ENDCASE.
            CLEAR: ls_changeset_request, ls_changeset, lt_group_request.
          ENDAT.
        ENDLOOP.

*      CATCH /iwbep/cx_mgw_busi_exception INTO lx_exception.
*        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*              EXPORTING
*                previous = lx_exception
*                textid   = /iwbep/cx_mgw_busi_exception=>business_error
*                message  = |{ lx_exception->get_text( ) }|.
*    ENDTRY.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_stream.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IS_MEDIA_RESOURCE       =
**    it_key_tab              =
**    it_navigation_path      =
*    IV_SLUG                 =
**    io_tech_request_context =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

*    DATA: lo_facade TYPE REF TO /iwbep/if_mgw_dp_int_facade.
*
*    lo_facade ?= /iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ).
*    DATA(lt_client_headers)   = lo_facade->get_request_header( ).
*
*    READ TABLE lt_client_headers INTO DATA(ls_client_header) WITH KEY name = '-request_uri'.
*    IF sy-subrc IS INITIAL.
*      SPLIT ls_client_header-value AT '?' INTO lv_slug lv_content_type IN CHARACTER MODE.
*
*    ENDIF.








  ENDMETHOD.


METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

********************************************************************************
*    Type Declaration
********************************************************************************
    TYPES: BEGIN OF ty_amount,
             amount TYPE wertv12,
           END OF ty_amount,
           tt_amount TYPE STANDARD TABLE OF ty_amount,

           BEGIN OF ty_out_amount,
             from_amount   TYPE wertv12,
             from_currency TYPE waers,
             to_amount     TYPE wertv12,
             to_currency   TYPE waers,
           END OF ty_out_amount,

           tt_out_amount TYPE STANDARD TABLE OF ty_out_amount,

           BEGIN OF ts_message,
              type         TYPE c LENGTH 1,
              id           TYPE c LENGTH 20,
              number       TYPE c LENGTH 3,
              message      TYPE c LENGTH 220,
              log_no       TYPE c LENGTH 20,
              log_msg_no   TYPE c LENGTH 6,
              message_v1   TYPE c LENGTH 50,
              message_v2   TYPE c LENGTH 50,
              message_v3   TYPE c LENGTH 50,
              message_v4   TYPE c LENGTH 50,
              parameter    TYPE c LENGTH 32,
              row          TYPE i,
              field        TYPE c LENGTH 30,
              system       TYPE c LENGTH 10,
              guid         TYPE sysuuid_x,
              lognumber    TYPE sysuuid_x,
              url          TYPE string,
           END OF ts_message,

           tt_message TYPE STANDARD TABLE OF ts_message .

********************************************************************************
*    Data Declaration
********************************************************************************
    DATA: lo_global_param         TYPE REF TO /ey1/cl_sav_recon_gaap_mpc=>ts_globalparameter05,
          lo_conv_amount          TYPE REF TO /ey1/cl_sav_recon_gaap_mpc=>ts_convertcurrency03,
          lo_period               TYPE REF TO /ey1/cl_sav_recon_gaap_mpc=>ts_determineperiod04,
          lo_context              TYPE REF TO	/iwbep/if_mgw_context,
          lo_notfound_excep       TYPE REF TO cx_sy_itab_line_not_found,
          lo_glbparam_utility     TYPE REF TO /ey1/sav_cl_global_params,
          lo_data_monitor         TYPE REF TO /ey1/cl_sav_recon_gaap_mpc=>ts_datamonitorparameters01,
          lo_data_mon_util        TYPE REF TO /ey1/cl_data_monitor_util,
          lo_posting_date         TYPE REF TO /ey1/cl_sav_recon_gaap_mpc=>ts_postingdate02,

          lto_data_mon            LIKE TABLE OF lo_data_monitor,

          lt_amount               TYPE tt_amount,
          lt_conv_amount          TYPE tt_out_amount,
          lt_ret_log              TYPE tt_message,
          lt_message              TYPE bapiret2_t,
          lt_log                  TYPE /ey1/tt_cur_trans_log,

          ls_entity               TYPE bapiret2,
          ls_amount               TYPE ty_amount,
          ls_user_global_params   TYPE /ey1/sav_str_glbl_params,
          ls_ret_log              TYPE ts_message,
          ls_parameter            TYPE /iwbep/s_mgw_name_value_pair,

          lv_from_currency        TYPE waers,
          lv_to_currency          TYPE waers,
          lv_exchrate_date        TYPE sydatum,
          lv_consolidation_unit   TYPE fc_bunit,
          lv_date                 TYPE dats,
          lv_period               TYPE monat,
          lv_poper                TYPE poper,
          lv_dimen                TYPE fc_dimen,
          lv_consolidation_ledger TYPE rldnr,
          lv_action               TYPE fc_cacti,
          lv_cons_unit            TYPE fc_bunit,
          lv_ryear                TYPE fc_ryear,
          lv_lcl_cur              TYPE fc_curr,
          lv_grp_cur              TYPE gcurr,
          lv_per_frm              TYPE poper,
          lv_per_to               TYPE poper,
          lv_log                  TYPE fincs_lognumber,
          lv_rldnr                TYPE rldnr,
          lv_url                  TYPE c LENGTH 1024.

    CREATE DATA lo_global_param.

    CASE iv_action_name.
********************************************************************************
*    GlobalParameter
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
*    ConvertCurrency
********************************************************************************
      WHEN 'ConvertCurrency'.

        CREATE DATA lo_conv_amount.

*       Getting parameters
        TRY.
            ls_amount-amount  = it_parameter[ name = 'Amount' ]-value      ##NO_TEXT.
            APPEND ls_amount TO lt_amount.
            lv_from_currency  = it_parameter[ name = 'FromCurrency' ]-value.
            lv_to_currency    = it_parameter[ name = 'ToCurrency' ]-value.
            lv_exchrate_date  = it_parameter[ name = 'ExchangeRateDate' ]-value.

*      Exception handling
          CATCH cx_sy_itab_line_not_found INTO lo_notfound_excep.

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                previous = lo_notfound_excep
                textid   = /iwbep/cx_mgw_busi_exception=>business_error
                message  = |{ lo_notfound_excep->get_text( ) }|.

        ENDTRY.

*      Currency Conversion using AMDP
        /ey1/cl_sav_grp_rep_util=>convert_currency(
         EXPORTING iv_client             = sy-mandt
                   it_amount             = lt_amount
                   iv_from_currency      = lv_from_currency
                   iv_to_currency        = lv_to_currency
                   iv_exchange_rate_date = lv_exchrate_date
         IMPORTING et_conv_amount        = lt_conv_amount ).

*       Getting the amounts
        IF lt_conv_amount IS NOT INITIAL.
          lo_conv_amount->fromamount     = lt_conv_amount[ 1 ]-from_amount.
          lo_conv_amount->fromcurrency   = lt_conv_amount[ 1 ]-from_currency.
          CONVERT DATE lv_exchrate_date INTO TIME STAMP DATA(lv_time_stamp) TIME ZONE sy-zonlo.
          lo_conv_amount->exchangeratedate = lv_time_stamp.
          lo_conv_amount->toamount       = lt_conv_amount[ 1 ]-to_amount.
          lo_conv_amount->tocurrency     = lt_conv_amount[ 1 ]-to_currency.
          er_data = lo_conv_amount.
        ENDIF.

        CLEAR lv_exchrate_date.

********************************************************************************
*    DeterminePeriod
********************************************************************************
      WHEN 'DeterminePeriod'.

        CREATE DATA lo_period.

*       Getting parameters
        TRY.
            lv_consolidation_unit   = it_parameter[ name = 'ConsolidationUnit' ]-value                ##NO_TEXT.
            lv_consolidation_ledger = it_parameter[ name = 'ConsolidationLedger' ]-value.
            lv_date                 = it_parameter[ name = 'Date' ]-value                             ##NO_TEXT.

*         Exception handling
          CATCH cx_sy_itab_line_not_found INTO lo_notfound_excep.

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                previous = lo_notfound_excep
                textid   = /iwbep/cx_mgw_busi_exception=>business_error
                message  = |{ lo_notfound_excep->get_text( ) }|.

        ENDTRY.

*       Checking the input parameter
        IF lv_consolidation_unit IS INITIAL.

*         Enter Valid value for &1
          mo_context->get_message_container( )->add_message( iv_msg_type   = 'E'
                                                             iv_msg_id     = /ey1/sav_if_constants=>c_msg_id_savotta
                                                             iv_msg_number = '010'
                                                             iv_msg_v1     = 'Consolidation unit.' )                    ##NO_TEXT.
          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
            EXPORTING
              message_container = mo_context->get_message_container( ).
        ENDIF.

*       Period determination
        TRY.
            /ey1/cl_sav_grp_rep_util=>determine_period(
              EXPORTING iv_consolidation_ledger = lv_consolidation_ledger
                        iv_date                 = lv_date
                        iv_consolidation_unit   = lv_consolidation_unit
              IMPORTING ev_period               = lv_period ).

            lo_period->monat = lv_period.
            er_data = lo_period.

*         Exception handling
          CATCH /ey1/cx_sav_reconciliation INTO DATA(lr_excep).                       "Savotta Exception Class

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                previous = lr_excep
                textid   = /iwbep/cx_mgw_busi_exception=>business_error
                message  = |{ lr_excep->get_text( ) }|.

        ENDTRY.

        CLEAR lv_consolidation_unit.

********************************************************************************
*    DataMonitorParameters
********************************************************************************
      WHEN 'DataMonitorParameters'.

         lo_data_mon_util = /ey1/cl_data_monitor_util=>get_instance( ).

*       Reading function import parameters
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
            CLEAR: lv_rldnr, lv_ryear.

*******************************************************************************
*    Get Posting Date
*******************************************************************************
      WHEN 'PostingDate'.

        CREATE DATA lo_posting_date.

*       Getting parameters
        TRY.
            lv_consolidation_unit = it_parameter[ name = 'ConsolidationUnit' ]-value                ##NO_TEXT.
            lv_poper              = it_parameter[ name = 'Poper' ]-value.
            lv_ryear              = it_parameter[ name = 'FiscalYear' ]-value                       ##NO_TEXT.

*        Exception handling
         CATCH cx_sy_itab_line_not_found INTO lo_notfound_excep.

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                previous = lo_notfound_excep
                textid   = /iwbep/cx_mgw_busi_exception=>business_error
                message  = |{ lo_notfound_excep->get_text( ) }|.

        ENDTRY.

        "Fetch Tax Ledger based on Consolidation Unit
        SELECT SINGLE * FROM /ey1/reconledger INTO @DATA(ls_ledger)
          WHERE bunit = @lv_consolidation_unit.
            IF sy-subrc IS INITIAL.
              lv_rldnr = ls_ledger-tax.
            ENDIF.

        "Get Consolidation Dimension based on User-Id
        SELECT SINGLE dimen FROM tf004 INTO lv_dimen WHERE uname = sy-uname.
          IF sy-subrc IS INITIAL.

            "Select fiscal variant assigned to consolidation unit based on
            "Consolidation Dimension, Tax Ledger & Consolidation Unit
            SELECT SINGLE * FROM tf168 INTO @DATA(ls_tf168)
              WHERE dimen = @lv_dimen
                AND rldnr = @lv_rldnr
                AND bunit = @lv_consolidation_unit.

              IF sy-subrc IS INITIAL.
                "Get the exchange rate date for given fiscal year, fiscal period & fiscal variant
                CALL FUNCTION 'LAST_DAY_IN_PERIOD_GET'
                  EXPORTING
                    i_gjahr              = lv_ryear
                    i_monmit             = 00
                    i_periv              = ls_tf168-periv
                    i_poper              = lv_poper
                  IMPORTING
                    e_date               = lv_exchrate_date
                  EXCEPTIONS
                    input_false          = 1
                    t009_notfound        = 2
                    t009b_notfound       = 3
                    OTHERS               = 4.

                IF sy-subrc <> 0.
                  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
                ENDIF.

              ENDIF.

              lo_posting_date->postingdate = lv_exchrate_date.
              er_data = lo_posting_date.

          ENDIF.
          CLEAR: lv_consolidation_unit, lv_poper, lv_rldnr, lv_ryear.

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


METHOD convertcurrencys_get_entity.
********************************************************************************
*    Type Declaration
********************************************************************************
     TYPES: BEGIN OF ty_amount,
             amount TYPE wertv12,
           END OF ty_amount,
           tt_amount TYPE STANDARD TABLE OF ty_amount,

           BEGIN OF ty_out_amount,
             from_amount   TYPE wertv12,
             from_currency TYPE waers,
             to_amount     TYPE wertv12,
             to_currency   TYPE waers,
           END OF ty_out_amount,
           tt_out_amount TYPE STANDARD TABLE OF ty_out_amount.

********************************************************************************
*    Data Declaration
********************************************************************************
    DATA: lo_notfound_excep       TYPE REF TO cx_sy_itab_line_not_found,

          lt_key_tab            TYPE /iwbep/t_mgw_name_value_pair,
          lt_amount             TYPE tt_amount,
          lt_conv_amount        TYPE tt_out_amount,

          ls_amount             TYPE ty_amount,

          lv_from_currency      TYPE waers,
          lv_to_currency        TYPE waers,
          lv_exchangerate_date  TYPE sy-datum,
          lv_consolidation_unit TYPE fc_bunit.

********************************************************************************
*     Getting input parameters
********************************************************************************
      TRY.
        ls_amount-amount  = it_key_tab[ name = 'FromAmount' ]-value.
        APPEND ls_amount TO lt_amount.
        lv_from_currency  = it_key_tab[ name = 'FromCurrency' ]-value.
        lv_to_currency    = it_key_tab[ name = 'ToCurrency' ]-value.
        lv_exchangerate_date  = it_key_tab[ name = 'ExchangeRateDate' ]-value.

********************************************************************************
*     Exception handling
********************************************************************************
      CATCH cx_sy_itab_line_not_found INTO lo_notfound_excep.
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING previous = lo_notfound_excep
                    textid   = /iwbep/cx_mgw_busi_exception=>business_error
                    message  = |{ lo_notfound_excep->get_text( ) }|.

      ENDTRY.

********************************************************************************
*     Currency Conversion
********************************************************************************
       /ey1/cl_sav_grp_rep_util=>convert_currency(
         EXPORTING
           iv_client             = sy-mandt
           it_amount             = lt_amount
           iv_from_currency      = lv_from_currency
           iv_to_currency        = lv_to_currency
           iv_exchange_rate_date = lv_exchangerate_date
         IMPORTING
           et_conv_amount        = lt_conv_amount ).

********************************************************************************
*     Creating output Entity
********************************************************************************
      IF lt_conv_amount IS NOT INITIAL.
        er_entity-fromamount     = lt_conv_amount[ 1 ]-from_amount.
        er_entity-fromcurrency   = lt_conv_amount[ 1 ]-from_currency.
        CONVERT DATE lv_exchangerate_date INTO TIME STAMP DATA(lv_time_stamp) TIME ZONE sy-zonlo.
        er_entity-exchangeratedate =  lv_time_stamp.
        er_entity-toamount         = lt_conv_amount[ 1 ]-to_amount.
        er_entity-tocurrency       = lt_conv_amount[ 1 ]-to_currency.
     ENDIF.

  ENDMETHOD.


METHOD handle_changeset_create_entity.
********************************************************************************
*    Data Declaration
********************************************************************************
  DATA: lt_recon_pta          TYPE STANDARD TABLE OF /ey1/recon_pta,

        ls_request_input_data TYPE /ey1/cl_sav_recon_gaap_mpc=>ts_xey1xsav_c_rec_ptatype,
        ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
        ls_changeset          TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
        ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
        ls_recon_pta          TYPE /ey1/recon_pta,

        lv_exception          TYPE REF TO /iwbep/cx_mgw_tech_exception,
        lv_docnr              TYPE nrlevel,
        lv_ryear              TYPE nryear,
        lv_msgv1              TYPE symsgv,
        lv_msgv2              TYPE symsgv.

********************************************************************************
*    Generate document number
********************************************************************************
  TRY.
    READ TABLE it_changeset_request ASSIGNING FIELD-SYMBOL(<fs_changeset>) INDEX 1.
    IF <fs_changeset> IS ASSIGNED.

      "Extract information from the request
       <fs_changeset>-entry_provider->read_entry_data(
         IMPORTING es_data = ls_request_input_data ).

       lv_ryear = ls_request_input_data-fiscalyear.
       CLEAR ls_request_input_data.

       SELECT SINGLE * INTO @DATA(ls_nriv)
        FROM nriv WHERE object    = @/ey1/sav_if_constants=>c_object_corptax  AND
                        subobject = @/ey1/sav_if_constants=>c_subobject_y1 AND
                        nrrangenr = @/ey1/sav_if_constants=>c_nrrangenr_pt  AND
                        toyear    = @lv_ryear.

       IF sy-subrc IS INITIAL.
         IF ls_nriv-nrlevel IS NOT INITIAL.
           lv_docnr = ls_nriv-nrlevel + 0000000001.
         ELSE.
           lv_docnr = ls_nriv-fromnumber.
         ENDIF.
       ENDIF.
    ENDIF.


      LOOP AT it_changeset_request INTO ls_changeset_request.

        "Extract information from the request
        ls_changeset_request-entry_provider->read_entry_data(
         IMPORTING es_data = ls_request_input_data ).

        "ConversionExit for Document Number
        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
          EXPORTING
            input  = lv_docnr
          IMPORTING
            output = ls_recon_pta-docnr.

        "Fill internal Table of type '/EY1/RECON_PTA'
        ls_recon_pta-rbunit       = ls_request_input_data-consolidationunit.
        ls_recon_pta-ryear        = ls_request_input_data-fiscalyear.
        ls_recon_pta-buzei        = ls_request_input_data-lineitem.
        ls_recon_pta-budat        = ls_request_input_data-postingdate.
        ls_recon_pta-poper        = ls_request_input_data-fiscalperiod.
        IF ls_request_input_data-taxintention IS NOT INITIAL.
          ls_recon_pta-taxintention = ls_request_input_data-taxintention.
        ENDIF.
        ls_recon_pta-racct        = ls_request_input_data-glaccount.
        ls_recon_pta-fc_item      = ls_request_input_data-financialstatementitem.
        ls_recon_pta-hsl          = ls_request_input_data-amountinlocalcurrency.
        ls_recon_pta-rhcur        = ls_request_input_data-localcurrency.
        ls_recon_pta-ksl          = ls_request_input_data-amountingroupcurrency.
        ls_recon_pta-rkcur        = ls_request_input_data-groupcurrency.
        ls_recon_pta-spras        = sy-langu.
        ls_recon_pta-sgtxt        = ls_request_input_data-text.
        ls_recon_pta-erdat        = sy-datum.
        ls_recon_pta-erzeit       = sy-uzeit.
        ls_recon_pta-ernam        = sy-uname.
        APPEND ls_recon_pta TO lt_recon_pta.

*       blocking the table entries
        CALL FUNCTION 'ENQUEUE_/EY1/RECON_PTA'
         EXPORTING
           mode_/ey1/recon_pta       = 'E'
           mandt                     = sy-mandt
           rbunit                    = ls_recon_pta-rbunit
           ryear                     = ls_recon_pta-ryear
           docnr                     = ls_recon_pta-docnr
           buzei                     = ls_recon_pta-buzei
         EXCEPTIONS
           foreign_lock              = 1
           system_failure            = 2
           OTHERS                    = 3.

*       Handling exception in table already blocked
        IF sy-subrc <> 0.
          mo_context->get_message_container( )->add_message( iv_msg_type                = sy-msgty
                                                             iv_msg_id                  = sy-msgid
                                                             iv_msg_number              = sy-msgno
                                                             iv_msg_v1                  = sy-msgv1
                                                             iv_msg_v2                  = sy-msgv2
                                                             iv_msg_v3                  = sy-msgv3
                                                             iv_msg_v4                  = sy-msgv4
                                                             iv_is_leading_message      = abap_false
                                                             iv_add_to_response_header  = abap_true ).
          RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
            EXPORTING
              message_container = mo_context->get_message_container( ).

        ENDIF.

        ls_request_input_data-documentnumber = ls_recon_pta-docnr.
        lv_msgv1 = ls_recon_pta-docnr.
        lv_msgv2 = ls_recon_pta-rbunit.
        CLEAR: ls_recon_pta.

        copy_data_to_ref( EXPORTING is_data = ls_request_input_data
                          CHANGING  cr_data = ls_changeset_response-entity_data ).

********************************************************************************
*    Creating response
********************************************************************************
        ls_changeset_response-operation_no = ls_changeset_request-operation_no.
        INSERT ls_changeset_response INTO TABLE ct_changeset_response.
        MOVE-CORRESPONDING ls_changeset_request TO ls_changeset.
        CLEAR: ls_changeset_response, ls_changeset_request.

********************************************************************************
*    Inserting the changes from BATCH to the DB
********************************************************************************
        AT LAST.
*       DB insertion
          INSERT /ey1/recon_pta FROM TABLE lt_recon_pta.

          IF sy-subrc IS INITIAL.
            CLEAR lv_docnr.

            CALL FUNCTION 'NUMBER_GET_NEXT'
              EXPORTING
                nr_range_nr             = /ey1/sav_if_constants=>c_nrrangenr_pt
                object                  = /ey1/sav_if_constants=>c_object_corptax
                subobject               = /ey1/sav_if_constants=>c_subobject_y1
                toyear                  = lv_ryear
              IMPORTING
                number                  = lv_docnr
              EXCEPTIONS ##FM_SUBRC_OK
                interval_not_found      = 1
                number_range_not_intern = 2
                object_not_found        = 3
                quantity_is_0           = 4
                quantity_is_not_1       = 5
                interval_overflow       = 6
                buffer_overflow         = 7
                OTHERS                  = 8.

*         Handling exception
            IF sy-subrc <> 0.
*           Unblocking the table
              CALL FUNCTION 'DEQUEUE_/EY1/RECON_PTA'
               EXPORTING
                 mode_/ey1/recon_pta       = 'E'
                 mandt                     = sy-mandt.
*           Error message
              mo_context->get_message_container( )->add_message( iv_msg_type                = sy-msgty
                                                                 iv_msg_id                  = sy-msgid
                                                                 iv_msg_number              = sy-msgno
                                                                 iv_msg_v1                  = sy-msgv1
                                                                 iv_msg_v2                  = sy-msgv2
                                                                 iv_msg_v3                  = sy-msgv3
                                                                 iv_msg_v4                  = sy-msgv4
                                                                 iv_is_leading_message      = abap_false
                                                                 iv_add_to_response_header  = abap_true ).

              RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                EXPORTING
                  message_container = mo_context->get_message_container( ).
            ENDIF.

*         Unblocking the table
            CALL FUNCTION 'DEQUEUE_/EY1/RECON_PTA'
               EXPORTING
                 mode_/ey1/recon_pta       = 'E'
                 mandt                     = sy-mandt.

*         Success message
            mo_context->get_message_container( )->add_message( iv_msg_type                = 'S'
                                                               iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                               iv_msg_number              = '015'
                                                               iv_msg_v1                  = lv_msgv1
                                                               iv_msg_v2                  = lv_msgv2
                                                               iv_is_leading_message      = abap_false
                                                               iv_add_to_response_header  = abap_true ).
          ELSE.

            CALL FUNCTION 'DEQUEUE_/EY1/RECON_PTA'
               EXPORTING
                 mode_/ey1/recon_pta       = 'E'
                 mandt                     = sy-mandt.

            mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                               iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                               iv_msg_number              = '001'
                                                               iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_recon_pta
                                                               iv_is_leading_message      = abap_false
                                                               iv_add_to_response_header  = abap_true ).

            RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
              EXPORTING
                message_container = mo_context->get_message_container( ).

          ENDIF.

          CLEAR lt_recon_pta.
        ENDAT.

        CLEAR: ls_changeset,ls_request_input_data, ls_recon_pta.
      ENDLOOP.

      CLEAR: lv_docnr, lv_ryear.

    CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db).
      mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '001'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_recon_pta
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_true ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = mo_context->get_message_container( ).
  ENDTRY.

ENDMETHOD.


METHOD handle_changeset_update_g2s.
********************************************************************************
*    Data Declaration
********************************************************************************
    DATA: lv_operation_no TYPE i                 ##NEEDED.

    DATA: ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          lo_patch_context      TYPE REF TO /iwbep/if_mgw_req_entity_p,
          lv_entity_type        TYPE string      ##NEEDED,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response.

    DATA: ls_request_input_data TYPE z_c_recon_gaap_stat.

    DATA: lt_keys TYPE /iwbep/t_mgw_tech_pairs   ##NEEDED.

    DATA: ls_g2s TYPE zgaap_to_stat.
    DATA: lt_g2s TYPE STANDARD TABLE OF zgaap_to_stat.

    LOOP AT it_changeset_request INTO ls_changeset_request.
      lv_operation_no = ls_changeset_request-operation_no.
      ls_changeset_response-operation_no = ls_changeset_request-operation_no.

      INSERT ls_changeset_response INTO TABLE ct_changeset_response.

      lo_patch_context ?= ls_changeset_request-request_context.
      lv_entity_type = lo_patch_context->get_entity_type_name( ).

      TRY .
          ls_changeset_request-entry_provider->read_entry_data(
            IMPORTING
              es_data = ls_request_input_data ).
        CATCH /iwbep/cx_mgw_tech_exception            ##NO_HANDLER.

      ENDTRY.

      lt_keys = lo_patch_context->get_keys( ).

* see if it is a new G2S entry or not
      ls_g2s-g2s_other_permanent = ls_request_input_data-G2s_Other_Permanent.
      ls_g2s-g2s_eq = ls_request_input_data-G2sEq.
      ls_g2s-g2s_other_eq = ls_request_input_data-G2sOtherEq.
      ls_g2s-g2s_other_pl = ls_request_input_data-G2sOtherPl.
      ls_g2s-g2s_permanent = ls_request_input_data-G2sPermanent.
      ls_g2s-g2s_pl = ls_request_input_data-G2sPl.

      IF ls_g2s IS NOT INITIAL.
        ls_g2s-racct = ls_request_input_data-racct.
        ls_g2s-rbunit = ls_request_input_data-rbunit.
        ls_g2s-ryear = ls_request_input_data-ryear.
        ls_g2s-rhcur =  ls_request_input_data-Currency.
        APPEND ls_g2s TO lt_g2s.
      ENDIF.

      CLEAR ls_g2s.
    ENDLOOP.

    MODIFY zgaap_to_stat FROM TABLE lt_g2s.
    IF sy-subrc IS NOT INITIAL.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception.
    ENDIF.

  ENDMETHOD.


  METHOD ledgerset_get_entityset.
**TRY.
*CALL METHOD SUPER->LEDGERSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    DATA: ls_filter        TYPE /iwbep/s_mgw_select_option,
          lv_bunit         TYPE fc_bunit,
          ls_opt           TYPE /iwbep/s_cod_select_option,
          lv_operator      TYPE string,
          lt_select_option TYPE /iwbep/t_mgw_select_option,
          lv_filter_string TYPE string.

    FIELD-SYMBOLS: <fs_key> TYPE data.


    READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'BUnit'.
    IF sy-subrc = 0.
      READ TABLE ls_filter-select_options INTO ls_opt INDEX 1.
      IF sy-subrc = 0.
        lv_bunit   = ls_opt-low.
      ENDIF.
    ENDIF.

    SELECT *
        FROM /EY1/DM_ALL_LED( p_bunit = @lv_bunit )
      INTO CORRESPONDING FIELDS OF TABLE @et_entityset.



  ENDMETHOD.
ENDCLASS.

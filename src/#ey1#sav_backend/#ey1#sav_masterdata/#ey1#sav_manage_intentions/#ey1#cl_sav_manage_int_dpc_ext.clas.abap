class /EY1/CL_SAV_MANAGE_INT_DPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_MANAGE_INT_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
protected section.

  methods AUTHSET_GET_ENTITYSET
    redefinition .
  methods INTENTIONSSET_CREATE_ENTITY
    redefinition .
  methods INTENTIONSSET_GET_ENTITYSET
    redefinition .
  methods INTENTIONSSET_UPDATE_ENTITY
    redefinition .
  methods INTENTIONVALUESS_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_MANAGE_INT_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
*  EXPORTING
*    IT_OPERATION_INFO =
**  CHANGING
**    cv_defer_mode     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    cv_defer_mode = abap_true.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
    COMMIT WORK.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
*  EXPORTING
*    IT_CHANGESET_REQUEST  =
*  CHANGING
*    CT_CHANGESET_RESPONSE =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

     DATA: lo_data_provider  TYPE REF TO /iwbep/if_mgw_entry_provider,
          lo_create_context TYPE REF TO /iwbep/if_mgw_req_entity_c,
          ls_data           TYPE /ey1/cl_sav_manage_int_mpc=>ts_intentions,
          ls_intention      TYPE /ey1/fiscl_intnt,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          lv_changedon          TYPE /ey1/fiscl_intnt-changed_on,
          lv_createdon         TYPE /ey1/fiscl_intnt-created_on,
          lv_timestamp          TYPE timestamp,
          ls_message           TYPE scx_t100key,
          lv_msg_v1             TYPE symsgv,
          lv_msg_v2             TYPE symsgv.


      LOOP AT it_changeset_request INTO ls_changeset_request.

         ls_changeset_request-entry_provider->read_entry_data( IMPORTING es_data = ls_data ).

         IF ls_changeset_request-operation_type = 'UE'
            OR ls_changeset_request-operation_type = 'PE'."Update
           "ls_changeset_request-request_context
           ls_data-changed_by = sy-uname.
           GET TIME STAMP FIELD lv_timestamp.
           lv_changedon = lv_timestamp.
           ls_data-changed_on = lv_changedon.

           IF ls_data-period_to IS NOT INITIAL.
                UPDATE /ey1/fiscl_intnt SET  intention = ls_data-intention
                                           period_to  = ls_data-period_to
                                           seqnr_flb  = ls_Data-seqnr_flb
                                           intnsn_act_flg = ls_data-intnsn_act_flg
                                           changed_on = ls_data-changed_on
                                           changed_by = ls_data-changed_by
                                     WHERE gjahr  = ls_data-gjahr
                                     AND   bunit  = ls_data-bunit.
           ELSE.
               UPDATE /ey1/fiscl_intnt SET  intention = ls_data-intention
                                            seqnr_flb  = ls_Data-seqnr_flb
                                            intnsn_act_flg = ls_data-intnsn_act_flg
                                            changed_on = ls_data-changed_on
                                            changed_by = ls_data-changed_by
                                    WHERE gjahr  = ls_data-gjahr
                                    AND   bunit  = ls_data-bunit.
           ENDIF.
           IF sy-subrc = 0.
             SELECT SINGLE guid created_by created_on intnsn_act_flg
               FROM /ey1/fiscl_intnt
               INTO ( ls_data-guid,ls_data-created_by,ls_data-created_on,ls_data-is_active )
               WHERE gjahr = ls_data-gjahr
               AND   bunit = ls_data-bunit.

             ls_data-is_active = ls_data-intnsn_act_flg.
             copy_data_to_ref( EXPORTING is_data = ls_data
                                   CHANGING  cr_data = ls_changeset_response-entity_data ).

             ls_changeset_response-operation_no = ls_changeset_request-operation_no.
             APPEND ls_changeset_response TO ct_changeset_response.
             CLEAR: ls_changeset_response.
           ENDIF.
           CLEAR: lv_msg_v1, lv_msg_v2.
           lv_msg_v1 = ls_data-intention.
           lv_msg_v2 = ls_data-gjahr.
           mo_context->get_message_container( )->add_message( iv_msg_type                = 'S'
                                                              iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                              iv_msg_number              = '035'
                                                              iv_msg_v1                  = lv_msg_v1
                                                              iv_msg_v2                  = lv_msg_v2
                                                              iv_is_leading_message      = abap_false
                                                              iv_add_to_response_header  = abap_true ).

         ELSEIF ls_changeset_request-operation_type = 'CE'."Create
           ls_data-guid = cl_system_uuid=>create_uuid_x16_static( ).
           ls_data-created_by = sy-uname.
           GET TIME STAMP FIELD lv_timestamp.
           lv_createdon = lv_timestamp.
           ls_data-created_on = lv_createdon.

           SELECT SINGLE * FROM /ey1/fiscl_intnt
              WHERE gjahr = @ls_data-gjahr
              AND bunit   = @ls_data-bunit
              INTO @DATA(ls_intsn_data).
           IF sy-subrc = 0.
             CLEAR: lv_msg_v1.
             lv_msg_v1 = ls_data-gjahr.
             mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                   iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                   iv_msg_number              = '036'
                                                   iv_msg_v1                  = lv_msg_v1
                                                   iv_is_leading_message      = abap_false
                                                   iv_add_to_response_header  = abap_true ).
             RETURN.
           ENDIF.
           MOVE-CORRESPONDING ls_data TO ls_intention.
           MODIFY /ey1/fiscl_intnt FROM ls_intention.
           ls_intention-changed_on = lv_timestamp.
           MOVE-CORRESPONDING ls_intention TO ls_data.
           ls_data-is_active = ls_intention-intnsn_act_flg.
           IF sy-subrc = 0.
             copy_data_to_ref( EXPORTING is_data = ls_data
                                   CHANGING  cr_data = ls_changeset_response-entity_data ).

             ls_changeset_response-operation_no = ls_changeset_request-operation_no.
             APPEND ls_changeset_response TO ct_changeset_response.
             CLEAR: ls_changeset_response.
             lv_msg_v1 = ls_data-gjahr.
             mo_context->get_message_container( )->add_message( iv_msg_type                = 'S'
                                                              iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                              iv_msg_number              = '037'
                                                              iv_msg_v1                  = lv_msg_v1
                                                              iv_is_leading_message      = abap_false
                                                              iv_add_to_response_header  = abap_true ).
           ENDIF.

         ENDIF.
      ENDLOOP.

  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
**  EXPORTING
**    iv_action_name          =
**    it_parameter            =
**    io_tech_request_context =
**  IMPORTING
**    er_data                 =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

    TYPES:
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
           tt_message TYPE STANDARD TABLE OF ts_message.


    DATA: lo_data_mon_util        TYPE REF TO /ey1/cl_data_monitor_util,
          ls_parameter            TYPE /iwbep/s_mgw_name_value_pair,
          lv_cons_unit            TYPE fc_bunit,
          lv_ryear                TYPE fc_ryear,
          lt_ret_log              TYPE tt_message.

    CASE iv_action_name.
       WHEN 'BalanceTransferDataMonitor'.

         lo_data_mon_util = /ey1/cl_data_monitor_util=>get_instance( ).


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

*        Call Execute All Actions for Balance Transfer Here

         copy_data_to_ref(
                            EXPORTING
                              is_data = lt_ret_log
                            CHANGING
                              cr_data = er_data
                            ).


       WHEN OTHERS.
        CALL METHOD super->/iwbep/if_mgw_appl_srv_runtime~execute_action
          EXPORTING
            iv_action_name          = iv_action_name
            it_parameter            = it_parameter
            io_tech_request_context = io_tech_request_context
          IMPORTING
            er_data                 = er_data.

    ENDCASE.
  endmethod.


  METHOD authset_get_entityset.
**TRY.
*CALL METHOD SUPER->AUTHSET_GET_ENTITYSET
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
  DATA ls_return LIKE LINE OF et_entityset.

  AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '01'.

  IF sy-subrc <> 0.
   ls_return-createallowed = abap_false.
  ELSE.
    ls_return-createallowed = abap_true.
  ENDIF.

  AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '02'.
  IF sy-subrc <> 0.
   ls_return-changeallowed = abap_false.
  ELSE.
    ls_return-changeallowed = abap_true.
  ENDIF.

  APPEND ls_return TO et_entityset.



  ENDMETHOD.


  method INTENTIONSSET_CREATE_ENTITY.
**TRY.
*CALL METHOD SUPER->INTENTIONSSET_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

  DATA: ls_headerdata        TYPE /ey1/fiscl_intnt,
        ls_message           TYPE scx_t100key,
        lv_createdon         TYPE /ey1/fiscl_intnt-created_on,
        lv_timestamp         TYPE timestamp.


  field-symbols: <ls_key>    type /iwbep/s_mgw_tech_pair.

  io_data_provider->read_entry_data( importing es_data = ls_headerdata ).

  ls_headerdata-guid = cl_system_uuid=>create_uuid_x16_static( ).

  IF ls_headerdata-created_by IS INITIAL.
    ls_headerdata-created_by = sy-uname.
  ENDIF.
  IF ls_headerdata-created_on IS INITIAL.
    GET TIME STAMP FIELD lv_timestamp.
    lv_createdon = lv_timestamp.
    ls_headerdata-created_on = lv_createdon.
  ENDIF.

  SELECT SINGLE * FROM /ey1/fiscl_intnt
    WHERE gjahr = @ls_headerdata-gjahr
    AND   bunit = @ls_headerdata-bunit
    INTO @DATA(ls_data).
  IF sy-subrc = 0.
    ls_message-msgid = '/EY1/'.
    ls_message-msgno = '002'.
    ls_message-attr1 = 'Fiscal Year Already Maintained'. "#EC NO_TEXT

    raise exception type /iwbep/cx_mgw_busi_exception
      exporting
        textid = ls_message.
  ENDIF.

  MODIFY /ey1/fiscl_intnt FROM ls_headerdata.
  COMMIT WORK AND WAIT.

  IF sy-subrc <> 0.
    ls_message-msgid = '/EY1/'.
    ls_message-msgno = '001'.
    ls_message-attr1 = 'Error in Saving Data'. "#EC NO_TEXT

    raise exception type /iwbep/cx_mgw_busi_exception
      exporting
        textid = ls_message.
  ELSE.
    ls_headerdata-changed_by = sy-uname.
    ls_headerdata-changed_on = lv_createdon.
    MOVE-CORRESPONDING ls_headerdata TO er_entity.
  ENDIF.

  endmethod.


  method INTENTIONSSET_GET_ENTITYSET.
*TRY.
*CALL METHOD SUPER->INTENTIONSSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           = IV_ENTITY_NAME
*    IV_ENTITY_SET_NAME       = IV_ENTITY_SET_NAME
*    IV_SOURCE_NAME           = IV_SOURCE_NAME
*    IT_FILTER_SELECT_OPTIONS = IT_FILTER_SELECT_OPTIONS
*    IS_PAGING                = IS_PAGING
*    IT_KEY_TAB               = IT_KEY_TAB
*    IT_NAVIGATION_PATH       = IT_NAVIGATION_PATH
*    IT_ORDER                 = IT_ORDER
*    IV_FILTER_STRING         = IV_FILTER_STRING
*    IV_SEARCH_STRING         = IV_SEARCH_STRING
*    io_tech_request_context  = io_tech_request_context
*  IMPORTING
*    et_entityset             = et_entityset
*    es_response_context      = es_response_context
*    .
*  CATCH /iwbep/cx_mgw_busi_exception.
*  CATCH /iwbep/cx_mgw_tech_exception.
*ENDTRY.

    TYPES: BEGIN OF tr_gjahr,
            sign    TYPE c LENGTH 1,
            option  TYPE c LENGTH 2,
            low     TYPE gjahr,
            high    TYPE gjahr,
           END OF tr_gjahr.

    TYPES: BEGIN OF tr_bunit,
            sign    TYPE c LENGTH 1,
            option  TYPE c LENGTH 2,
            low     TYPE fc_bunit,
            high    TYPE fc_bunit,
           END OF tr_bunit.


    DATA:
          ls_filter        TYPE /iwbep/s_mgw_select_option,
          lv_gjahr         TYPE gjahr,
          lv_bunit         TYPE fc_bunit,
          ls_opt           TYPE /iwbep/s_cod_select_option,
          lt_select_option TYPE /iwbep/t_mgw_select_option,
          lr_gjahr         TYPE tr_gjahr,
          lr_bunit         TYPE tr_bunit,
          ltr_gjahr        TYPE TABLE OF tr_gjahr,
          ltr_bunit        TYPE TABLE OF tr_bunit.


    LOOP AT it_filter_select_options INTO ls_filter.
      IF ls_filter-property = 'Gjahr'.
        LOOP AT ls_filter-select_options INTO ls_opt.
          lv_gjahr         = ls_opt-low.
          lr_gjahr-sign    = 'I'.
          lr_gjahr-option  = 'EQ'.
          lr_gjahr-low     = lv_gjahr.
          APPEND lr_gjahr TO ltr_gjahr.
        ENDLOOP.
      ENDIF.
    ENDLOOP.

    LOOP AT it_filter_select_options INTO ls_filter.
      IF ls_filter-property = 'Bunit'.
        LOOP AT ls_filter-select_options INTO ls_opt.
          lv_bunit         = ls_opt-low.
          lr_bunit-sign    = 'I'.
          lr_bunit-option  = 'EQ'.
          lr_bunit-low     = lv_bunit.
          APPEND lr_bunit TO ltr_bunit.
        ENDLOOP.
      ENDIF.
    ENDLOOP.




    SELECT a~bunit,
           a~gjahr,
           a~intention,
           b~description AS intdesc,
           a~seqnr_flb,
           a~period_to,
           a~intnsn_act_flg,
           a~created_by,
           a~created_on,
           a~changed_by,
           a~changed_on,
           a~intnsn_act_flg AS Is_Active,
           CASE a~intention
           	WHEN 'TXU' THEN  'X'
            ELSE ' '
           END AS closebtnact
          FROM /ey1/fiscl_intnt AS a
          LEFT JOIN
          /EY1/INTENTION AS b
          ON a~intention = b~intent
          INTO CORRESPONDING FIELDS OF TABLE @et_entityset
          WHERE gjahr IN @ltr_gjahr
          AND   bunit IN @ltr_bunit
          ORDER BY bunit,gjahr ASCENDING.

  endmethod.


  method INTENTIONSSET_UPDATE_ENTITY.
**TRY.
*CALL METHOD SUPER->INTENTIONSSET_UPDATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**    io_data_provider        =
**  IMPORTING
**    er_entity               =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

  DATA:  ls_request_input_data TYPE /ey1/fiscl_intnt,
         ls_key_tab            TYPE /iwbep/s_mgw_name_value_pair,
         lv_gjahr              TYPE gjahr,
         lv_bunit              TYPE fc_bunit,
         ls_message            TYPE scx_t100key,
         lv_changedon          TYPE /ey1/fiscl_intnt-changed_on,
         lv_timestamp          TYPE timestamp.


  READ TABLE it_key_tab WITH KEY name = 'Gjahr' INTO ls_key_tab.
  IF sy-subrc = 0.
    lv_gjahr = ls_key_tab-value.
  ENDIF.

  READ TABLE it_key_tab WITH KEY name = 'BUNIT' INTO ls_key_tab.
  IF sy-subrc = 0.
    lv_bunit = ls_key_tab-value.
  ENDIF.

  IF lv_gjahr IS NOT INITIAL.
    io_data_provider->read_entry_data( IMPORTING es_data = ls_request_input_data ).
    IF ls_request_input_data-changed_by IS INITIAL.
      ls_request_input_data-changed_by = sy-uname.
    ENDIF.
    IF ls_request_input_data-changed_on IS INITIAL.
      GET TIME STAMP FIELD lv_timestamp.
      lv_changedon = lv_timestamp.
      ls_request_input_data-changed_on = lv_changedon.
    ENDIF.

    IF ls_request_input_data-intention = 'TXU'.
      ls_request_input_data-intnsn_act_flg = abap_true.
    ENDIF.

    IF ls_request_input_data-period_to IS NOT INITIAL.
      UPDATE /ey1/fiscl_intnt SET  intention = ls_request_input_data-intention
                                 seqnr_flb   = ls_request_input_data-seqnr_flb
                                 period_to  = ls_request_input_data-period_to
                                 intnsn_act_flg = ls_request_input_data-intnsn_act_flg
                                 changed_on = ls_request_input_data-changed_on
                                 changed_by = ls_request_input_data-changed_by
                           WHERE gjahr  = lv_gjahr
                           AND   bunit  = lv_bunit.
    ELSE.
      UPDATE /ey1/fiscl_intnt SET  intention = ls_request_input_data-intention
                                   seqnr_flb   = ls_request_input_data-seqnr_flb
                                   intnsn_act_flg = ls_request_input_data-intnsn_act_flg
                                   changed_on = ls_request_input_data-changed_on
                                   changed_by = ls_request_input_data-changed_by
                           WHERE gjahr  = lv_gjahr
                           AND   bunit  = lv_bunit.
    ENDIF.
    COMMIT WORK AND WAIT.
    IF sy-subrc = 0.
      MOVE-CORRESPONDING ls_request_input_data TO er_entity.
    ELSE.
       ls_message-msgid = '/EY1/'.
       ls_message-msgno = '001'.
       ls_message-attr1 = 'Error in Saving Data'. "#EC NO_TEXT

       raise exception type /iwbep/cx_mgw_busi_exception
         exporting
           textid = ls_message.
    ENDIF.

  ENDIF.



  endmethod.


  method INTENTIONVALUESS_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->INTENTIONVALUESS_GET_ENTITYSET
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
          lv_gjahr         TYPE gjahr,
          lv_periodto      TYPE /ey1/fiscl_intnt-period_to,
          lv_intention     TYPE /ey1/sav_intent,
          ls_opt           TYPE /iwbep/s_cod_select_option,
          lv_operator      TYPE string,
          lt_select_option TYPE /iwbep/t_mgw_select_option,
          lv_filter_string TYPE string,
          ls_return        TYPE /ey1/cl_sav_manage_int_mpc_ext=>ts_intentionvalues,
          lt_return        TYPE /ey1/cl_sav_manage_int_mpc_ext=>tt_intentionvalues.


    SELECT * FROM /ey1/intention
      INTO TABLE @DATA(lt_intnsn). "#EC NO_WHERE

    READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Gjahr'.
    IF sy-subrc = 0.
      READ TABLE ls_filter-select_options INTO ls_opt INDEX 1.
      IF sy-subrc = 0.
        lv_gjahr         = ls_opt-low.
      ENDIF.
    ENDIF.

    READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'Intention'.
    IF sy-subrc = 0.
      READ TABLE ls_filter-select_options INTO ls_opt INDEX 1.
      IF sy-subrc = 0.
        lv_intention     = ls_opt-low.
      ENDIF.
    ENDIF.

    READ TABLE it_filter_select_options INTO ls_filter WITH KEY property = 'PeriodTo'.
    IF sy-subrc = 0.
      READ TABLE ls_filter-select_options INTO ls_opt INDEX 1.
      IF sy-subrc = 0.
        lv_periodto      = ls_opt-low.
      ENDIF.
    ENDIF.


    CASE lv_intention.
      WHEN 'Q1'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'Q1'.
       READ TABLE lt_intnsn INTO DATA(ls_intnsn) WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'Q2'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'PER'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'Q2'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'Q2'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'Q3'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'PER'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'Q3'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'Q3'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'TXP'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'PER'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'TXP'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'TXP'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'STR'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'STR'.
        ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'STR'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'CIT'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

      WHEN 'CIT'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'CIT'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'TXA'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'TXA'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'TXA'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       ls_return-intention  = 'TXU'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'TXU'.
       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'TXU'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN 'PER'.

       ls_return-gjahr      = lv_gjahr.
       ls_return-intention  = 'PER'.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.

       CASE lv_periodto.
       	WHEN '001' OR '002'.
          ls_return-intention  = 'Q1'.
       	WHEN '003' OR '004' OR '005'.
          ls_return-intention  = 'Q2'.
        WHEN '006' OR '007' OR '008'.
          ls_return-intention  = 'Q3'.
        WHEN '009' OR '010' OR '011'.
          ls_return-intention  = 'TXP'.
       	WHEN OTHERS.
          ls_return-intention  = 'TXP'.
       ENDCASE.
       READ TABLE lt_intnsn INTO ls_intnsn WITH KEY intent = ls_return-intention.
       IF sy-subrc = 0.
         ls_return-description  = ls_intnsn-description.
         ls_return-serialnumber = ls_intnsn-seqnr_flb.
         ls_return-periodto     = ls_intnsn-periodto.
       ENDIF.
       APPEND ls_return TO lt_return.
      WHEN OTHERS.
    ENDCASE.


    et_entityset[] = lt_return[].


  endmethod.
ENDCLASS.

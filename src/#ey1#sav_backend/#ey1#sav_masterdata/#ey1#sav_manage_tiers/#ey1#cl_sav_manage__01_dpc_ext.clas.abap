class /EY1/CL_SAV_MANAGE__01_DPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_MANAGE__01_DPC
  create public .

public section.

  data GV_FLAG type C .

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_END
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
protected section.

  methods AUTHSET_GET_ENTITYSET
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
  methods HANDLE_CHANGESET_UPDATE_ENTITY
    importing
      !IT_CHANGESET_REQUEST type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_REQUEST
    changing
      !CT_CHANGESET_RESPONSE type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_RESPONSE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods HANDLE_CHANGESET_DELETE_ENTITY
    importing
      !IT_CHANGESET_REQUEST type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_REQUEST
    changing
      !CT_CHANGESET_RESPONSE type /IWBEP/IF_MGW_APPL_TYPES=>TY_T_CHANGESET_RESPONSE
    raising
      /IWBEP/CX_MGW_TECH_EXCEPTION
      /IWBEP/CX_MGW_BUSI_EXCEPTION .
ENDCLASS.



CLASS /EY1/CL_SAV_MANAGE__01_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_begin.
    cv_defer_mode = abap_true.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_end.
    IF gv_flag = 'X'.
      ROLLBACK WORK.                                                    "#EC CI_ROLLBACK.
    ELSE.
      COMMIT WORK.
    ENDIF.
  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_process.
    "Data Declaration
    DATA: ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_changeset          TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          ls_data               TYPE /ey1/cl_sav_manage__01_mpc=>ts_xey1xsav_c_tierstype,

          lt_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_t_changeset_request,
          lt_group_request      TYPE /iwbep/if_mgw_appl_types=>ty_t_changeset_request,

          lo_create_context     TYPE REF TO /iwbep/if_mgw_req_entity_c,

          lv_entity_type        TYPE string.

    CONSTANTS: lc_entity_type TYPE string VALUE 'xEY1xSAV_C_TIERSType'.

    lt_changeset_request[] = it_changeset_request.

    SORT lt_changeset_request ASCENDING BY operation_type.

    TRY.
        LOOP AT lt_changeset_request INTO ls_changeset_request.

          MOVE-CORRESPONDING ls_changeset_request TO ls_changeset.

          "Downcasting from one more general source to specific target
          lo_create_context ?= ls_changeset_request-request_context.

          "Get entity type name
          lv_entity_type = lo_create_context->get_entity_type_name( ).

          IF lv_entity_type = lc_entity_type.
            APPEND ls_changeset_request TO lt_group_request.
          ENDIF.

          AT END OF operation_type.
            CASE ls_changeset_request-operation_type.

                "Create Entry
              WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-create_entity.
                handle_changeset_create_entity( EXPORTING it_changeset_request = lt_group_request
                                                CHANGING ct_changeset_response = ct_changeset_response ).

                "Update Entry
              WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-patch_entity OR /iwbep/if_mgw_appl_types=>gcs_operation_type-update_entity.
                handle_changeset_update_entity( EXPORTING it_changeset_request = lt_group_request
                                                CHANGING ct_changeset_response = ct_changeset_response ).

                "Delete Entry
              WHEN /iwbep/if_mgw_appl_types=>gcs_operation_type-delete_entity.
                handle_changeset_delete_entity( EXPORTING it_changeset_request = lt_group_request
                                                CHANGING ct_changeset_response = ct_changeset_response ).

              WHEN OTHERS.
                "Extract information from the request
                ls_changeset-entry_provider->read_entry_data( IMPORTING es_data = ls_data ).

                "Create Response
                copy_data_to_ref( EXPORTING is_data = ls_data
                                  CHANGING  cr_data = ls_changeset_response-entity_data ).

                ls_changeset_response-operation_no = ls_changeset-operation_no.
                INSERT ls_changeset_response INTO TABLE ct_changeset_response.
                CLEAR: ls_changeset_response.

                ls_changeset-msg_container->add_message( iv_msg_type               = 'E'
                                                         iv_msg_id                 = /ey1/sav_if_constants=>c_msg_id_savotta
                                                         iv_msg_number             = '014'
                                                         iv_msg_v1                 = /ey1/sav_if_constants=>c_msg_tier
                                                         iv_is_leading_message     = abap_false
                                                         iv_add_to_response_header = abap_true ).

                RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                  EXPORTING
                    message_container = ls_changeset-msg_container.

            ENDCASE.
            CLEAR: ls_changeset_request, ls_changeset, lt_group_request.
          ENDAT.
        ENDLOOP.

      CATCH /iwbep/cx_mgw_busi_exception.
        gv_flag = 'X'.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '000'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_false ).

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            message_container = mo_context->get_message_container( ).

    ENDTRY.
  ENDMETHOD.


  method AUTHSET_GET_ENTITYSET.
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


  METHOD handle_changeset_create_entity.
    "Data Declaration
    DATA: lt_tier               TYPE STANDARD TABLE OF /ey1/manage_tier,
          lv_msg_v1             TYPE symsgv, "Message Variable
          ls_request_input_data TYPE /ey1/cl_sav_manage__01_mpc=>ts_xey1xsav_c_tierstype,
          ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_tier               TYPE /ey1/manage_tier.

    TRY.
        LOOP AT it_changeset_request INTO ls_changeset_request.

          "Extract information from the request
          ls_changeset_request-entry_provider->read_entry_data(
           IMPORTING es_data = ls_request_input_data ).

          "Fill internal table of type '/EY1/MANAGE_TIER'
          ls_tier-land1       = ls_request_input_data-countrykey.
          ls_tier-ryear       = ls_request_input_data-fiscalyear.
          ls_tier-intention   = ls_request_input_data-intention.
          ls_tier-seqnr_flb   = ls_request_input_data-sequence.
          ls_tier-tier_amount = ls_request_input_data-tieramount.
          ls_tier-tax_rate    = ls_request_input_data-taxrate.
          ls_tier-local_currency = ls_request_input_data-localcurrency.
          APPEND ls_tier TO lt_tier.
          CLEAR: ls_tier.

          "Creating Response
          copy_data_to_ref( EXPORTING is_data = ls_request_input_data
                            CHANGING  cr_data = ls_changeset_response-entity_data ).

          ls_changeset_response-operation_no = ls_changeset_request-operation_no.
          INSERT ls_changeset_response INTO TABLE ct_changeset_response.
          CLEAR: ls_changeset_response,
                 ls_changeset_request,
                 ls_request_input_data.

          "Inserting new entries from batch to the DB table '/EY1/MANAGE_TIER'
          AT LAST.
            INSERT /ey1/manage_tier FROM TABLE lt_tier.
            IF sy-subrc IS INITIAL.

              "Success message
              LOOP AT lt_tier INTO DATA(ls_upd_tier).
                lv_msg_v1 = ls_upd_tier-seqnr_flb.
                mo_context->get_message_container( )->add_message( iv_msg_type                = 'S'
                                                                   iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                                   iv_msg_number              = '027'
                                                                   iv_msg_v1                  = lv_msg_v1
                                                                   iv_is_leading_message      = abap_false
                                                                   iv_add_to_response_header  = abap_true ).

              ENDLOOP.

            ELSE.

              "Error Message
              mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                                 iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                                 iv_msg_number              = '006'
                                                                 iv_is_leading_message      = abap_false
                                                                 iv_add_to_response_header  = abap_true ).

*              gv_flag = 'X'.

              RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                EXPORTING
                  message_container = mo_context->get_message_container( ).
            ENDIF.

            CLEAR lt_tier.
          ENDAT.
        ENDLOOP.

      CATCH /iwbep/cx_mgw_busi_exception.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '000'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_false ).

      CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db)  ##NEEDED.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '001'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_true ).

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            message_container = mo_context->get_message_container( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_changeset_delete_entity.
    "Data Declaration
    DATA: lt_tier               TYPE STANDARD TABLE OF /ey1/manage_tier,
          lt_keys               TYPE /iwbep/t_mgw_tech_pairs,
          lv_msg_v1             TYPE symsgv, "Message Variable

          ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_tier               TYPE /ey1/manage_tier,

          lo_patch_context      TYPE REF TO /iwbep/if_mgw_req_entity_p,
          lo_notfound_excep     TYPE REF TO cx_sy_itab_line_not_found,

          lv_land1              TYPE land1,
          lv_year               TYPE gjahr,
          lv_seq                TYPE seqnr_flb,
          lv_intention          TYPE /ey1/sav_intent.

    TRY.
        LOOP AT it_changeset_request INTO ls_changeset_request.

          lo_patch_context ?= ls_changeset_request-request_context.

          "Get table keys
          lt_keys = lo_patch_context->get_keys( ).

          "Get the key property values
          TRY.
              lv_land1     = lt_keys[ name = 'COUNTRYKEY' ]-value.
              lv_year      = lt_keys[ name = 'FISCALYEAR' ]-value.
              lv_intention = lt_keys[ name = 'INTENTION' ]-value.
              lv_seq       = lt_keys[ name = 'SEQUENCE' ]-value.

              "Exception handling
            CATCH cx_sy_itab_line_not_found INTO lo_notfound_excep.
              RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                EXPORTING
                  previous = lo_notfound_excep
                  textid   = /iwbep/cx_mgw_busi_exception=>business_error
                  message  = |{ lo_notfound_excep->get_text( ) }|.

          ENDTRY.

          SELECT SINGLE * FROM /ey1/manage_tier INTO ls_tier
            WHERE land1     = lv_land1
            AND   ryear     = lv_year
            AND   intention = lv_intention
            AND   seqnr_flb = lv_seq.
          IF sy-subrc IS INITIAL.
            APPEND ls_tier TO lt_tier.
            CLEAR: lv_seq, lt_keys.
          ENDIF.

          "Creating Response
          copy_data_to_ref( EXPORTING is_data = ls_changeset_request
                            CHANGING  cr_data = ls_changeset_response-entity_data ).

          ls_changeset_response-operation_no = ls_changeset_request-operation_no.

          INSERT ls_changeset_response INTO TABLE ct_changeset_response.

          CLEAR: ls_changeset_response,
                 ls_changeset_request,
                 ls_tier.

          "Deleting entry from DB table '/EY1/MANAGE_TIER'
*          CHECK lt_tier IS NOT INITIAL."added

          AT LAST.

            DELETE /ey1/manage_tier FROM TABLE lt_tier.
            IF sy-subrc IS INITIAL.

              "Success message
              LOOP AT lt_tier INTO DATA(ls_upd_tier).
                lv_msg_v1 = ls_upd_tier-seqnr_flb.
                mo_context->get_message_container( )->add_message( iv_msg_type                = 'S'
                                                                   iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                                   iv_msg_number              = '028'
                                                                   iv_msg_v1                  = lv_msg_v1
                                                                   iv_is_leading_message      = abap_false
                                                                   iv_add_to_response_header  = abap_true ).

              ENDLOOP.

            ELSE.
              "Error Message
              mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                                 iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                                 iv_msg_number              = '025'
                                                                 iv_is_leading_message      = abap_false
                                                                 iv_add_to_response_header  = abap_true ).

*              gv_flag = 'X'.

              RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                EXPORTING
                  message_container = mo_context->get_message_container( ).
            ENDIF.

            CLEAR lt_tier.
          ENDAT.
        ENDLOOP.

        "Deleting Dumping values from /ey1/tiers_split if no tiers is availbale for given country key, fiscal year & intention
        SELECT * FROM /ey1/manage_tier INTO TABLE @DATA(lt_tiers)
          WHERE land1 = @lv_land1
          AND   ryear = @lv_year
          AND   intention = @lv_intention.
          IF sy-subrc IS NOT INITIAL.
            SELECT SINGLE * FROM /ey1/tiers_split INTO @DATA(ls_split)
              WHERE ryear = @lv_year
              AND   land1 = @lv_land1
              AND   intention = @lv_intention.
              IF  sy-subrc IS INITIAL.
                DELETE /ey1/tiers_split FROM ls_split.
              ENDIF.
          ENDIF.

      CATCH /iwbep/cx_mgw_busi_exception INTO DATA(lx_busi_excp)  ##NEEDED.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '000'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_false ).

      CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db)  ##NEEDED.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '001'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_true ).

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            message_container = mo_context->get_message_container( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_changeset_update_entity.
    "Data Declaration
    DATA: lt_tier               TYPE STANDARD TABLE OF /ey1/manage_tier,
          lv_msg_v1             TYPE symsgv, "Message Variable
          ls_request_input_data TYPE /ey1/cl_sav_manage__01_mpc=>ts_xey1xsav_c_tierstype,
          ls_changeset_request  TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_request,
          ls_changeset_response TYPE /iwbep/if_mgw_appl_types=>ty_s_changeset_response,
          ls_tier               TYPE /ey1/manage_tier.

    TRY.
        LOOP AT it_changeset_request INTO ls_changeset_request.

          "Extract information from the request
          ls_changeset_request-entry_provider->read_entry_data(
           IMPORTING es_data = ls_request_input_data ).

          "Fill internal table of type '/EY1/MANAGE_TIER'
          ls_tier-land1       = ls_request_input_data-countrykey.
          ls_tier-ryear       = ls_request_input_data-fiscalyear.
          ls_tier-intention   = ls_request_input_data-intention.
          ls_tier-seqnr_flb   = ls_request_input_data-sequence.
          ls_tier-tier_amount = ls_request_input_data-tieramount.
          ls_tier-tax_rate    = ls_request_input_data-taxrate.
          ls_tier-local_currency = ls_request_input_data-localcurrency.
          APPEND ls_tier TO lt_tier.
          CLEAR: ls_tier.

          "Creating Response
          copy_data_to_ref( EXPORTING is_data = ls_request_input_data
                            CHANGING  cr_data = ls_changeset_response-entity_data ).

          ls_changeset_response-operation_no = ls_changeset_request-operation_no.
          INSERT ls_changeset_response INTO TABLE ct_changeset_response.
          CLEAR: ls_changeset_response,
                 ls_changeset_request,
                 ls_request_input_data.

          "Updating existing entries from batch to the DB table '/EY1/MANAGE_TIER'
          AT LAST.
            UPDATE /ey1/manage_tier FROM TABLE lt_tier.
            IF sy-subrc IS INITIAL.

              "Success message
              LOOP AT lt_tier INTO DATA(ls_upd_tier).
                lv_msg_v1 = ls_upd_tier-seqnr_flb.
                mo_context->get_message_container( )->add_message( iv_msg_type                = 'S'
                                                                   iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                                   iv_msg_number              = '026'
                                                                   iv_msg_v1                  = lv_msg_v1
                                                                   iv_is_leading_message      = abap_false
                                                                   iv_add_to_response_header  = abap_true ).
              ENDLOOP.

            ELSE.
              "Error Message
              mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                                 iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                                 iv_msg_number              = '001'
                                                                 iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                                 iv_is_leading_message      = abap_false
                                                                 iv_add_to_response_header  = abap_true ).

              RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
                EXPORTING
                  message_container = mo_context->get_message_container( ).

            ENDIF.
            CLEAR lt_tier.
          ENDAT.
        ENDLOOP.

      CATCH /iwbep/cx_mgw_busi_exception INTO DATA(lx_busi_excp)  ##NEEDED.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '000'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_false ).

      CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db)  ##NEEDED.
        mo_context->get_message_container( )->add_message( iv_msg_type                = 'E'
                                                           iv_msg_id                  = /ey1/sav_if_constants=>c_msg_id_savotta
                                                           iv_msg_number              = '001'
                                                           iv_msg_v1                  = /ey1/sav_if_constants=>c_msg_tier
                                                           iv_is_leading_message      = abap_false
                                                           iv_add_to_response_header  = abap_true ).

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            message_container = mo_context->get_message_container( ).

    ENDTRY.
  ENDMETHOD.
ENDCLASS.

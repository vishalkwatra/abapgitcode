class /EY1/CL_SAV_V_CHECK_SGAAP_MAND definition
  public
  inheriting from /BOBF/CL_LIB_V_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_VALIDATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_V_CHECK_SGAAP_MAND IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.
**Data Declarations
    DATA: lt_item_data    TYPE /ey1/t_sav_i_sgaap_tas,            "Typed with node's combined table type
          lt_header_data  TYPE /ey1/t_sav_i_ggaap_tas             ##NEEDED,
          lt_value_tab   TYPE TABLE OF dd07v,

          lv_lifetime   TYPE /bobf/cm_frw=>ty_message_lifetime.

    FIELD-SYMBOLS: <fs_value_tab> TYPE dd07v.

    CONSTANTS: lv_msg_id TYPE string VALUE '/EY1/SAV_SAVOTTA'.

**Retrieve the data of the requested node instance
    io_read->retrieve(
    EXPORTING
      iv_node         = is_ctx-node_key
      it_key          = it_key
    IMPORTING
      et_data         = lt_item_data
      eo_message      = eo_message
      et_failed_key   = et_failed_key ).

**Message Container
    eo_message = /bobf/cl_frw_factory=>get_message( ).

    LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_item>).
      IF <fs_item>-isactiveentity = abap_false.
        lv_lifetime = /bobf/cm_frw=>co_lifetime_state.       "draft
      ELSE.
        lv_lifetime = /bobf/cm_frw=>co_lifetime_transition.  "active
      ENDIF.

**Item validation
      IF <fs_item>-dtintracompanyelimination IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-001
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_item>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-dtintracompanyelimination
                                           iv_lifetime  = lv_lifetime ).

        APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/dtice_vh INTO @DATA(ls_dtice)
          WHERE dtice = @<fs_item>-dtintracompanyelimination.
          IF sy-subrc IS NOT INITIAL.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                 msgno = 010
                                                                 msgv1 = TEXT-001
                                                                 msgty = /bobf/cm_frw=>co_severity_error )
                                               iv_node      = is_ctx-node_key
                                               iv_key       = <fs_item>-key
                                               iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-dtintracompanyelimination
                                               iv_lifetime  = lv_lifetime ).

            APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
          ENDIF.
          CLEAR ls_dtice.
      ENDIF.

      IF <fs_item>-dtarecognition IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-002
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_item>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-dtarecognition
                                           iv_lifetime  = lv_lifetime ).

        APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/dtareco_vh INTO @DATA(ls_dta)
          WHERE dta_recognition = @<fs_item>-dtarecognition.
          IF sy-subrc IS NOT INITIAL.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                 msgno = 010
                                                                 msgv1 = TEXT-002
                                                                 msgty = /bobf/cm_frw=>co_severity_error )
                                               iv_node      = is_ctx-node_key
                                               iv_key       = <fs_item>-key
                                               iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-dtarecognition
                                               iv_lifetime  = lv_lifetime ).

            APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
          ENDIF.
          CLEAR ls_dta.
      ENDIF.

      IF <fs_item>-taxratechange IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-003
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_item>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-taxratechange
                                           iv_lifetime  = lv_lifetime ).

        APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/taxrate_vh INTO @DATA(ls_tax)
          WHERE tax_rate_change = @<fs_item>-taxratechange.
          IF sy-subrc IS NOT INITIAL.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                 msgno = 010
                                                                 msgv1 = TEXT-003
                                                                 msgty = /bobf/cm_frw=>co_severity_error )
                                               iv_node      = is_ctx-node_key
                                               iv_key       = <fs_item>-key
                                               iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-taxratechange
                                               iv_lifetime  = lv_lifetime ).

            APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
          ENDIF.
          CLEAR ls_tax.
      ENDIF.

      IF <fs_item>-classification IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-004
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_item>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-classification
                                           iv_lifetime  = lv_lifetime ).

        APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/class_vh INTO @DATA(ls_class)
          WHERE classification = @<fs_item>-classification.
          IF sy-subrc IS NOT INITIAL.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                 msgno = 010
                                                                 msgv1 = TEXT-004
                                                                 msgty = /bobf/cm_frw=>co_severity_error )
                                               iv_node      = is_ctx-node_key
                                               iv_key       = <fs_item>-key
                                               iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-classification
                                               iv_lifetime  = lv_lifetime ).

            APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
          ENDIF.
          CLEAR lt_value_tab.
      ENDIF.

      IF <fs_item>-consolidationunitforedit IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-005
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_item>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-consolidationunitforedit
                                           iv_lifetime  = lv_lifetime ).

        APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
      ELSE.
        IF <fs_item>-hasactiveentity = abap_false.
          SELECT SINGLE ConsolidationUnit FROM C_CnsldtnUnitValueHelp
            INTO @DATA(ls_bunit) WHERE ConsolidationUnit = @<fs_item>-consolidationunitforedit.
            IF sy-subrc IS NOT INITIAL.
              eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                   msgno = 010
                                                                   msgv1 = TEXT-005
                                                                   msgty = /bobf/cm_frw=>co_severity_error )
                                                 iv_node      = is_ctx-node_key
                                                 iv_key       = <fs_item>-key
                                                 iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-consolidationunitforedit
                                                 iv_lifetime  = lv_lifetime ).

              APPEND VALUE #( key = <fs_item>-key ) TO et_failed_key.
            ENDIF.
      ENDIF.
    ENDIF.
    CLEAR lv_lifetime.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

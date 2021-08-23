class /EY1/CL_SAV_V_CHECK_GGAAP_MAND definition
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



CLASS /EY1/CL_SAV_V_CHECK_GGAAP_MAND IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.
**Data Declarations
    DATA: lt_header_data TYPE /ey1/t_sav_i_ggaap_tas,             "Typed with node's combined table type

          lv_lifetime    TYPE /bobf/cm_frw=>ty_message_lifetime.

    CONSTANTS: lv_msg_id TYPE string VALUE '/EY1/SAV_SAVOTTA'.

**Retrieve the data of the requested node instance
    io_read->retrieve(
    EXPORTING
      iv_node         = is_ctx-node_key
      it_key          = it_key
    IMPORTING
      et_data         = lt_header_data
      eo_message      = eo_message
      et_failed_key   = et_failed_key ).

**Message Container
    eo_message = /bobf/cl_frw_factory=>get_message( ).

    LOOP AT lt_header_data ASSIGNING FIELD-SYMBOL(<fs_header>).
      IF <fs_header>-isactiveentity = abap_false.
        lv_lifetime = /bobf/cm_frw=>co_lifetime_state.         "draft
      ELSE.
        lv_lifetime = /bobf/cm_frw=>co_lifetime_transition.    "active
      ENDIF.

      IF <fs_header>-dtintracompanyelimination  IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-001
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_header>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-dtintracompanyelimination
                                           iv_lifetime  = lv_lifetime ).

       APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
     ELSE.
**Check if given input is from Value table
       SELECT SINGLE * FROM /ey1/dtice_vh INTO @DATA(ls_dtice)
         WHERE dtice = @<fs_header>-dtintracompanyelimination.
         IF sy-subrc IS NOT INITIAL.
           eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                msgno = 010
                                                                msgv1 = TEXT-001
                                                                msgty = /bobf/cm_frw=>co_severity_error )
                                              iv_node      = is_ctx-node_key
                                              iv_key       = <fs_header>-key
                                              iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-dtintracompanyelimination
                                              iv_lifetime  = lv_lifetime ).

           APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
         ENDIF.
       CLEAR ls_dtice.
      ENDIF.

      IF <fs_header>-dtarecongnition IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-002
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_header>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-dtarecongnition
                                           iv_lifetime  = lv_lifetime ).

       APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/dtareco_vh INTO @DATA(ls_dta)
          WHERE dta_recognition = @<fs_header>-dtarecongnition.
          IF sy-subrc IS NOT INITIAL.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                 msgno = 010
                                                                 msgv1 = TEXT-002
                                                                 msgty = /bobf/cm_frw=>co_severity_error )
                                               iv_node      = is_ctx-node_key
                                               iv_key       = <fs_header>-key
                                               iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-dtarecongnition
                                               iv_lifetime  = lv_lifetime ).

           APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
         ENDIF.
         CLEAR ls_dta.
      ENDIF.

      IF <fs_header>-taxratechange IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-003
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_header>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-taxratechange
                                           iv_lifetime  = lv_lifetime ).

       APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/taxrate_vh INTO @DATA(ls_tax)
          WHERE tax_rate_change = @<fs_header>-taxratechange.
          IF sy-subrc IS NOT INITIAL.
             eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                  msgno = 010
                                                                  msgv1 = TEXT-003
                                                                  msgty = /bobf/cm_frw=>co_severity_error )
                                                iv_node      = is_ctx-node_key
                                                iv_key       = <fs_header>-key
                                                iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-taxratechange
                                                iv_lifetime  = lv_lifetime ).

            APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
         ENDIF.
         CLEAR ls_tax.
      ENDIF.

      IF <fs_header>-classification IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-004
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_header>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-classification
                                           iv_lifetime  = lv_lifetime ).

       APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
      ELSE.
**Check if given input is from Value table
        SELECT SINGLE * FROM /ey1/class_vh INTO @DATA(ls_class)
          WHERE classification = @<fs_header>-classification.
          IF sy-subrc IS NOT INITIAL.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                 msgno = 010
                                                                 msgv1 = TEXT-004
                                                                 msgty = /bobf/cm_frw=>co_severity_error )
                                               iv_node      = is_ctx-node_key
                                               iv_key       = <fs_header>-key
                                               iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-classification
                                               iv_lifetime  = lv_lifetime ).

           APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
         ENDIF.
         CLEAR ls_class.
      ENDIF.

      IF <fs_header>-consolidationgroupforedit IS INITIAL.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                             msgno = 009
                                                             msgv1 = TEXT-005
                                                             msgty = /bobf/cm_frw=>co_severity_error )
                                           iv_node      = is_ctx-node_key
                                           iv_key       = <fs_header>-key
                                           iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-consolidationgroupforedit
                                           iv_lifetime  = lv_lifetime ).

       APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
      ELSE.
        IF <fs_header>-hasactiveentity = abap_false.
          SELECT SINGLE ConsolidationGroup FROM C_CnsldtnGroupAllVH
            INTO @DATA(ls_rcongr) WHERE ConsolidationGroup = @<fs_header>-consolidationgroupforedit.
            IF sy-subrc IS INITIAL.
              SELECT SINGLE rcongr FROM /ey1/ggaap_tas INTO @DATA(ls_ggaap) ##NEEDED
               WHERE rcongr = @<fs_header>-consolidationgroupforedit.
               IF sy-subrc IS INITIAL.
                 eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                      msgno = 021
                                                                      msgv1 = <fs_header>-consolidationgroupforedit
                                                                      msgty = /bobf/cm_frw=>co_severity_error )
                                                    iv_node      = is_ctx-node_key
                                                    iv_key       = <fs_header>-key
                                                    iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-consolidationgroupforedit
                                                    iv_lifetime  = lv_lifetime ).

                 APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
               ENDIF.
            ELSE.
              eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                   msgno = 010
                                                                   msgv1 = TEXT-005
                                                                   msgty = /bobf/cm_frw=>co_severity_error )
                                                 iv_node      = is_ctx-node_key
                                                 iv_key       = <fs_header>-key
                                                 iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-consolidationgroupforedit
                                                 iv_lifetime  = lv_lifetime ).

              APPEND VALUE #( key = <fs_header>-key ) TO et_failed_key.
           ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

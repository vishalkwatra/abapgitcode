class /EY1/CL_D_SAV_I_SGAAP_TAS_ACTI definition
  public
  inheriting from /BOBF/CL_LIB_D_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DETERMINATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_D_SAV_I_SGAAP_TAS_ACTI IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.
**Data Declaration
    DATA: lt_sgaap TYPE STANDARD TABLE OF /ey1/s_sav_i_sgaap_tas.

    io_read->retrieve(                                     ##NEEDED
     EXPORTING
       iv_node                 = is_ctx-node_key           " Node Name
       it_key                  = it_key                    " Key Table
       iv_fill_data            = abap_true
     IMPORTING
       eo_message              = DATA(lo_message)          " Message Object
       et_data                 = lt_sgaap                  " Data Return Structure
       et_failed_key           = et_failed_key ).          " Key Table

    DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
                                                                is_context = is_ctx ).

    LOOP AT lt_sgaap INTO DATA(ls_sgaap).
      IF ls_sgaap-hasactiveentity = abap_false.   "Create

        "Changed_by - Item Section
        lo_property_helper->set_attribute_enabled(
                            iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-changedby
                            iv_key            = ls_sgaap-key
                            iv_value          = abap_false ).

        "Changed_on - Item Section
        lo_property_helper->set_attribute_enabled(
                            iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-changedon
                            iv_key            = ls_sgaap-key
                            iv_value          = abap_false ).
      ELSE.
        "Prevent editing of key value in Fiori Elements object page
        lo_property_helper->set_attribute_read_only( iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-consolidationunitforedit
                                                     iv_key            = ls_sgaap-key ).
        "Changed_by
        IF ls_sgaap-changedby IS INITIAL.
          lo_property_helper->set_attribute_enabled(
                            iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-changedby
                            iv_key            = ls_sgaap-key
                            iv_value          = abap_false ).
        ELSE.
          lo_property_helper->set_attribute_enabled(
                              iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-changedby
                              iv_key            = ls_sgaap-key
                              iv_value          = abap_true ).


        ENDIF.

        "Changed_on
        IF ls_sgaap-changedon IS INITIAL.
          lo_property_helper->set_attribute_enabled(
                            iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-changedon
                            iv_key            = ls_sgaap-key
                            iv_value          = abap_false ).
        ELSE.
          lo_property_helper->set_attribute_enabled(
                            iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-changedon
                            iv_key            = ls_sgaap-key
                            iv_value          = abap_true ).

        ENDIF.
      ENDIF.
      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '06'.
      IF sy-subrc <> 0.
                             CALL METHOD lo_property_helper->set_node_delete_enabled
                              EXPORTING
                                iv_key  = ls_sgaap-key
                               iv_value = abap_false.

                             CALL METHOD lo_property_helper->set_nodesubtree_delete_enabled
                                  EXPORTING
                                     iv_key   = ls_sgaap-key
                                     iv_value =  abap_false.
      ENDIF.
      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '02'.
      IF sy-subrc <> 0.

                            CALL METHOD lo_property_helper->set_node_update_enabled
                              EXPORTING
                                iv_key   = ls_sgaap-key
                              iv_value = abap_false.

                            CALL METHOD lo_property_helper->set_nodesubtree_update_enabled
                               EXPORTING
                                 iv_key   = ls_sgaap-key
                                 iv_value = abap_false.

      ENDIF.
      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '02'.
      IF sy-subrc <> 0.
                            CALL METHOD lo_property_helper->set_nodesubtree_change_enabled
                              EXPORTING
                                iv_key   = ls_sgaap-key
                                iv_value = abap_false.
      ENDIF.

      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '01'.
      IF sy-subrc <> 0.
                            CALL METHOD lo_property_helper->set_nodesubtree_create_enabled
                                  EXPORTING
                                    iv_key   = ls_sgaap-key
                                  iv_value = abap_false.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

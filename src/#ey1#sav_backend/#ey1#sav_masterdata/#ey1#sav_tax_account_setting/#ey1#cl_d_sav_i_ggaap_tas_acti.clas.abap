class /EY1/CL_D_SAV_I_GGAAP_TAS_ACTI definition
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



CLASS /EY1/CL_D_SAV_I_GGAAP_TAS_ACTI IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

**Data Declarations
    DATA: lt_ggaap TYPE STANDARD TABLE OF /ey1/s_sav_i_ggaap_tas,
          lt_sgaap TYPE STANDARD TABLE OF /ey1/s_sav_i_sgaap_tas,
          lt_active_document_keys TYPE /ey1/t_k_sav_i_ggaap_tas_activ,

          lo_change TYPE REF TO /bobf/if_frw_change                   ##NEEDED,

          lv_fieldname            TYPE string.

**Retrieve Header Data
    io_read->retrieve(                                         ##NEEDED
     EXPORTING
       iv_node                 = is_ctx-node_key               " Node Name
       it_key                  = it_key                        " Key Table
       iv_fill_data            = abap_true
     IMPORTING
       eo_message              = DATA(lo_message)              " Message Object
       et_data                 = lt_ggaap                      " Data Return Structure
       et_failed_key           = et_failed_key ).              " Key Table

**Initialize helper
    DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
                                                                is_context = is_ctx ).

**Create a message container
    eo_message = /bobf/cl_frw_message_factory=>create_container( ).

*-----------------------------------------------------------------
*   Get Draft and BOPF keys
*-----------------------------------------------------------------
    CALL METHOD /bobf/cl_lib_draft=>/bobf/if_lib_union_utilities~separate_keys
      EXPORTING
        iv_bo_key     = is_ctx-bo_key
        iv_node_key   = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        et_draft_key  = DATA(lt_draft_bopf_keys)
        et_active_key = DATA(lt_active_bopf_keys).

*-----------------------------------------------------------------
*   Get active document keys
*-----------------------------------------------------------------
    DATA(lo_lib_legacy_key) =  /bobf/cl_lib_legacy_key=>get_instance( is_ctx-bo_key ).

    lo_lib_legacy_key->convert_bopf_to_legacy_keys(
      EXPORTING
        iv_node_key   =  is_ctx-node_key
        it_bopf_key   =  lt_active_bopf_keys
      IMPORTING
        et_legacy_key =  lt_active_document_keys ).

    READ TABLE it_key INTO DATA(ls_key) INDEX 1 .
    READ TABLE lt_ggaap REFERENCE INTO DATA(lr_data) INDEX 1.

**Prevent editing of key value in Fiori Elements object page
    LOOP AT lt_ggaap INTO DATA(ls_ggaap).
      IF lr_data->isactiveentity = abap_true.  "Display
        "Changed_by
        IF lr_data->changedby IS INITIAL.
          lo_property_helper->set_attribute_enabled(
                              iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedby
                              iv_key            = ls_ggaap-key
                              iv_value          = abap_false ).
        ELSE.
           lo_property_helper->set_attribute_enabled(
                               iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedby
                               iv_key            = ls_ggaap-key
                               iv_value          = abap_true ).

           lo_property_helper->set_attribute_mandatory(
                               iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedby
                               iv_key            = ls_ggaap-key
                               iv_value          = abap_true ).

        ENDIF.

        "Changed_on
        IF lr_data->changedon IS INITIAL.
          lo_property_helper->set_attribute_enabled(
                              iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedon
                              iv_key            = ls_ggaap-key
                              iv_value          = abap_false ).
        ELSE.
           lo_property_helper->set_attribute_enabled(
                               iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedon
                               iv_key            = ls_ggaap-key
                               iv_value          = abap_true ).
        ENDIF.

      ELSE.
        IF lr_data->hasactiveentity = abap_false. "Create

          "Changed_by
          lo_property_helper->set_attribute_enabled(
                              iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedby
                              iv_key            = ls_ggaap-key
                              iv_value          = abap_false ).
          "Changed_on
          lo_property_helper->set_attribute_enabled(
                              iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedon
                              iv_key            = ls_ggaap-key
                              iv_value          = abap_false ).
        ELSE.
          "Changed_by                                      "Edit
          IF lr_data->changedby IS INITIAL.
            lo_property_helper->set_attribute_enabled(
                                   iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedby
                                   iv_key            = ls_ggaap-key
                                   iv_value          = abap_false ).
          ELSE.
            lo_property_helper->set_attribute_enabled(
                                    iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedby
                                    iv_key            = ls_ggaap-key
                                    iv_value          = abap_true ).
          ENDIF.

          "Changed_on
          IF lr_data->changedon IS INITIAL.
            lo_property_helper->set_attribute_enabled(
                                   iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedon
                                   iv_key            = ls_ggaap-key
                                   iv_value          = abap_false ).
          ELSE.
            lo_property_helper->set_attribute_enabled(
                                    iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-changedon
                                    iv_key            = ls_ggaap-key
                                    iv_value          = abap_true ).
          ENDIF.
        ENDIF.
      ENDIF.

      IF ls_ggaap-consolidationgroupforedit IS NOT INITIAL.
        SELECT SINGLE * FROM C_CnsldtnGroupAllVH INTO @DATA(ls_rcongr)
        WHERE consolidationgroup = @ls_ggaap-consolidationgroupforedit.
        IF sy-subrc IS INITIAL.
          IF ( ls_ggaap-hasactiveentity EQ abap_true AND ls_ggaap-isactiveentity EQ abap_false ) "Edit Mode
          OR ( ls_ggaap-hasactiveentity EQ abap_false AND ls_ggaap-isactiveentity EQ abap_true ). "Display Mode

            lo_property_helper->set_attribute_read_only( iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-consolidationgroupforedit
                                                         iv_key            = ls_ggaap-key
                                                         iv_value          = abap_true ).

            lo_property_helper->set_attribute_enabled( iv_attribute_name   = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-consolidationgroupforedit
                                                       iv_key              = ls_ggaap-key
                                                       iv_value            = abap_false ).

            lo_property_helper->set_attribute_mandatory( iv_attribute_name = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_ggaap_tas-consolidationgroupforedit
                                                         iv_key            = ls_ggaap-key
                                                         iv_value          = abap_false ).
          ENDIF.
        ENDIF.
      ENDIF.

      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '06'.
      IF sy-subrc <> 0.
            CALL METHOD lo_property_helper->set_node_delete_enabled
              EXPORTING
                iv_key  = ls_ggaap-key
                iv_value = abap_false.


            CALL METHOD lo_property_helper->set_nodesubtree_delete_enabled
               EXPORTING
                 iv_key   = ls_ggaap-key
                 iv_value =  abap_false.
      ENDIF.

      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '02'.
      IF sy-subrc <> 0.
            CALL METHOD lo_property_helper->set_nodesubtree_change_enabled
              EXPORTING
                iv_key   = ls_ggaap-key
                iv_value = abap_false.

            CALL METHOD lo_property_helper->set_node_update_enabled
              EXPORTING
                iv_key   = ls_ggaap-key
                iv_value = abap_false.

            CALL METHOD lo_property_helper->set_nodesubtree_update_enabled
               EXPORTING
                 iv_key   = ls_ggaap-key
                 iv_value = abap_false.
      ENDIF.

      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD '01'.
      IF sy-subrc <> 0.
            CALL METHOD lo_property_helper->set_nodesubtree_create_enabled
              EXPORTING
                iv_key   = ls_ggaap-key
                iv_value = abap_false.
      ENDIF.


ENDLOOP.
  ENDMETHOD.
ENDCLASS.

class /EY1/CL_SAV_D_FC_CNC_FIELD definition
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



CLASS /EY1/CL_SAV_D_FC_CNC_FIELD IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
                                                                is_context = is_ctx ).

    DATA: lt_active_document_keys TYPE /EY1/T_K_SAV_I_ACC_CLASS_ACTIV   ##NEEDED,
          lt_draft_headers        TYPE /EY1/T_SAV_I_ACC_CLASS,
          lt_active_headers       TYPE /EY1/T_SAV_I_ACC_CLASS,
          lt_all_headers          TYPE /EY1/T_SAV_I_ACC_CLASS.

**Separate into active and draft keys
    CALL METHOD /bobf/cl_lib_draft=>/bobf/if_lib_union_utilities~separate_keys
      EXPORTING
        iv_bo_key     = is_ctx-bo_key
        iv_node_key   = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        et_draft_key  = DATA(lt_draft_bopf_keys)
        et_active_key = DATA(lt_active_bopf_keys).

    DATA(lo_lib_legacy_key) =  /bobf/cl_lib_legacy_key=>get_instance( is_ctx-bo_key ).

**Get active document keys
    lo_lib_legacy_key->convert_bopf_to_legacy_keys(
      EXPORTING
        iv_node_key   =  is_ctx-node_key
        it_bopf_key   =  lt_active_bopf_keys
      IMPORTING
        et_legacy_key =  lt_active_document_keys ).

**Retrieve draft objects
    IF lt_draft_bopf_keys IS NOT INITIAL.
      io_read->retrieve( EXPORTING iv_node = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS
                                   it_key  = lt_draft_bopf_keys
                         IMPORTING et_data = lt_draft_headers ).
    ENDIF.

**Retrieve active data
    IF lt_active_bopf_keys IS NOT INITIAL.
      io_read->retrieve(
       EXPORTING
         iv_node = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS
         it_key  = lt_active_bopf_keys
       IMPORTING
         et_data = lt_active_headers ).
    ENDIF.

    APPEND LINES OF lt_draft_headers  TO lt_all_headers.
    APPEND LINES OF lt_active_headers TO lt_all_headers.

    LOOP AT lt_all_headers ASSIGNING FIELD-SYMBOL(<fs_header>).
      IF <fs_header>-isactiveentity EQ abap_false.                               " draft mode
        IF <fs_header>-bseqpl <> 'BS'.
          lo_property_helper->set_attribute_read_only( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                       iv_key            = <fs_header>-key
                                                       iv_value          = abap_true ).
          lo_property_helper->set_attribute_enabled( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                        iv_key            = <fs_header>-key
                                                        iv_value          = abap_false ).
          lo_property_helper->set_attribute_mandatory( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                iv_key            = <fs_header>-key
                                                iv_value          = abap_false ).
          CLEAR <fs_header>-currentnoncurrent.

**Set header status
          io_modify->update(
              iv_node           = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS
              iv_key            = <fs_header>-key
              is_data           = REF #( <fs_header> ) ).

        ELSE.
          lo_property_helper->set_attribute_read_only( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                       iv_key            = <fs_header>-key
                                                       iv_value          = abap_false ).
          lo_property_helper->set_attribute_enabled( iv_attribute_name   = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                     iv_key              = <fs_header>-key
                                                     iv_value            = abap_true ).

          lo_property_helper->set_attribute_mandatory( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                        iv_key           = <fs_header>-key
                                                        iv_value         = abap_true ).
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

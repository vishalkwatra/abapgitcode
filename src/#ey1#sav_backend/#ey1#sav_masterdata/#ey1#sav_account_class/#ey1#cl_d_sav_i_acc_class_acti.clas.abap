class /EY1/CL_D_SAV_I_ACC_CLASS_ACTI definition
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



CLASS /EY1/CL_D_SAV_I_ACC_CLASS_ACTI IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA: lt_acc TYPE STANDARD TABLE OF /EY1/S_SAV_I_ACC_CLASS,
          lt_acc_after TYPE STANDARD TABLE OF /EY1/S_SAV_I_ACC_CLASS          ##NEEDED,
          lo_change TYPE REF TO /bobf/if_frw_change                  ##NEEDED.

    DATA: lt_active_document_keys TYPE /EY1/T_K_SAV_I_ACC_CLASS_ACTIV ##NEEDED,
          lt_draft_headers        TYPE /EY1/T_SAV_I_ACC_CLASS,
          lt_active_headers       TYPE /EY1/T_SAV_I_ACC_CLASS,
          lt_all_headers          TYPE /EY1/T_SAV_I_ACC_CLASS,
          lv_fieldname            TYPE string,
          lt_changed_fields       TYPE /bobf/t_frw_name        ##NEEDED.

    io_read->retrieve(                                         ##NEEDED
     EXPORTING
       iv_node                 = is_ctx-node_key               " Node Name
       it_key                  = it_key                        " Key Table
       iv_fill_data            = abap_true
       iv_before_image         = abap_false
     IMPORTING
       eo_message              = DATA(lo_message)              " Message Object
       et_data                 = lt_acc                        " Data Return Structure
       et_failed_key           = et_failed_key ).              " Key Table

    io_read->retrieve(
         EXPORTING
           iv_node                 = is_ctx-node_key           " Node Name
           it_key                  = it_key                    " Key Table
           iv_fill_data            = abap_true
           iv_before_image         = abap_true
         IMPORTING
           eo_message              = lo_message                " Message Object
           et_data                 = lt_acc_after              " Data Return Structure
           et_failed_key           = et_failed_key ).          " Key Table


    DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
                                                                is_context = is_ctx ).

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

    lv_fieldname = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent.
    APPEND lv_fieldname TO lt_changed_fields.

    LOOP AT lt_all_headers ASSIGNING FIELD-SYMBOL(<fs_header>).
      IF <fs_header>-isactiveentity EQ abap_false.                           " draft mode
        IF <fs_header>-bseqpl <> 'BS'.
          lo_property_helper->set_attribute_read_only( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                       iv_key            = <fs_header>-key
                                                       iv_value          = abap_true ).

          lo_property_helper->set_attribute_enabled( iv_attribute_name   = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                     iv_key              = <fs_header>-key
                                                     iv_value            = abap_false ).

          lo_property_helper->set_attribute_mandatory( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                       iv_key            = <fs_header>-key
                                                       iv_value          = abap_false ).

        ELSE.
          lo_property_helper->set_attribute_read_only( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                       iv_key            = <fs_header>-key
                                                       iv_value          = abap_false ).

          lo_property_helper->set_attribute_enabled( iv_attribute_name   = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                     iv_key              = <fs_header>-key
                                                     iv_value            = abap_true ).

          lo_property_helper->set_attribute_mandatory( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                                       iv_key            = <fs_header>-key
                                                       iv_value          = abap_true ).
        ENDIF.
      ENDIF.
    ENDLOOP.

**Prevent editing of key value in Fiori Elements object page
    LOOP AT lt_acc INTO DATA(ls_acc).
      IF ls_acc-hasactiveentity EQ abap_true.    " edit mode
        lo_property_helper->set_attribute_read_only( iv_attribute_name = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-accountclasscodeforedit
                                                     iv_key            = ls_acc-key ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

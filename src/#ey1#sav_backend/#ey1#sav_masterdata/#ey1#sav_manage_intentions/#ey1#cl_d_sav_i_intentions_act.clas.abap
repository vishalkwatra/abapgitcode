class /EY1/CL_D_SAV_I_INTENTIONS_ACT definition
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



CLASS /EY1/CL_D_SAV_I_INTENTIONS_ACT IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    "DATA :"ls_key TYPE /EY1/S_SAV_I_INTENTIONS,
"          lt_key TYPE STANDARD TABLE OF  /ey1/s_sav_i_intentions.

"**Retrieve Header Data
"    io_read->retrieve(                                         ##NEEDED
"     EXPORTING
"       iv_node                 = is_ctx-node_key               " Node Name
"       it_key                  = it_key                        " Key Table
"       iv_fill_data            = abap_true
"     IMPORTING
"       eo_message              = DATA(lo_message)              " Message Object
"       et_data                 = lt_key                      " Data Return Structure
"       et_failed_key           = et_failed_key ).              " Key Table


"**Initialize helper
"    DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
"                                                                is_context = is_ctx ).



"**Prevent editing of key value in Fiori Elements object page
"  LOOP AT lt_key INTO DATA(ls_key).
"    AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
"                                             ID 'ACTVT' FIELD '06'.
"      IF sy-subrc <> 0.
"            CALL METHOD lo_property_helper->set_node_delete_enabled
"              EXPORTING
"                iv_key  = ls_key-key"ls_ggaap-key
"                iv_value = abap_false.


"            CALL METHOD lo_property_helper->set_nodesubtree_delete_enabled
"               EXPORTING
"                 iv_key   = ls_key-key
"                 iv_value =  abap_false.
"      ENDIF.

"      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
"                                             ID 'ACTVT' FIELD '02'.
"      IF sy-subrc <> 0.
"            CALL METHOD lo_property_helper->set_nodesubtree_change_enabled
"              EXPORTING
"                iv_key   = ls_key-key
"                iv_value = abap_false.

"            CALL METHOD lo_property_helper->set_node_update_enabled
"              EXPORTING
"                iv_key   = ls_key-key
"                iv_value = abap_false.

"            CALL METHOD lo_property_helper->set_nodesubtree_update_enabled
"               EXPORTING
"                 iv_key   = ls_key-key
"                 iv_value = abap_false.
"      ENDIF.

"      AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
"                                             ID 'ACTVT' FIELD '01'.
"      IF sy-subrc <> 0.
"            CALL METHOD lo_property_helper->set_nodesubtree_create_enabled
"              EXPORTING
"                iv_key   = ls_key-key
"                iv_value = abap_false.
"      ENDIF.

"  ENDLOOP.
  ENDMETHOD.
ENDCLASS.

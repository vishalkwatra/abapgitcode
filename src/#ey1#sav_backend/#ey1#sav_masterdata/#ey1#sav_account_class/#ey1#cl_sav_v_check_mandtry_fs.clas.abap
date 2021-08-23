class /EY1/CL_SAV_V_CHECK_MANDTRY_FS definition
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



CLASS /EY1/CL_SAV_V_CHECK_MANDTRY_FS IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

**Typed with node's combined table type
  DATA: lt_item_data  TYPE /EY1/T_SAV_I_ACC_FS_ITEM,
        ls_location   TYPE /bobf/s_frw_location                ##NEEDED,
        lm_message    TYPE REF TO /bobf/cm_frw_common_esi      ##NEEDED,
        lv_lifetime   TYPE /bobf/cm_frw=>ty_message_lifetime,
        lt_header_data  TYPE /EY1/T_SAV_I_ACC_CLASS                     ##NEEDED,
        lt_itm_data    TYPE /EY1/T_SAV_I_ACC_FS_ITEM                     ##NEEDED.

**Retrieve the data of the requested node instance
  io_read->retrieve(
  EXPORTING
    iv_node         = is_ctx-node_key
    it_key          = it_key
  IMPORTING
    et_data         = lt_item_data
    eo_message      = eo_message
    et_failed_key   = et_failed_key ).

  eo_message = /bobf/cl_frw_factory=>get_message( ).

  LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<ls_item>).
    IF <ls_item>-isactiveentity = abap_false.
      lv_lifetime = /bobf/cm_frw=>co_lifetime_state.       "draft
    ELSE.
      lv_lifetime = /bobf/cm_frw=>co_lifetime_transition.  "active
    ENDIF.

**FS Item validation
    IF <ls_item>-financialstatementitemforedit IS INITIAL.

      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                           msgno = 009
                                                           msgv1 = TEXT-002
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_item>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_FS_ITEM-financialstatementitemforedit
                                         iv_lifetime  = lv_lifetime ).
      APPEND VALUE #( key = <ls_item>-key ) TO et_failed_key.
    ELSE.
      SELECT SINGLE item FROM fincs_fsitem INTO @DATA(ls_fsitem) WHERE itclg = @<ls_item>-consolidationcoaforedit       ##NEEDED
                                                                   AND  item = @<ls_item>-financialstatementitemforedit.
        IF sy-subrc IS NOT INITIAL.

          eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                               msgno = 012
                                                               msgv1 = <ls_item>-financialstatementitemforedit
                                                               msgv2 = <ls_item>-consolidationcoaforedit
                                                               msgty = /bobf/cm_frw=>co_severity_error )
                                              iv_node = is_ctx-node_key
                                              iv_key  = <ls_item>-key
                                              iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_FS_ITEM-financialstatementitemforedit
                                              iv_lifetime  = lv_lifetime ).
          APPEND VALUE #( key = <ls_item>-key ) TO et_failed_key.
        ENDIF.
    ENDIF.

**Consolidation COA Validation
    IF <ls_item>-consolidationcoaforedit IS INITIAL.

      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                           msgno = 009
                                                           msgv1 = TEXT-001
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_item>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_FS_ITEM-consolidationcoaforedit
                                         iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_item>-key ) TO et_failed_key.
    ELSE.
      SELECT SINGLE itclg FROM tf120 INTO @DATA(ls_itclg) WHERE itclg = @<ls_item>-consolidationcoaforedit ##NEEDED.
        IF sy-subrc IS NOT INITIAL.

          eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                               msgno = 010
                                                               msgv1 = TEXT-001
                                                               msgty = /bobf/cm_frw=>co_severity_error )
                                              iv_node = is_ctx-node_key
                                              iv_key  = <ls_item>-key
                                              iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_FS_ITEM-consolidationcoaforedit
                                              iv_lifetime  = lv_lifetime ).
           APPEND VALUE #( key = <ls_item>-key ) TO et_failed_key.
         ENDIF.
    ENDIF.
    CLEAR lv_lifetime.
  ENDLOOP.
  ENDMETHOD.
ENDCLASS.

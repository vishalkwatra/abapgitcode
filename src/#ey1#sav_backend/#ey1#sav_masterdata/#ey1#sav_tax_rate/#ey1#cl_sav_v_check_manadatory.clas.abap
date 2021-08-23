class /EY1/CL_SAV_V_CHECK_MANADATORY definition
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



CLASS /EY1/CL_SAV_V_CHECK_MANADATORY IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

**Typed with node's combined table type
  DATA: lt_header_data TYPE /EY1/T_SAV_I_CTR_TAX_RATE,
        lt_value_tab   TYPE TABLE OF dd07v,
        lv_lifetime    TYPE /bobf/cm_frw=>ty_message_lifetime.

  FIELD-SYMBOLS: <fs_value_tab> TYPE dd07v.

**Retrieve the data of the requested node instance
  io_read->retrieve(
  EXPORTING
    iv_node         = is_ctx-node_key
    it_key          = it_key
  IMPORTING
    et_data         = lt_header_data
    eo_message      = eo_message
    et_failed_key   = et_failed_key ).

  eo_message = /bobf/cl_frw_factory=>get_message( ).

  LOOP AT lt_header_data ASSIGNING FIELD-SYMBOL(<ls_header>).
    IF <ls_header>-isactiveentity = abap_false.
      lv_lifetime = /bobf/cm_frw=>co_lifetime_state.         "draft
    ELSE.
      lv_lifetime = /bobf/cm_frw=>co_lifetime_transition.    "active
    ENDIF.

    IF <ls_header>-current_tax_rateforedit IS INITIAL.
*     Mandatory field &1 must be filled
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                           msgno = 009
                                                           msgv1 = TEXT-004 "Current Tax Rate
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node      = is_ctx-node_key
                                         iv_key       = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-current_tax_rateforedit
                                         iv_lifetime  = lv_lifetime ).

     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ENDIF.

    IF <ls_header>-intentionforedit IS INITIAL.
*     Mandatory field &1 must be filled
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                           msgno = 009
                                                           msgv1 = TEXT-003 "Intention
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node      = is_ctx-node_key
                                         iv_key       = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-intentionforedit
                                         iv_lifetime  = lv_lifetime ).

     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ELSE.
**Get Domain values
     SELECT IntentionDomVal FROM /EY1/I_ReadIntentVH INTO TABLE @DATA(zt_dom_val). "#EC CI_NOWHERE.
     READ TABLE zt_dom_val ASSIGNING FIELD-SYMBOL(<fs_dom_val>)
     WITH KEY IntentionDomVal = <ls_header>-intentionforedit.

     IF sy-subrc IS NOT INITIAL.
*      Enter Valid value for &1
       eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                            msgno = 010
                                                            msgv1 = TEXT-006 "Intention
                                                            msgty = /bobf/cm_frw=>co_severity_error )
                                          iv_node = is_ctx-node_key
                                          iv_key  = <ls_header>-key
                                          iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-intentionforedit
                                          iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
     ENDIF.
    ENDIF.

    IF <ls_header>-gjahrforedit IS INITIAL.
*     Mandatory field &1 must be filled
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                           msgno = 009
                                                           msgv1 = TEXT-002 "Fiscal Year
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node      = is_ctx-node_key
                                         iv_key       = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-gjahrforedit
                                         iv_lifetime  = lv_lifetime ).

     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ENDIF.


    FIND ALL OCCURRENCES OF REGEX '[^0-9]+' IN <ls_header>-gjahrforedit MATCH COUNT DATA(mcnt).

    IF sy-subrc IS INITIAL OR strlen( <ls_header>-gjahrforedit ) <> 4.
*     Please correct the year format: &1
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                           msgno = 020
                                                           msgv1 = <ls_header>-gjahrforedit "Fiscal Year
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node      = is_ctx-node_key
                                         iv_key       = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-gjahrforedit
                                         iv_lifetime  = lv_lifetime ).

     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ENDIF.

    IF <ls_header>-rbunitforedit IS INITIAL.
*     Mandatory field &1 must be filled
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                           msgno = 009
                                                           msgv1 = TEXT-001 "Consolidation Unit
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node      = is_ctx-node_key
                                         iv_key       = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-rbunitforedit
                                         iv_lifetime  = lv_lifetime ).

     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ELSE.
      SELECT SINGLE bunit FROM tf160 INTO @DATA(ls_rbunit) WHERE bunit = @<ls_header>-rbunitforedit. "#EC CI_GENBUFF
        IF sy-subrc IS NOT INITIAL.
*         Enter Valid value for &1
          eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                               msgno = 010
                                                               msgv1 = TEXT-005  "Consolidation Unit
                                                               msgty = /bobf/cm_frw=>co_severity_error )
                                              iv_node      = is_ctx-node_key
                                              iv_key       = <ls_header>-key
                                              iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-rbunitforedit
                                              iv_lifetime  = lv_lifetime ).
           APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
         ENDIF.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.
ENDCLASS.

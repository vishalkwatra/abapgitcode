class /EY1/CL_SAV_V_CHECK_PREVS_YEAR definition
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



CLASS /EY1/CL_SAV_V_CHECK_PREVS_YEAR IMPLEMENTATION.


 METHOD /bobf/if_frw_validation~execute.
**Typed with node's combined table type
   DATA: lt_tax_rate  TYPE /EY1/T_SAV_I_CTR_TAX_RATE,
         lt_value_tab TYPE TABLE OF dd07v,
         lv_lifetime  TYPE /bobf/cm_frw=>ty_message_lifetime.

*-----------------------------------------------------------------
*   Get the data
*-----------------------------------------------------------------
   io_read->retrieve(
    EXPORTING
     iv_node         = is_ctx-node_key
     it_key          = it_key
    IMPORTING
     et_data         = lt_tax_rate
     eo_message      = eo_message
     et_failed_key   = et_failed_key ).

   eo_message = /bobf/cl_frw_factory=>get_message( ).

*-----------------------------------------------------------------
*   Processing the objects
*-----------------------------------------------------------------
   LOOP AT lt_tax_rate ASSIGNING FIELD-SYMBOL(<ls_tax_rate>).
*   Checking object state
     IF <ls_tax_rate>-isactiveentity = abap_false.
       lv_lifetime = /bobf/cm_frw=>co_lifetime_state.         "draft
     ELSE.
       lv_lifetime = /bobf/cm_frw=>co_lifetime_transition.    "active
     ENDIF.

*-----------------------------------------------------------------
*   Check if record already esist
*-----------------------------------------------------------------
     FIND ALL OCCURRENCES OF REGEX '[^0-9]+' IN <ls_tax_rate>-gjahrforedit MATCH COUNT DATA(dum).

     IF sy-subrc <> 0.
       IF <ls_tax_rate>-rbunitforedit IS NOT INITIAL AND <ls_tax_rate>-gjahrforedit IS NOT INITIAL
          AND <ls_tax_rate>-intentionforedit IS NOT INITIAL.

         DATA(l_var_yearback) = <ls_tax_rate>-gjahrforedit - 1.

         SELECT SINGLE rbunit FROM /EY1/SAV_I_CTR_TAX_RATE INTO @DATA(l_str_rbunit)
             WHERE rbunit = @<ls_tax_rate>-rbunitforedit AND gjahr = @l_var_yearback
               AND intention = @<ls_tax_rate>-intentionforedit.

         IF sy-subrc <> 0.

*        Please maintain GAAP CB and STAT CB DT Rate for previous Fiscal Year.
           eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                                msgno = 018
                                                                msgty = /bobf/cm_frw=>co_severity_warning )
                                              iv_node      = is_ctx-node_key
                                              iv_key       = <ls_tax_rate>-key
                                              iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-gjahrforedit
                                              iv_lifetime  = lv_lifetime ).

         ENDIF.

         SELECT SINGLE rbunit FROM /EY1/SAV_I_CTR_TAX_RATE INTO @DATA(l_str_rb)
             WHERE rbunit = @<ls_tax_rate>-rbunitforedit AND gjahr = @<ls_tax_rate>-gjahrforedit
               AND intention = @<ls_tax_rate>-intentionforedit.

         IF sy-subrc = 0 AND <ls_tax_rate>-hasactiveentity = abap_false.

*        Entry already exist in database table.
           eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                                msgno = 019
                                                                msgty = /bobf/cm_frw=>co_severity_error )
                                              iv_node      = is_ctx-node_key
                                              iv_key       = <ls_tax_rate>-key
                                              iv_attribute = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node_attribute-/EY1/SAV_I_CTR_TAX_RATE-gjahrforedit
                                              iv_lifetime  = lv_lifetime ).

           APPEND VALUE #( key = <ls_tax_rate>-key ) TO et_failed_key.
         ENDIF.
       ENDIF.
     ENDIF.
   ENDLOOP.

 ENDMETHOD.
ENDCLASS.

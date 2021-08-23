class /EY1/CL_SAV_V_CHECK_MANDATORY definition
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



CLASS /EY1/CL_SAV_V_CHECK_MANDATORY IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

**Typed with node's combined table type
  DATA: lt_header_data TYPE /EY1/T_SAV_I_ACC_CLASS,
        lt_value_tab   TYPE TABLE OF dd07v,
        lv_lifetime    TYPE /bobf/cm_frw=>ty_message_lifetime.

  FIELD-SYMBOLS: <fs_value_tab> TYPE dd07v.

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

  eo_message = /bobf/cl_frw_factory=>get_message( ).

  LOOP AT lt_header_data ASSIGNING FIELD-SYMBOL(<ls_header>).
    IF <ls_header>-isactiveentity = abap_false.
      lv_lifetime = /bobf/cm_frw=>co_lifetime_state.         "draft
    ELSE.
      lv_lifetime = /bobf/cm_frw=>co_lifetime_transition.    "active
    ENDIF.

    IF <ls_header>-debitcreditindicator  IS INITIAL.
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                           msgno = 009
                                                           msgv1 = TEXT-005
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-debitcreditindicator
                                         iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
   ELSE.
**Get Domain values
     CALL FUNCTION 'GET_DOMAIN_VALUES'
       EXPORTING
         domname         = 'SHKZG'
         text            = 'X'
       TABLES
        values_tab       = lt_value_tab
       EXCEPTIONS
        no_values_found  = 1
        OTHERS           = 2 .
     IF sy-subrc <> 0.
* Implement suitable error handling here
     ENDIF.

     READ TABLE lt_value_tab ASSIGNING <fs_value_tab>
     WITH KEY domvalue_l = <ls_header>-debitcreditindicator.
     IF sy-subrc IS NOT INITIAL.
       eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                            msgno = 010
                                                            msgv1 = TEXT-005
                                                            msgty = /bobf/cm_frw=>co_severity_error )
                                          iv_node = is_ctx-node_key
                                          iv_key  = <ls_header>-key
                                          iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-debitcreditindicator
                                          iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
     ENDIF.
     CLEAR lt_value_tab.
     UNASSIGN <fs_value_tab>.
   ENDIF.

    IF <ls_header>-bseqpl IS INITIAL.
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                           msgno = 009
                                                           msgv1  = TEXT-004
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-bseqpl
                                         iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ELSE.
**Get Domain values
     CALL FUNCTION 'GET_DOMAIN_VALUES'
       EXPORTING
         domname        = '/EY1/SAV_BSEQPL'
         text           = 'X'
       TABLES
        values_tab      = lt_value_tab
       EXCEPTIONS
        no_values_found = 1
        OTHERS          = 2 .
     IF sy-subrc <> 0.
* Implement suitable error handling here
     ENDIF.

     READ TABLE lt_value_tab ASSIGNING <fs_value_tab>
     WITH KEY domvalue_l = <ls_header>-bseqpl.
     IF sy-subrc IS NOT INITIAL.
       eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                            msgno = 010
                                                            msgv1 = TEXT-004
                                                            msgty = /bobf/cm_frw=>co_severity_error )
                                          iv_node = is_ctx-node_key
                                          iv_key  = <ls_header>-key
                                          iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-bseqpl
                                          iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
     ENDIF.
     CLEAR lt_value_tab.
     UNASSIGN <fs_value_tab>.
    ENDIF.

    IF <ls_header>-bseqpl EQ 'BS' AND <ls_header>-currentnoncurrent  IS INITIAL.
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                           msgno = 009
                                                           msgv1 = TEXT-003
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                         iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ELSEIF <ls_header>-bseqpl EQ 'BS' AND <ls_header>-currentnoncurrent IS NOT INITIAL.
**Get Domain values
     CALL FUNCTION 'GET_DOMAIN_VALUES'
       EXPORTING
         domname        = '/EY1/SAV_CNC'
         text           = 'X'
       TABLES
        values_tab      = lt_value_tab
       EXCEPTIONS
        no_values_found = 1
        OTHERS          = 2 .
     IF sy-subrc <> 0.
* Implement suitable error handling here
     ENDIF.

     READ TABLE lt_value_tab ASSIGNING <fs_value_tab>
     WITH KEY domvalue_l = <ls_header>-currentnoncurrent.
     IF sy-subrc IS NOT INITIAL.
       eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                            msgno = 010
                                                            msgv1 = TEXT-003
                                                            msgty = /bobf/cm_frw=>co_severity_error )
                                          iv_node = is_ctx-node_key
                                          iv_key  = <ls_header>-key
                                          iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-currentnoncurrent
                                          iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
     ENDIF.
     CLEAR lt_value_tab.
     UNASSIGN <fs_value_tab>.
    ENDIF.

    IF <ls_header>-accountclasscodetext IS INITIAL.
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                           msgno = 009
                                                           msgv1 = TEXT-002
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-accountclasscodetext
                                         iv_lifetime  = lv_lifetime ).
     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ENDIF.

    IF <ls_header>-accountclasscodeforedit  IS INITIAL.
      eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                           msgno = 009
                                                           msgv1 = TEXT-001
                                                           msgty = /bobf/cm_frw=>co_severity_error )
                                         iv_node = is_ctx-node_key
                                         iv_key  = <ls_header>-key
                                         iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-accountclasscodeforedit
                                         iv_lifetime  = lv_lifetime ).

     APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
    ELSE.
      IF <ls_header>-hasactiveentity = abap_false.
       SELECT SINGLE acc_class_code FROM /EY1/ACCNT_CLASS INTO @DATA(ls_code) ##NEEDED
        WHERE acc_class_code = @<ls_header>-accountclasscodeforedit.
        IF sy-subrc IS INITIAL.
           eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = lv_msg_id
                                                                msgno = 011
                                                                msgv1 = <ls_header>-accountclasscodeforedit
                                                                msgty = /bobf/cm_frw=>co_severity_error )
                                              iv_node = is_ctx-node_key
                                              iv_key  = <ls_header>-key
                                              iv_attribute = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node_attribute-/EY1/SAV_I_ACC_CLASS-accountclasscodeforedit
                                              iv_lifetime  = lv_lifetime ).

          APPEND VALUE #( key = <ls_header>-key ) TO et_failed_key.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDMETHOD.
ENDCLASS.

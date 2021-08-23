class /EY1/CL_DR_SAV_I_ACC_CLASS definition
  public
  inheriting from /BOBF/CL_LIB_DR_CLASSIC_APP
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DRAFT~COPY_DRAFT_TO_ACTIVE_ENTITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_DR_SAV_I_ACC_CLASS IMPLEMENTATION.


  METHOD /bobf/if_frw_draft~copy_draft_to_active_entity.

    DATA: lr_active_key   TYPE REF TO data,
          lt_header_data  TYPE /EY1/T_SAV_I_ACC_CLASS,
          lt_item_data    TYPE /EY1/T_SAV_I_ACC_FS_ITEM,
          ls_msg          TYPE symsg ##NEEDED,
          lo_message      TYPE REF TO /bobf/if_frw_message ##NEEDED,
          lt_acc_class    TYPE STANDARD TABLE OF /EY1/ACCNT_CLASS,
          ls_acc          TYPE /EY1/ACCNT_CLASS,
          ls_item         TYPE /EY1/FS_ITEM,
          lt_fs_item      TYPE STANDARD TABLE OF /EY1/FS_ITEM,
          lv_acc          TYPE /EY1/SAV_ACCOUNT_CLASS_CODE,
          lv_desc         TYPE /EY1/SAV_ACC_TXT,
          ls_text         TYPE /EY1/ACC_TXT_TAB,
          lt_text         TYPE STANDARD TABLE OF /EY1/ACC_TXT_TAB,
          lv_success      TYPE char1,
          lv_error        TYPE char1.

**Initialize BOPF configuration
  TRY.
    DATA(lo_conf) = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = is_ctx-bo_key ).
  CATCH /bobf/cx_frw ##NO_HANDLER.
  ENDTRY.

  DATA(lr_key_util) = /bobf/cl_lib_legacy_key=>get_instance( /EY1/IF_SAV_I_ACC_CLASS_C=>sc_bo_key ) ##NEEDED.

  TRY.
   /bobf/cl_lib_enqueue_context=>get_instance( )->attach( iv_draft_key = VALUE #( it_draft_key[ 1 ]-key ) ).
  CATCH /bobf/cx_frw_core ##NO_HANDLER.
   "need to handlle it
  ENDTRY.

**Read header data with the given keys
  io_read->retrieve(
    EXPORTING
      iv_node       = is_ctx-node_key                 " uuid of node name
      it_key        = it_draft_key                    " keys given to the determination
    IMPORTING
      eo_message    = eo_message                      " pass message object
      et_data       = lt_header_data                  " itab with node data
      et_failed_key = et_failed_draft_key ).          " pass failures

**Read item data with the given keys
  io_read->retrieve_by_association(
    EXPORTING
      iv_node                 = is_ctx-node_key
      it_key                  = it_draft_key
      iv_association          = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_association-/EY1/SAV_I_ACC_CLASS-_finstatitem
      iv_fill_data            = abap_true
    IMPORTING
      eo_message              = eo_message
      et_data                 = lt_item_data
      et_failed_key           = et_failed_draft_key ).

**Create a message container
      eo_message = /bobf/cl_frw_message_factory=>create_container( ).

**Check Duplicate FS item entries
  DATA(lt_duplicate) = lt_item_data[].
  DESCRIBE TABLE lt_item_data LINES DATA(lv_var1).
  SORT lt_duplicate ASCENDING BY consolidationcoaforedit financialstatementitemforedit.
  DELETE ADJACENT DUPLICATES FROM lt_duplicate COMPARING consolidationcoaforedit financialstatementitemforedit.
  DESCRIBE TABLE lt_duplicate LINES DATA(lv_var2).

  IF lv_var1 <> lv_var2.                                                            "Check for duplicate FS entries
    DATA : lv_var TYPE int3 VALUE '000'.
    LOOP AT lt_duplicate ASSIGNING FIELD-SYMBOL(<fs_dup>).
      LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_itm>) WHERE consolidationcoaforedit        = <fs_dup>-consolidationcoaforedit
                                                              AND financialstatementitemforedit  = <fs_dup>-financialstatementitemforedit.
        lv_var = lv_var + 1.
      ENDLOOP.
      IF lv_var > 1 .
**Add new messages to the message container
        eo_message->add_message( EXPORTING is_msg  =  VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                               msgno = 013
                                                               msgv1 = <fs_dup>-financialstatementitemforedit
                                                               msgv2 = <fs_dup>-consolidationcoaforedit
                                                               msgty = 'E' )
                                           iv_node =  /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_FS_ITEM                " Node to be used in the origin location
                                           iv_key  = lt_item_data[ 1 ]-root_key )    ##OPERATOR[LT_ITEM_DATA].   " Instance key to be used in the origin location
        et_failed_draft_key = it_draft_key.
      ENDIF.
      CLEAR lv_var.
      ENDLOOP.

      TRY.
       /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
      CATCH /bobf/cx_frw_core                                         ##NO_HANDLER.
        "need to handlle it
      ENDTRY.
  ELSE.
    READ TABLE lt_header_data ASSIGNING FIELD-SYMBOL(<fs_header>) INDEX 1.
**Create Entry in database table
    IF <fs_header>-hasactiveentity = abap_false.
**Create Entry in '/EY1/ACCNT_CLASS' table
      <fs_header>-accountclasscode = <fs_header>-accountclasscodeforedit.
      lv_acc                       = <fs_header>-accountclasscodeforedit.
      lv_desc                      = <fs_header>-accountclasscodetext.
      ls_acc-acc_class_code        = <fs_header>-accountclasscodeforedit.
      ls_acc-bl_eq_pl              = <fs_header>-bseqpl.
      ls_acc-cnc                   = <fs_header>-currentnoncurrent.
      ls_acc-profit                = <fs_header>-profitbeforetax.
      ls_acc-tax_effect            = <fs_header>-taxeffected.
      ls_acc-transaction_type      = <fs_header>-debitcreditindicator.
      APPEND ls_acc TO lt_acc_class.
      CLEAR ls_acc.

      io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                   iv_key  = it_draft_key[ 1 ]-key           ##OPERATOR[IT_DRAFT_KEY]
                                   is_data = REF #( lt_header_data[ 1 ] ) ).

      INSERT /EY1/ACCNT_CLASS FROM TABLE lt_acc_class.
      IF sy-subrc IS NOT INITIAL.
        lv_error = abap_true.
      ELSE.
**Create entry in Text Table
        ls_text-account_classcode  = lv_acc.
        ls_text-spras              = sy-langu.
        ls_text-acc_txt            = lv_desc.
        APPEND ls_text TO lt_text.
        CLEAR: ls_text, lv_desc.

        INSERT /EY1/ACC_TXT_TAB FROM TABLE lt_text.
        CLEAR lt_text.
        IF sy-subrc IS INITIAL.
**Insert new entries in /EY1/FS_ITEM table
            IF lt_item_data IS NOT INITIAL.
              LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_item>).
                <fs_item>-accountclasscode              = lv_acc.
                <fs_item>-consolidationchartofaccounts  = <fs_item>-consolidationcoaforedit.
                <fs_item>-financialstatementitem        = <fs_item>-financialstatementitemforedit.
                ls_item-account_classcode               = <fs_item>-accountclasscode.
                ls_item-itclg                           = <fs_item>-consolidationcoaforedit.
                ls_item-item                            = <fs_item>-financialstatementitemforedit.
                APPEND ls_item TO lt_fs_item.
                CLEAR ls_item.
              ENDLOOP.
              CLEAR lv_acc.
              UNASSIGN <fs_item>.

              io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                           iv_key  = it_draft_key[ 1 ]-key        ##OPERATOR[IT_DRAFT_KEY]
                                           is_data = REF #( lt_item_data[ 1 ] ) ).
              INSERT /EY1/FS_ITEM FROM TABLE lt_fs_item.
              IF sy-subrc IS INITIAL.
                lv_success = abap_true.
              ELSE.
                lv_error = abap_true.
              ENDIF.
            ELSE.
              lv_success = abap_true.
            ENDIF.
        ELSE.
          lv_error = abap_true.
        ENDIF.
      ENDIF.

      IF lv_success = abap_true.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                             msgno = '005'
                                                             msgty = 'S' )
                                                 iv_node =  /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS                     " Node to be used in the origin location
                                                 iv_key       =  lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA]. " Instance key to be used in the origin location
      ENDIF.
      CLEAR lv_success.
      IF lv_error = abap_true.
        eo_message->add_message( EXPORTING is_msg  =  VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                               msgno = '006'
                                                               msgty = 'E' )
                                           iv_node =  /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS                " Node to be used in the origin location
                                           iv_key  = lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA].  " Instance key to be used in the origin location
        et_failed_draft_key = it_draft_key.
        TRY.
          /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
        CATCH /bobf/cx_frw_core                                         ##NO_HANDLER.
          "need to handlle it
        ENDTRY.
        RETURN.
      ENDIF.
    ENDIF.

**Entry update in database tables
    IF <fs_header>-hasactiveentity = abap_true.
**Entry update in '/EY1/ACCNT_CLASS' table
      ls_acc-acc_class_code        = <fs_header>-accountclasscodeforedit.
      ls_acc-bl_eq_pl              = <fs_header>-bseqpl.
      ls_acc-cnc                   = <fs_header>-currentnoncurrent.
      ls_acc-profit                = <fs_header>-profitbeforetax.
      ls_acc-tax_effect            = <fs_header>-taxeffected.
      ls_acc-transaction_type      = <fs_header>-debitcreditindicator.
      APPEND ls_acc TO lt_acc_class.
      CLEAR ls_acc.

      io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                   iv_key  = it_draft_key[ 1 ]-key         ##OPERATOR[IT_DRAFT_KEY]
                                   is_data = REF #( lt_header_data[ 1 ] ) ).

      MODIFY /EY1/ACCNT_CLASS FROM TABLE lt_acc_class.
      IF sy-subrc IS INITIAL.
"Entry update in text table
        ls_text-account_classcode  = <fs_header>-accountclasscode.
        ls_text-spras              = sy-langu.
        ls_text-acc_txt            = <fs_header>-accountclasscodetext.
        APPEND ls_text TO lt_text.
        MODIFY /EY1/ACC_TXT_TAB FROM TABLE lt_text.
        CLEAR lt_text.
        IF sy-subrc IS INITIAL.

**Entry update in '/EY1/FS_ITEM' table
          SELECT * FROM /EY1/FS_ITEM INTO TABLE @DATA(lt_fsitem)             "#EC CI_ALL_FIELDS_NEEDED
          WHERE account_classcode = @<fs_header>-accountclasscode        ##NEEDED.
          IF sy-subrc IS INITIAL.
            DELETE FROM /EY1/FS_ITEM WHERE account_classcode = <fs_header>-accountclasscode.
          ENDIF.

          IF lt_item_data IS NOT INITIAL.
            LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_item1>).
              <fs_item1>-accountclasscode              = <fs_item1>-accountclasscode ##NEEDED.
              <fs_item1>-consolidationchartofaccounts  = <fs_item1>-consolidationcoaforedit.
              <fs_item1>-financialstatementitem        = <fs_item1>-financialstatementitemforedit.
                ls_item-account_classcode              = <fs_item1>-accountclasscode.
                ls_item-itclg                          = <fs_item1>-consolidationcoaforedit.
                ls_item-item                           = <fs_item1>-financialstatementitemforedit.
              APPEND ls_item TO lt_fs_item.
              CLEAR ls_item.
            ENDLOOP.

            io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                         iv_key  = it_draft_key[ 1 ]-key        ##OPERATOR[IT_DRAFT_KEY]
                                         is_data = REF #( lt_item_data[ 1 ] ) ).

            INSERT /EY1/FS_ITEM FROM TABLE lt_fs_item.
            IF sy-subrc IS INITIAL.
              lv_success = abap_true.
            ELSE.
              lv_error = abap_true.
            ENDIF.
          ELSE.
            lv_success = abap_true.
          ENDIF.
        ELSE.
          lv_error = abap_true.
        ENDIF.
      ELSE.
        lv_error = abap_true.
      ENDIF.
      IF lv_success = abap_true.
        eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                             msgno = '008'
                                                             msgty = 'S' )
                                           iv_node =  /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS                " Node to be used in the origin location
                                           iv_key  =  lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA]. " Instance key to be used in the origin location
      ENDIF.
      IF lv_error = abap_true.
        eo_message->add_message( EXPORTING is_msg  = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                              msgno = '007'
                                                              msgty = 'E' )
                                           iv_node =  /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS               " Node to be used in the origin location
                                           iv_key  = lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA]. " Instance key to be used in the origin location
        et_failed_draft_key = it_draft_key.
        TRY.
          /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
        CATCH /bobf/cx_frw_core                                         ##NO_HANDLER.
          "need to handlle it
        ENDTRY.
        RETURN.
      ENDIF.
    ENDIF.

**Get key structure for active object
  lo_conf->get_altkey( EXPORTING iv_node_key    = is_ctx-node_key
                                 iv_altkey_name = /bobf/if_conf_cds_link_c=>gc_alternative_key_name-draft-active_entity_key
                       IMPORTING es_altkey      = DATA(ls_altkey_active_key) ).

   CREATE DATA lr_active_key TYPE (ls_altkey_active_key-data_type).
   ASSIGN lr_active_key->* TO FIELD-SYMBOL(<fs_active_entity_key>).

   ASSIGN COMPONENT 'ACCOUNTCLASSCODE' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_acc_class>).
   <fs_acc_class> = lt_header_data[ 1 ]-accountclasscodeforedit.

*   Map the active key structure to a GUID key
      DATA(lo_dac_map) = /bobf/cl_dac_legacy_mapping=>get_instance( iv_bo_key = is_ctx-bo_key
                                                                    iv_node_key = is_ctx-node_key ).
      lo_dac_map->map_key_to_bopf( EXPORTING ir_database_key = lr_active_key
                                   IMPORTING es_bopf_key     = DATA(ls_key) ).

      INSERT VALUE #( active = ls_key-key draft = it_draft_key[ 1 ]-key ) INTO TABLE et_key_link.

      TRY.
          /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
        CATCH /bobf/cx_frw_core ##NO_HANDLER.
          "need to handlle it
      ENDTRY.
    CLEAR : lt_header_data, lt_item_data, lt_acc_class, lt_fs_item.
    ENDIF.
 ENDMETHOD.
ENDCLASS.

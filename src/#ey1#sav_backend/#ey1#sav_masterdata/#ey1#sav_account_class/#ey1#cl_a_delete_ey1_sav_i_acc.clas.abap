class /EY1/CL_A_DELETE_EY1_SAV_I_ACC definition
  public
  inheriting from /BOBF/CL_LIB_A_DELETE_ACTIVE
  final
  create public .

public section.

  methods /BOBF/IF_LIB_DELETE_ACTIVE~DELETE_ACTIVE_ENTITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_A_DELETE_EY1_SAV_I_ACC IMPLEMENTATION.


  METHOD /bobf/if_lib_delete_active~delete_active_entity.

    DATA: lr_database_keys TYPE REF TO data,
          ls_msg           TYPE  symsg.

    FIELD-SYMBOLS: <ft_database_keys> TYPE /EY1/T_K_SAV_I_ACC_CLASS_ACTIV,
                   <fs_database_key>  TYPE /EY1/T_K_SAV_I_ACC_CLASS_ACTIV ##NEEDED.

    CONSTANTS: lv_msgid  TYPE string VALUE '/EY1/SAV_SAVOTTA',
               lv_msgtyp TYPE char1  VALUE 'S'.

* Get BOPF configuration
    TRY.
      DATA(lo_conf) = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = is_ctx-bo_key ).
    CATCH /bobf/cx_frw ##NO_HANDLER.
    ENDTRY.
    lo_conf->get_node( EXPORTING iv_node_key = is_ctx-node_key    ##NEEDED
                       IMPORTING es_node     = DATA(ls_node_conf) ).

* Get key structure for active object
    lo_conf->get_altkey(
       EXPORTING
        iv_node_key    = is_ctx-node_key
        iv_altkey_name = /bobf/if_conf_cds_link_c=>gc_alternative_key_name-draft-active_entity_key
       IMPORTING
        es_altkey      = DATA(ls_altkey_active_key) ).


    CREATE DATA lr_database_keys TYPE (ls_altkey_active_key-data_table_type).
    ASSIGN lr_database_keys->* TO <ft_database_keys>.

* Map the GUID key to actual database key
    DATA(lo_dac_map) = /bobf/cl_dac_legacy_mapping=>get_instance( iv_bo_key = is_ctx-bo_key
                                                                  iv_node_key = is_ctx-node_key ).

    lo_dac_map->map_keys_to_database(
      EXPORTING
        it_bopf_key_table     = it_key
      IMPORTING
        et_database_key_table = <ft_database_keys> ).

**Create message object
    eo_message = /bobf/cl_frw_factory=>get_message( ).

      IF <ft_database_keys> IS NOT INITIAL.
        SELECT * FROM /EY1/ACCNT_CLASS INTO TABLE @DATA(lt_acc)
          FOR ALL ENTRIES IN @<ft_database_keys> WHERE acc_class_code = @<ft_database_keys>-accountclasscode.
          IF sy-subrc IS INITIAL.
            SELECT * FROM /EY1/ACC_TXT_TAB INTO TABLE @DATA(lt_text) "#EC CI_NO_TRANSFORM
              FOR ALL ENTRIES IN @lt_acc WHERE account_classcode = @lt_acc-acc_class_code.
              IF sy-subrc IS INITIAL.
              ENDIF.
                SELECT * FROM /EY1/FS_ITEM INTO TABLE @DATA(lt_fsitem) "#EC CI_NO_TRANSFORM
                 FOR ALL ENTRIES IN @lt_acc WHERE account_classcode = @lt_acc-acc_class_code.
                  IF sy-subrc IS INITIAL.
                    DATA(lv_flag) = abap_true.
                  ENDIF.
          ENDIF.
      ELSE.
       et_failed_key = it_key.
       RETURN.
      ENDIF.

      DELETE /EY1/ACCNT_CLASS FROM TABLE lt_acc.
      IF sy-subrc IS INITIAL.
        DELETE /EY1/ACC_TXT_TAB FROM TABLE lt_text.
        IF sy-subrc IS INITIAL.
          IF lv_flag = abap_true.
            DELETE /EY1/FS_ITEM FROM TABLE lt_fsitem.
            IF sy-subrc IS INITIAL.
              ls_msg-msgid = lv_msgid.
              ls_msg-msgno = '004'.
              ls_msg-msgty = lv_msgtyp.
              eo_message->add_message( EXPORTING is_msg  =  ls_msg ).              " Message that is to be added to the message object
            ENDIF.
            ELSE.
              ls_msg-msgid = lv_msgid.
              ls_msg-msgno = '004'.
              ls_msg-msgty = lv_msgtyp.
              eo_message->add_message( EXPORTING is_msg  =  ls_msg ).              " Message that is to be added to the message object
          ENDIF.
        ENDIF.
      ELSE.
       et_failed_key = it_key.
      ENDIF.
  ENDMETHOD.
ENDCLASS.

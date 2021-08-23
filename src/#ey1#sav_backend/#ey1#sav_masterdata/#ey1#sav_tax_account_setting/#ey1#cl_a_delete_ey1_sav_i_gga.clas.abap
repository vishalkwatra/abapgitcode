class /EY1/CL_A_DELETE_EY1_SAV_I_GGA definition
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



CLASS /EY1/CL_A_DELETE_EY1_SAV_I_GGA IMPLEMENTATION.


  METHOD /bobf/if_lib_delete_active~delete_active_entity.

**Data Declarations
    DATA: lr_database_keys TYPE REF TO data,
          ls_msg           TYPE  symsg.

**Field Symbol Declaration
    FIELD-SYMBOLS: <ft_database_keys> TYPE /ey1/t_k_sav_i_ggaap_tas_activ,
                   <fs_database_key>  TYPE /ey1/s_k_sav_i_ggaap_tas_activ ##NEEDED.

**Constant Declaration
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
        SELECT * FROM /ey1/ggaap_tas INTO TABLE @DATA(lt_ggaap)
          FOR ALL ENTRIES IN @<ft_database_keys> WHERE rcongr = @<ft_database_keys>-consolidationgroup.
          IF sy-subrc IS INITIAL.
            SELECT * FROM /ey1/sgaap_tas INTO TABLE @DATA(lt_sgaap) "#EC CI_NO_TRANSFORM
              FOR ALL ENTRIES IN @lt_ggaap WHERE rcongr = @lt_ggaap-rcongr.
              IF sy-subrc IS INITIAL.
                DATA(lv_flag) = abap_true.
              ENDIF.
          ENDIF.
      ELSE.
       et_failed_key = it_key.
       RETURN.
      ENDIF.

      DELETE /ey1/ggaap_tas FROM TABLE lt_ggaap.
      IF sy-subrc IS INITIAL.
        IF lv_flag = abap_true.
          DELETE /ey1/sgaap_tas FROM TABLE lt_sgaap.
          IF sy-subrc IS INITIAL.
           ls_msg-msgid = lv_msgid.
           ls_msg-msgno = '004'.                                                "Entry Deleted from Database table successfully
           ls_msg-msgty = lv_msgtyp.
           eo_message->add_message( EXPORTING is_msg  =  ls_msg ).              "Message that is to be added to the message object
          ENDIF.
        ELSE.
         ls_msg-msgid = lv_msgid.
         ls_msg-msgno = '004'.                                                  "Entry Deleted from Database table successfully
         ls_msg-msgty = lv_msgtyp.
         eo_message->add_message( EXPORTING is_msg  =  ls_msg ).                "Message that is to be added to the message object
        ENDIF.
      ELSE.
       et_failed_key = it_key.
      ENDIF.
  ENDMETHOD.
ENDCLASS.

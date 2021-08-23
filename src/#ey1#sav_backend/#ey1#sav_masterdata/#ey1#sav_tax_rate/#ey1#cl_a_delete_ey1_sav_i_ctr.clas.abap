class /EY1/CL_A_DELETE_EY1_SAV_I_CTR definition
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



CLASS /EY1/CL_A_DELETE_EY1_SAV_I_CTR IMPLEMENTATION.


  METHOD /bobf/if_lib_delete_active~delete_active_entity.

*   Data Declaration
    DATA: lr_database_keys TYPE REF TO data,
          ls_msg           TYPE  symsg.

*   Field Symbol Declaration
    FIELD-SYMBOLS: <ft_database_keys> TYPE /EY1/T_K_SAV_I_CTR_TAX_RATE_AC,
                   <fs_database_key>  TYPE /EY1/S_K_SAV_I_CTR_TAX_RATE_AC.

*   Constants
    CONSTANTS: lv_msgid  TYPE string VALUE '/EY1/SAV_SAVOTTA',
               lv_msgtyp TYPE char1  VALUE 'S',
               lv_msgv1  TYPE string VALUE '/EY1/TAX_RATES'.

* Get BOPF configuration
    TRY.
      DATA(lo_conf) = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = is_ctx-bo_key ).
    CATCH /bobf/cx_frw                                                                      ##NO_HANDLER.
    ENDTRY.
    lo_conf->get_node( EXPORTING iv_node_key = is_ctx-node_key                              ##NEEDED
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

*   Get Entry Keys
    lo_dac_map->map_keys_to_database( EXPORTING it_bopf_key_table     = it_key
                                      IMPORTING et_database_key_table = <ft_database_keys> ).

*   Create message object
    eo_message = /bobf/cl_frw_factory=>get_message( ).

    IF <ft_database_keys> IS NOT INITIAL.
      SELECT * FROM /EY1/TAX_RATES INTO TABLE @DATA(lt_tax_rates)
      FOR ALL ENTRIES IN @<ft_database_keys> WHERE rbunit    = @<ft_database_keys>-rbunit
                                               AND gjahr     = @<ft_database_keys>-gjahr
                                               AND intention = @<ft_database_keys>-intention.
        IF sy-subrc IS INITIAL.
           DELETE /EY1/TAX_RATES FROM TABLE lt_tax_rates.
           IF sy-subrc IS INITIAL.
             ls_msg-msgid = lv_msgid.
             ls_msg-msgno = '003'.
             ls_msg-msgty = lv_msgtyp.
             ls_msg-msgv1 = lv_msgv1.
             eo_message->add_message( EXPORTING is_msg = ls_msg ).
           ELSE.
             et_failed_key = it_key.
           ENDIF.
        ENDIF.
    ELSE.
        et_failed_key = it_key.
        RETURN.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

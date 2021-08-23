class /EY1/CL_DR_SAV_I_CTR_TAX_RATE definition
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



CLASS /EY1/CL_DR_SAV_I_CTR_TAX_RATE IMPLEMENTATION.


  METHOD /bobf/if_frw_draft~copy_draft_to_active_entity.


    DATA: lt_tax_rates TYPE STANDARD TABLE OF /EY1/S_SAV_I_CTR_TAX_RATE.
    DATA: ls_tax_rate  TYPE /EY1/TAX_RATES.
    DATA: lt_tax_rate  TYPE STANDARD TABLE OF /EY1/TAX_RATES.
    DATA: ls_msg TYPE  symsg.
    DATA: lr_active_key TYPE REF TO data.
    DATA: lv_timestamp TYPE /EY1/SAV_CREATED_ON.

* Initialize BOPF configuration
    TRY.
      DATA(lo_conf) = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = is_ctx-bo_key ).
    CATCH /BOBF/CX_FRW ##NO_HANDLER.
    ENDTRY.


    DATA(lr_key_util) = /bobf/cl_lib_legacy_key=>get_instance( /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_bo_key ) ##NEEDED.

    TRY.
        /bobf/cl_lib_enqueue_context=>get_instance( )->attach( iv_draft_key = VALUE #( it_draft_key[ 1 ]-key ) ).
      CATCH /bobf/cx_frw_core ##NO_HANDLER.
        "need to handlle it
    ENDTRY.

    io_read->retrieve(
      EXPORTING
        iv_node                 =  is_ctx-node_key                " Node Name
        it_key                  =  it_draft_key                " Key Table
      IMPORTING
        eo_message              =  eo_message "DATA(lo_message)                 " Message Object
        et_data                 =  lt_tax_rates                " Data Return Structure
        et_failed_key           =  et_failed_draft_key                " Key Table
*        et_node_cat             =                  " Node Category Assignment
    ).

**Create a message container
      eo_message = /bobf/cl_frw_message_factory=>create_container( ).
          "timestampl.

    GET TIME STAMP FIELD lv_timestamp.

    LOOP AT lt_tax_rates ASSIGNING FIELD-SYMBOL(<fs_tax_rate>).
*      <fs_tax_rate>-change_in_tax_rate = <fs_tax_rate>-change_in_tax_rateforedit.
*      <fs_tax_rate>-classification = <fs_tax_rate>-classificationforedit.
*      <fs_tax_rate>-country = <fs_tax_rate>-countryforedit.
*      <fs_tax_rate>-dta_recognition = <fs_tax_rate>-dta_recognitionforedit.
      <fs_tax_rate>-gjahr = <fs_tax_rate>-gjahrforedit.
      <fs_tax_rate>-intention = <fs_tax_rate>-intentionforedit.
      <fs_tax_rate>-rbunit = <fs_tax_rate>-rbunitforedit.

      IF <fs_tax_rate>-created_by IS INITIAL.
        <fs_tax_rate>-created_by = sy-uname.
      ENDIF.

      IF <fs_tax_rate>-created_on IS INITIAL.
        <fs_tax_rate>-created_on = lv_timestamp.
      ENDIF.

      IF <fs_tax_rate>-hasactiveentity = abap_true.
        <fs_tax_rate>-changed_by = sy-uname.
        <fs_tax_rate>-changed_on = lv_timestamp.
      ENDIF.

      CLEAR lv_timestamp.
      MOVE-CORRESPONDING <fs_tax_rate> TO ls_tax_rate ##ENH_OK.
      APPEND ls_tax_rate TO lt_tax_rate.
      CLEAR ls_tax_rate.

    ENDLOOP.

    io_modify->update(
      EXPORTING
        iv_node           =  is_ctx-node_key                                    " Node
        iv_key            =  it_draft_key[ 1 ]-key  ##OPERATOR[IT_DRAFT_KEY]    " Key
        is_data           =  REF #( lt_tax_rates[ 1 ] )                         " Data
    ).


*    IF lo_message IS INITIAL.
*      lo_message = /bobf/cl_frw_factory=>get_message( ).
*    ENDIF.

    MODIFY /EY1/TAX_RATES FROM TABLE lt_tax_rate.
    IF sy-subrc IS NOT INITIAL.
      ls_msg-msgid = '/EY1/SAV_SAVOTTA'.
      ls_msg-msgno = '001'.
      ls_msg-msgty = 'E'.
      ls_msg-msgv1 = '/EY1/TAX_RATES'.

      eo_message->add_message(
        EXPORTING
          is_msg       =  ls_msg                                                         " Message that is to be added to the message object
          iv_node      =  /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE                " Node to be used in the origin location
          iv_key       = lt_tax_rates[ 1 ]-root_key       ##OPERATOR[LT_TAX_RATES]        " Instance key to be used in the origin location
*          iv_attribute =                  " Attribute to be used in the origin location
*          iv_lifetime  =                  " Lifetime of the message
      ).

      et_failed_draft_key = it_draft_key.
      TRY.
          /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
        CATCH /bobf/cx_frw_core ##NO_HANDLER.
          "need to handlle it
      ENDTRY.
      RETURN.

    ELSE.

      ls_msg-msgid = '/EY1/SAV_SAVOTTA'.
      ls_msg-msgno = '002'.
      ls_msg-msgty = 'S'.
      ls_msg-msgv1 = '/EY1/TAX_RATES'.

      eo_message->add_message(
        EXPORTING
          is_msg       =  ls_msg                                                         " Message that is to be added to the message object
          iv_node      =  /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE                " Node to be used in the origin location
          iv_key       = lt_tax_rates[ 1 ]-root_key     ##OPERATOR[LT_TAX_RATES]         " Instance key to be used in the origin location
*          iv_attribute =                  " Attribute to be used in the origin location
*          iv_lifetime  =                  " Lifetime of the message
      ).

*      DATA: ls_key_link TYPE /bobf/s_frw_key_link_act_draft.
*
*      DATA: lv_legacykey_rbunit          TYPE fc_bunit,
*            lv_legacykey_country         TYPE land1_gp,
*            lv_legacykey_gjahr           TYPE gjahr,
*            lv_legacykey_intention       TYPE zintent,
*            lv_legacykey_classification  TYPE zclassification,
*            lv_legacykey_change_tax_rate TYPE zchange_in_tax_rate,
*            lv_legacykey_dta_recog       TYPE zdta_recognition.
*
*      DATA lv_bobf_key_rbunit TYPE /bobf/conf_key.
*      DATA lv_bobf_key_country TYPE /bobf/conf_key.
*      DATA lv_bobf_key_gjahr TYPE /bobf/conf_key.
*      DATA lv_bobf_key_intention TYPE /bobf/conf_key.
*      DATA lv_bobf_key_classification TYPE /bobf/conf_key.
*      DATA lv_bobf_key_change_tax_rate TYPE /bobf/conf_key.
*      DATA lv_bobf_key_dta_recog TYPE /bobf/conf_key.
*
*      lv_legacykey_rbunit = lt_tax_rates[ 1 ]-rbunitforedit.
*      lv_legacykey_country = lt_tax_rates[ 1 ]-countryforedit.
*      lv_legacykey_gjahr = lt_tax_rates[ 1 ]-gjahrforedit.
*      lv_legacykey_intention = lt_tax_rates[ 1 ]-intentionforedit.
*      lv_legacykey_classification = lt_tax_rates[ 1 ]-classificationforedit.
*      lv_legacykey_change_tax_rate = lt_tax_rates[ 1 ]-change_in_tax_rateforedit.
*      lv_legacykey_dta_recog = lt_tax_rates[ 1 ]-dta_recognitionforedit.

*      lv_bobf_key_rbunit = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                    is_legacy_key = lv_legacykey_rbunit ).

*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_rbunit.
*      INSERT ls_key_link INTO TABLE et_key_link.


*      lv_bobf_key_country = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                     is_legacy_key = lv_legacykey_country ).

*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_country.
*      INSERT ls_key_link INTO TABLE et_key_link.

*      lv_bobf_key_gjahr = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                     is_legacy_key = lv_legacykey_gjahr ).
*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_gjahr.
*      INSERT ls_key_link INTO TABLE et_key_link.



*      lv_bobf_key_intention = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                     is_legacy_key = lv_legacykey_intention ).

*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_intention.
*      INSERT ls_key_link INTO TABLE et_key_link.



*      lv_bobf_key_classification = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                     is_legacy_key = lv_legacykey_classification ).
*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_classification.
*      INSERT ls_key_link INTO TABLE et_key_link.


*      lv_bobf_key_change_tax_rate = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                     is_legacy_key = lv_legacykey_change_tax_rate ).
*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_change_tax_rate.
*      INSERT ls_key_link INTO TABLE et_key_link.


*      lv_bobf_key_dta_recog = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                     is_legacy_key = lv_legacykey_dta_recog ).
*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key_dta_recog.
*      INSERT ls_key_link INTO TABLE et_key_link.

*      DATA: lv_key TYPE string.
*      DATA: lt_bopf_key TYPE /bobf/t_frw_key.
*      DATA: ls_bopf_key LIKE LINE OF lt_bopf_key.
*      lv_key = lv_legacykey_rbunit && lv_legacykey_country && lv_legacykey_gjahr && lv_legacykey_intention && lv_legacykey_classification && lv_legacykey_change_tax_rate && lv_legacykey_dta_recog.
*
*      DATA(lv_bobf_key) = lr_key_util->convert_legacy_to_bopf_key( iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
*                                                                   is_legacy_key = lv_key ).

*      ls_bopf_key-key = is_ctx-node_key.
*      APPEND ls_bopf_key TO lt_bopf_key.
*
*      lr_key_util->convert_bopf_to_legacy_keys(
*        EXPORTING
*          iv_node_key   = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE                 " Key of BOPF node
*          it_bopf_key   = lt_bopf_key                 " BOPF keys to convert
*        IMPORTING
*          et_legacy_key = DATA(lt_legacy_key)         " Resulting legacy keys
*      ).
*
*
*
*      ls_key_link-draft  = it_draft_key[ 1 ]-key.
*      ls_key_link-active = lv_bobf_key.
*      INSERT ls_key_link INTO TABLE et_key_link.



*   Get key structure for active object
      lo_conf->get_altkey(
         EXPORTING
           iv_node_key    = is_ctx-node_key
           iv_altkey_name = /bobf/if_conf_cds_link_c=>gc_alternative_key_name-draft-active_entity_key
         IMPORTING
           es_altkey      = DATA(ls_altkey_active_key) ).

      CREATE DATA lr_active_key TYPE (ls_altkey_active_key-data_type).
      ASSIGN lr_active_key->* TO FIELD-SYMBOL(<fs_active_entity_key>).

      ASSIGN COMPONENT 'RBUNIT' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_rbunit>).
      <fs_rbunit> = lt_tax_rates[ 1 ]-rbunitforedit.
*      ASSIGN COMPONENT 'COUNTRY' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_country>).
*      <fs_country> = lt_tax_rates[ 1 ]-countryforedit.
      ASSIGN COMPONENT 'GJAHR' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_gjahr>).
      <fs_gjahr> = lt_tax_rates[ 1 ]-gjahrforedit.
      ASSIGN COMPONENT 'INTENTION' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_intention>).
      <fs_intention> = lt_tax_rates[ 1 ]-intentionforedit.
*      ASSIGN COMPONENT 'CLASSIFICATION' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_classification>).
*      <fs_classification> = lt_tax_rates[ 1 ]-classificationforedit.
*      ASSIGN COMPONENT 'CHANGE_IN_TAX_RATE' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_change_in_tax_rate>).
*      <fs_change_in_tax_rate> = lt_tax_rates[ 1 ]-change_in_tax_rateforedit.
*      ASSIGN COMPONENT 'DTA_RECOGNITION' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_dta_recognition>).
*      <fs_dta_recognition> = lt_tax_rates[ 1 ]-dta_recognitionforedit.

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

    ENDIF.

 "    eo_message = lo_message.



  ENDMETHOD.
ENDCLASS.

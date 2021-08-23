class /EY1/CL_DR_SAV_I_GGAAP_TAS definition
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



CLASS /EY1/CL_DR_SAV_I_GGAAP_TAS IMPLEMENTATION.


  METHOD /bobf/if_frw_draft~copy_draft_to_active_entity.

**Data Declaration
    DATA: lr_active_key   TYPE REF TO data,

          lo_message      TYPE REF TO /bobf/if_frw_message ##NEEDED,

          lt_header_data  TYPE /ey1/t_sav_i_ggaap_tas,
          lt_item_data    TYPE /ey1/t_sav_i_sgaap_tas,
          lt_ggaap        TYPE STANDARD TABLE OF /ey1/ggaap_tas,
          lt_sgaap        TYPE STANDARD TABLE OF /ey1/sgaap_tas,
          lt_del_tab      TYPE STANDARD TABLE OF /ey1/sgaap_tas,

          ls_msg          TYPE symsg                       ##NEEDED,
          ls_ggaap        TYPE /ey1/ggaap_tas,
          ls_sgaap        TYPE /ey1/sgaap_tas,
          ls_del_tab      TYPE /ey1/sgaap_tas,

          lv_timestamp    TYPE /ey1/sav_created_on,
          lv_success      TYPE char1,
          lv_error        TYPE char1,
          lv_flag         TYPE char1.

**Initialize BOPF configuration
    TRY.
      DATA(lo_conf) = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = is_ctx-bo_key ).
    CATCH /bobf/cx_frw  ##NO_HANDLER.
    ENDTRY.

    DATA(lr_key_util) = /bobf/cl_lib_legacy_key=>get_instance( /ey1/if_sav_i_ggaap_tas_c=>sc_bo_key ) ##NEEDED.

    TRY.
     /bobf/cl_lib_enqueue_context=>get_instance( )->attach( iv_draft_key = VALUE #( it_draft_key[ 1 ]-key ) ).
    CATCH /bobf/cx_frw_core  ##NO_HANDLER.
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
        iv_association          = /ey1/if_sav_i_ggaap_tas_c=>sc_association-/ey1/sav_i_ggaap_tas-_sgaap
        iv_fill_data            = abap_true
      IMPORTING
        eo_message              = eo_message
        et_data                 = lt_item_data
        et_failed_key           = et_failed_draft_key ).

**Create a message container
      eo_message = /bobf/cl_frw_message_factory=>create_container( ).

      READ TABLE lt_header_data ASSIGNING FIELD-SYMBOL(<fs_header>) INDEX 1.

      GET TIME STAMP FIELD lv_timestamp.

**Check Duplicate Item entries
      DATA(lt_duplicate) = lt_item_data[].
      DESCRIBE TABLE lt_item_data LINES DATA(lv_var1).
      SORT lt_duplicate ASCENDING BY consolidationunitforedit.
      DELETE ADJACENT DUPLICATES FROM lt_duplicate COMPARING consolidationunitforedit.
      DESCRIBE TABLE lt_duplicate LINES DATA(lv_var2).

      IF lv_var1 <> lv_var2.                                                                "Check for duplicate Item Entries
        DATA:lv_var TYPE int3 VALUE '000'.

        LOOP AT lt_duplicate ASSIGNING FIELD-SYMBOL(<fs_dup>).
          LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_itm>) WHERE consolidationunitforedit = <fs_dup>-consolidationunitforedit.
            lv_var = lv_var + 1.
          ENDLOOP.
          IF lv_var > 1 .
**Add new messages to the message container
          eo_message->add_message( EXPORTING is_msg  =  VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                                 msgno = 022
                                                                 msgv1 = <fs_dup>-consolidationunitforedit
                                                                 msgv2 = <fs_header>-consolidationgroupforedit
                                                                 msgty = 'E' )
                                             iv_node =  /ey1/if_sav_i_ggaap_tas_c=>sc_node-/ey1/sav_i_sgaap_tas    " Node to be used in the origin location
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
**Create Entry in database table
        IF <fs_header>-hasactiveentity = abap_false.
**Create Entry in '/EY1/GGAAP_TAS' table
          <fs_header>-consolidationgroup = <fs_header>-consolidationgroupforedit.
          ls_ggaap-rcongr                = <fs_header>-consolidationgroupforedit.
          ls_ggaap-classification        = <fs_header>-classification.
          ls_ggaap-tax_rate_change       = <fs_header>-taxratechange.
          ls_ggaap-dta_recognition       = <fs_header>-dtarecongnition.
          ls_ggaap-dtice                 = <fs_header>-dtintracompanyelimination.
          ls_ggaap-created_by            = <fs_header>-createdby.
          ls_ggaap-created_on            = <fs_header>-createdon.

          APPEND ls_ggaap TO lt_ggaap.
          CLEAR ls_ggaap.

          io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                       iv_key  = it_draft_key[ 1 ]-key           ##OPERATOR[IT_DRAFT_KEY]
                                       is_data = REF #( lt_header_data[ 1 ] ) ).

          INSERT /ey1/ggaap_tas FROM TABLE lt_ggaap.
          IF sy-subrc IS NOT INITIAL.
            lv_error = abap_true.
          ELSE.
**Insert new entries in /EY1/SGAAP_TAS table
            IF lt_item_data IS NOT INITIAL.
              LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_item>).
                ls_sgaap-rcongr          = <fs_header>-consolidationgroupforedit.
                ls_sgaap-bunit           = <fs_item>-consolidationunitforedit.
                ls_sgaap-classification  = <fs_item>-classification.
                ls_sgaap-tax_rate_change = <fs_item>-taxratechange.
                ls_sgaap-dta_recognition = <fs_item>-dtarecognition.
                ls_sgaap-dtice           = <fs_item>-dtintracompanyelimination.
                ls_sgaap-created_by      = <fs_item>-createdby.
                ls_sgaap-created_on      = <fs_item>-createdon.

                APPEND ls_sgaap TO lt_sgaap.
                CLEAR ls_sgaap.
              ENDLOOP.

              io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                           iv_key  = it_draft_key[ 1 ]-key        ##OPERATOR[IT_DRAFT_KEY]
                                           is_data = REF #( lt_item_data[ 1 ] ) ).

              INSERT /ey1/sgaap_tas FROM TABLE lt_sgaap.
              IF sy-subrc IS INITIAL.
                lv_success = abap_true.
              ELSE.
                lv_error = abap_true.
              ENDIF.
            ELSE.
              lv_success = abap_true.
            ENDIF.
          ENDIF.

          "Success Message
           IF lv_success = abap_true.
             eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                                  msgno = '005'
                                                                  msgty = 'S' )
                                                iv_node =  /ey1/if_sav_i_ggaap_tas_c=>sc_node-/ey1/sav_i_ggaap_tas     " Node to be used in the origin location
                                                iv_key  =  lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA]. " Instance key to be used in the origin location
           ENDIF.
           CLEAR lv_success.

           "Error Message
           IF lv_error = abap_true.
             eo_message->add_message( EXPORTING is_msg  =  VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                                    msgno = '006'
                                                                    msgty = 'E' )
                                                iv_node =  /ey1/if_sav_i_ggaap_tas_c=>sc_node-/ey1/sav_i_ggaap_tas     " Node to be used in the origin location
                                                iv_key  = lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA].  " Instance key to be used in the origin location
             et_failed_draft_key = it_draft_key.

             TRY.
               /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
             CATCH /bobf/cx_frw_core   ##NO_HANDLER.
               "need to handlle it
             ENDTRY.
             RETURN.
           ENDIF.
        ENDIF.

**Entry update in database tables
        IF <fs_header>-hasactiveentity = abap_true.
          SELECT SINGLE * FROM /ey1/ggaap_tas INTO @DATA(ls_data)
            WHERE rcongr =  @<fs_header>-consolidationgroupforedit.
            IF sy-subrc IS INITIAL.
              "Check if user changed anything at header level
              IF ls_data-classification <> <fs_header>-classification OR
                 ls_data-tax_rate_change <> <fs_header>-taxratechange OR
                 ls_data-dta_recognition <> <fs_header>-dtarecongnition OR
                 ls_data-dtice <> <fs_header>-dtintracompanyelimination.
                lv_flag = 'X'.
              ENDIF.
            ENDIF.
**Entry update in /EY1/GGAAP_TAS table - only when there is any change at header level
            IF lv_flag = 'X'.
              ls_ggaap-rcongr                = <fs_header>-consolidationgroupforedit.
              ls_ggaap-classification        = <fs_header>-classification.
              ls_ggaap-tax_rate_change       = <fs_header>-taxratechange.
              ls_ggaap-dta_recognition       = <fs_header>-dtarecongnition.
              ls_ggaap-dtice                 = <fs_header>-dtintracompanyelimination.
              ls_ggaap-created_by            = <fs_header>-createdby.
              ls_ggaap-created_on            = <fs_header>-createdon.
              ls_ggaap-changed_by            = <fs_header>-changedby.
              ls_ggaap-changed_on            = <fs_header>-changedon.

              APPEND ls_ggaap TO lt_ggaap.
              CLEAR ls_ggaap.

              io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                           iv_key  = it_draft_key[ 1 ]-key  ##OPERATOR[IT_DRAFT_KEY]
                                           is_data = REF #( lt_header_data[ 1 ] ) ).

              MODIFY /ey1/ggaap_tas FROM TABLE lt_ggaap.
              IF sy-subrc IS NOT INITIAL.
                lv_error = abap_true.
              ENDIF.
            ENDIF.
            CLEAR lv_flag.

**Entry update in /EY1/SGAAP_TAS table
            IF lt_item_data IS NOT INITIAL.
              SELECT * FROM /ey1/sgaap_tas INTO TABLE @DATA(lt_stat)
                WHERE rcongr = @<fs_header>-consolidationgroupforedit.
                IF sy-subrc IS INITIAL.
                  LOOP AT lt_stat ASSIGNING FIELD-SYMBOL(<fs_stat>).
                    READ TABLE lt_item_data INTO DATA(ls_data1)
                    WITH KEY consolidationunitforedit = <fs_stat>-bunit.
                    IF sy-subrc IS NOT INITIAL.
                      MOVE-CORRESPONDING <fs_stat> TO ls_del_tab.
                      APPEND ls_del_tab TO lt_del_tab.
                      CLEAR ls_del_tab.
                    ENDIF.
                  ENDLOOP.
                  "Entry deleted by user while editing existing entry.
                  DELETE /ey1/sgaap_tas FROM TABLE lt_del_tab.
                ENDIF.

              LOOP AT lt_item_data ASSIGNING FIELD-SYMBOL(<fs_item1>).
                SELECT SINGLE * FROM /ey1/sgaap_tas INTO @DATA(ls_tas)
                  WHERE rcongr = @<fs_header>-consolidationgroupforedit
                  AND   bunit  = @<fs_item1>-consolidationunitforedit.
                  IF sy-subrc IS INITIAL.
                    "Check if user changed any entry, if yes then update the existing entry
                    IF ls_tas-classification <> <fs_item1>-classification OR
                       ls_tas-tax_rate_change <> <fs_item1>-taxratechange OR
                       ls_tas-dta_recognition <> <fs_item1>-dtarecognition OR
                       ls_tas-dtice <> <fs_item1>-dtintracompanyelimination.

                      ls_sgaap-rcongr          = <fs_header>-consolidationgroupforedit.
                      ls_sgaap-bunit           = <fs_item1>-consolidationunitforedit.
                      ls_sgaap-classification  = <fs_item1>-classification.
                      ls_sgaap-tax_rate_change = <fs_item1>-taxratechange.
                      ls_sgaap-dta_recognition = <fs_item1>-dtarecognition.
                      ls_sgaap-dtice           = <fs_item1>-dtintracompanyelimination.
                      ls_sgaap-created_by      = ls_tas-created_by.
                      ls_sgaap-created_on      = ls_tas-created_on.
                      ls_sgaap-changed_by      = <fs_item1>-changedby.
                      ls_sgaap-changed_on      = <fs_item1>-changedon.
                      APPEND ls_sgaap TO lt_sgaap.
                      CLEAR ls_sgaap.
                    ENDIF.
                  ELSE.
                    "new entry created by user in edit mode
                    ls_sgaap-rcongr          = <fs_header>-consolidationgroupforedit.
                    ls_sgaap-bunit           = <fs_item1>-consolidationunitforedit.
                    ls_sgaap-classification  = <fs_item1>-classification.
                    ls_sgaap-tax_rate_change = <fs_item1>-taxratechange.
                    ls_sgaap-dta_recognition = <fs_item1>-dtarecognition.
                    ls_sgaap-dtice           = <fs_item1>-dtintracompanyelimination.
                    ls_sgaap-created_by      = <fs_item1>-createdby.
                    ls_sgaap-created_on      = <fs_item1>-createdon.
                    APPEND ls_sgaap TO lt_sgaap.
                    CLEAR ls_sgaap.
                  ENDIF.
              ENDLOOP.

              io_modify->update( EXPORTING iv_node = is_ctx-node_key
                                           iv_key  = it_draft_key[ 1 ]-key        ##OPERATOR[IT_DRAFT_KEY]
                                           is_data = REF #( lt_item_data[ 1 ] ) ).

              MODIFY /ey1/sgaap_tas FROM TABLE lt_sgaap.
              IF sy-subrc IS INITIAL.
                lv_success = abap_true.
              ELSE.
                lv_error = abap_true.
              ENDIF.
            ELSE.
             SELECT * FROM /ey1/sgaap_tas INTO TABLE @DATA(lt_stat1)
              WHERE rcongr = @<fs_header>-consolidationgroupforedit.
               IF sy-subrc IS INITIAL.
                 DELETE /ey1/sgaap_tas FROM TABLE lt_stat1.
                 IF sy-subrc IS INITIAL.
                   lv_success = abap_true.
                 ENDIF.
               ENDIF.
             lv_success = abap_true.
            ENDIF.

          IF lv_success = abap_true.
            eo_message->add_message( EXPORTING is_msg = VALUE #( msgid = '/EY1/SAV_SAVOTTA'
                                                                 msgno = '008'
                                                                 msgty = 'S' )
                                               iv_node =  /ey1/if_sav_i_ggaap_tas_c=>sc_node-/ey1/sav_i_ggaap_tas     "Node to be used in the origin location
                                               iv_key  =  lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA]. "Instance key to be used in the origin location
          ENDIF.

          IF lv_error = abap_true.
            eo_message->add_message( EXPORTING is_msg  = VALUE #( msgid = 'ZSAVOTTA'
                                                                  msgno = '007'
                                                                  msgty = 'E' )
                                               iv_node =  /ey1/if_sav_i_ggaap_tas_c=>sc_node-/ey1/sav_i_ggaap_tas    "Node to be used in the origin location
                                               iv_key  = lt_header_data[ 1 ]-root_key )  ##OPERATOR[LT_HEADER_DATA]. "Instance key to be used in the origin location
            et_failed_draft_key = it_draft_key.
            TRY.
              /bobf/cl_lib_enqueue_context=>get_instance( )->detach( ).
            CATCH /bobf/cx_frw_core ##NO_HANDLER.
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

        ASSIGN COMPONENT 'CONSOLIDATIONGROUP' OF STRUCTURE <fs_active_entity_key> TO FIELD-SYMBOL(<fs_gaap>).
        <fs_gaap> = lt_header_data[ 1 ]-consolidationgroupforedit.

**Map the active key structure to a GUID key
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
        CLEAR : lt_header_data, lt_item_data, lt_ggaap, lt_sgaap, lv_timestamp.
      ENDIF.
  ENDMETHOD.
ENDCLASS.

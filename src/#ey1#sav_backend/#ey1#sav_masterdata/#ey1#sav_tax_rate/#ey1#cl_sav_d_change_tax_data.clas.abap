class /EY1/CL_SAV_D_CHANGE_TAX_DATA definition
  public
  inheriting from /BOBF/CL_LIB_D_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DETERMINATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_D_CHANGE_TAX_DATA IMPLEMENTATION.


METHOD /bobf/if_frw_determination~execute.
  DATA: lt_tax_rates            TYPE STANDARD TABLE OF /EY1/S_SAV_I_CTR_TAX_RATE,
        lt_changed_fields       TYPE /bobf/t_frw_name        ##NEEDED,
        lt_active_document_keys TYPE /EY1/T_K_SAV_I_ACC_CLASS_ACTIV ##NEEDED,
        lt_draft_headers        TYPE /EY1/T_SAV_I_ACC_CLASS,
        lt_active_headers       TYPE /EY1/T_SAV_I_ACC_CLASS,
        lt_all_headers          TYPE /EY1/T_SAV_I_ACC_CLASS,
        ls_tax_rates            TYPE /EY1/S_SAV_I_CTR_TAX_RATE,
        lv_fieldname            TYPE string,
        lv_vat_rate             TYPE string,
        l_flag_found            TYPE flag.

*-----------------------------------------------------------------
*   Get the data
*-----------------------------------------------------------------
  io_read->retrieve(                                  ##NEEDED
   EXPORTING
     iv_node                 = is_ctx-node_key        " Node Name
     it_key                  = it_key                 " Key Table
     iv_fill_data            = abap_true
   IMPORTING
     eo_message              = DATA(lo_message)       " Message Object
     et_data                 = lt_tax_rates           " Data Return Structure
     et_failed_key           = et_failed_key ).       " Key Table

*-----------------------------------------------------------------
*   Initialize helper
*-----------------------------------------------------------------
  DATA(lo_property_helper) = NEW /bobf/cl_lib_h_set_property( io_modify = io_modify
                                                              is_context = is_ctx ).

**Create a message container
  eo_message = /bobf/cl_frw_message_factory=>create_container( ).

*-----------------------------------------------------------------
*   Get Draft and BOPF keys
*-----------------------------------------------------------------
  CALL METHOD /bobf/cl_lib_draft=>/bobf/if_lib_union_utilities~separate_keys
    EXPORTING
      iv_bo_key     = is_ctx-bo_key
      iv_node_key   = is_ctx-node_key
      it_key        = it_key
    IMPORTING
      et_draft_key  = DATA(lt_draft_bopf_keys)
      et_active_key = DATA(lt_active_bopf_keys).

*-----------------------------------------------------------------
*   Get active document keys
*-----------------------------------------------------------------
  DATA(lo_lib_legacy_key) =  /bobf/cl_lib_legacy_key=>get_instance( is_ctx-bo_key ).

  lo_lib_legacy_key->convert_bopf_to_legacy_keys(
    EXPORTING
      iv_node_key   =  is_ctx-node_key
      it_bopf_key   =  lt_active_bopf_keys
    IMPORTING
      et_legacy_key =  lt_active_document_keys ).


  READ TABLE it_key INTO DATA(ls_key) INDEX 1 .
  READ TABLE lt_tax_rates REFERENCE INTO DATA(lr_data) INDEX 1.

*-----------------------------------------------------------------
*   Set up OB tax rate from previous year
*-----------------------------------------------------------------
  FIND ALL OCCURRENCES OF REGEX '[^0-9]+' IN lr_data->gjahrforedit MATCH COUNT DATA(dum).

  IF sy-subrc <> 0 AND lr_data->rbunitforedit IS NOT INITIAL AND lr_data->gjahrforedit IS NOT INITIAL
    AND lr_data->intentionforedit IS NOT INITIAL.

    DATA(l_var_yearback) = lr_data->gjahrforedit - 1.

    SELECT SINGLE gaap_cb_dt_rate, stat_cb_dt_rate FROM /EY1/SAV_I_CTR_TAX_RATE INTO @DATA(l_str_taxrates)
      WHERE rbunit = @lr_data->rbunitforedit AND gjahr = @l_var_yearback AND intention = @lr_data->intentionforedit.

    IF sy-subrc = 0.
      l_flag_found = abap_true.

      lr_data->gaap_ob_dt_rate = l_str_taxrates-gaap_cb_dt_rate.
      lr_data->stat_ob_dt_rate = l_str_taxrates-stat_cb_dt_rate.
      lr_data->gaap_ob_dt_rateforedit = |{ l_str_taxrates-gaap_cb_dt_rate } %|.
      lr_data->stat_ob_dt_rateforedit = |{ l_str_taxrates-stat_cb_dt_rate } %|.
    ENDIF.
  ENDIF.

**-----------------------------------------------------------------
**   Copy tax rate values from edit fields with %
**-----------------------------------------------------------------
  TRY.
      IF l_flag_found = abap_false.
        IF lr_data->gaap_ob_dt_rateforedit IS NOT INITIAL.
          lv_vat_rate = lr_data->gaap_ob_dt_rateforedit.
          REPLACE ALL OCCURRENCES OF REGEX '[^0-9,.]+' IN lv_vat_rate WITH ''.
          lr_data->gaap_ob_dt_rate = lv_vat_rate.
        ENDIF.

        IF lr_data->stat_ob_dt_rateforedit IS NOT INITIAL.
          lv_vat_rate = lr_data->stat_ob_dt_rateforedit.
          REPLACE ALL OCCURRENCES OF REGEX '[^0-9,.]+' IN lv_vat_rate WITH ''.
          lr_data->stat_ob_dt_rate = lv_vat_rate.
        ENDIF.
      ENDIF.

      IF lr_data->gaap_cb_dt_rateforedit IS NOT INITIAL.
        lv_vat_rate = lr_data->gaap_cb_dt_rateforedit.
        REPLACE ALL OCCURRENCES OF REGEX '[^0-9,.]+' IN lv_vat_rate WITH ''.
        lr_data->gaap_cb_dt_rate = lv_vat_rate.
      ENDIF.

      IF lr_data->stat_cb_dt_rateforedit IS NOT INITIAL.
        lv_vat_rate = lr_data->stat_cb_dt_rateforedit.
        REPLACE ALL OCCURRENCES OF REGEX '[^0-9,.]+' IN lv_vat_rate WITH ''.
        lr_data->stat_cb_dt_rate = lv_vat_rate.
      ENDIF.

      IF lr_data->current_tax_rateforedit IS NOT INITIAL.
        lv_vat_rate = lr_data->current_tax_rateforedit.
        REPLACE ALL OCCURRENCES OF REGEX '[^0-9,.]+' IN lv_vat_rate WITH ''.
        lr_data->current_tax_rate = lv_vat_rate.
      ENDIF.

    CATCH cx_root INTO DATA(l_var_msg).
*     Please input the Tax Rates in proper format (00.00).
      eo_message->add_message( EXPORTING is_msg  =  VALUE #( msgid = /EY1/SAV_IF_CONSTANTS=>C_MSG_ID_SAVOTTA
                                                             msgno = 017
                                                             msgty = 'E' )
                                         iv_node = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE " Node to be used in the origin location
                                         iv_key  = lt_tax_rates[ 1 ]-root_key ).
      et_failed_key = it_key.
      RETURN.
  ENDTRY.

*-----------------------------------------------------------------
*   Data modification
*-----------------------------------------------------------------

  LOOP AT lt_tax_rates ASSIGNING FIELD-SYMBOL(<ls_tax_rate>).

      io_modify->update(
         iv_node           = /EY1/IF_SAV_I_CTR_TAX_RATE_C=>sc_node-/EY1/SAV_I_CTR_TAX_RATE
         iv_key            = <ls_tax_rate>-key
         is_data           =  REF #( <ls_tax_rate> )
*         it_changed_fields = l_tab_fields
      ).

  ENDLOOP.

ENDMETHOD.
ENDCLASS.

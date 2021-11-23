class /EY1/CL_SAV_ADJST_JOUR_DPC_EXT definition
  public
  inheriting from /EY1/CL_SAV_ADJST_JOUR_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
protected section.

  methods PERIODSET_GET_ENTITY
    redefinition .
  methods PERIODSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_ADJST_JOUR_DPC_EXT IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
*  EXPORTING
**    iv_entity_name          =
**    iv_entity_set_name      =
**    iv_source_name          =
*    IO_DATA_PROVIDER        =
**    it_key_tab              =
**    it_navigation_path      =
*    IO_EXPAND               =
**    io_tech_request_context =
**  IMPORTING
**    er_deep_entity          =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.

 DATA:
      lo_struct_descr   TYPE REF TO cl_abap_structdescr,
      lr_source_struct  TYPE REF TO data.


DATA: lo_msg            TYPE REF TO /iwbep/if_message_container.

 FIELD-SYMBOLS:
      <ls_source_structure> TYPE any.

 DATA: BEGIN OF ls_str.
      INCLUDE TYPE /ey1/cl_sav_adjst_jour_mpc_ext=>TS_ACCOUNTHEADER.
      DATA AccountItemsSet       TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accountitems.
      DATA ReturnSet             TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_return.
      DATA AccountPayableSet    TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accountpayable.
      DATA AccountReceivableSet TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accountreceivable.
      DATA AccountTaxSet        TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accounttax.
      DATA AccountCustomSet      TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accountcustom.
DATA: END OF ls_str.


  DATA: lr_deep_entity LIKE ls_str,
        lt_acccustom  TYPE TABLE OF /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accountcustom,
        ls_acccustom  TYPE  /ey1/cl_sav_adjst_jour_mpc_ext=>ts_accountcustom,
        ls_header   TYPE /ey1/sav_adjust_journl_ent_hdr,
        lt_accgl    TYPE /ey1/sav_tt_adjust_jornl_gl,
        lt_accpay   TYPE /ey1/sav_tt_adjust_jornl_ap,
        lt_accrec   TYPE /ey1/sav_tt_adjust_jornl_ar,
        lt_acctax   TYPE /ey1/sav_tt_adjust_jornl_tax,
        lt_msg      TYPE /ey1/sav_tt_adjust_jornl_msg,
        ls_msg      LIKE LINE OF lt_msg,
        ls_bapi_hdr TYPE          bapiache09,
        lt_bapi_gl  TYPE TABLE OF bapiacgl09,
        ls_bapi_gl  TYPE bapiacgl09,
        lt_bapi_ap  TYPE TABLE OF bapiacap09,
        ls_bapi_ap  TYPE bapiacap09,
        lt_bapi_ar  TYPE TABLE OF bapiacar09,
        ls_bapi_ar  TYPE bapiacar09,
        lt_bapi_tx  TYPE TABLE OF bapiactx09,
        ls_bapi_tx  TYPE bapiactx09,
        lt_bapu_ret TYPE TABLE OF bapiret2,
        lt_bapi_cur TYPE TABLE OF bapiaccr09,
        ls_bapi_cur TYPE bapiaccr09,
        lt_return   TYPE TABLE OF bapiret2,
        lt_bapi_ext TYPE TABLE OF bapiparex,
        ls_bapi_ext TYPE bapiparex.

    io_data_provider->read_entry_data(
                       IMPORTING
                       es_data = lr_deep_entity  ).

    "Header
     MOVE:
     lr_deep_entity-OBJTYPE             TO  ls_bapi_hdr-OBJ_TYPE,
     lr_deep_entity-OBJKEY              TO  ls_bapi_hdr-obj_key,
     lr_deep_entity-OBJSYS              TO  ls_bapi_hdr-obj_sys,
     lr_deep_entity-BUSACT              TO  ls_bapi_hdr-bus_act,
     sy-uname                           TO  ls_bapi_hdr-username,
     lr_deep_entity-HEADERTXT           TO  ls_bapi_hdr-header_txt,
     lr_deep_entity-COMPANYCODE         TO  ls_bapi_hdr-comp_code.
    IF lr_deep_entity-DOCDATE IS NOT INITIAL.
     DATA: lv_date TYPE string.
     lv_date = lr_deep_entity-DOCDATE.
     MOVE lv_date+0(8)             TO  ls_bapi_hdr-doc_date.
    ENDIF.
    IF lr_deep_entity-PSTNGDATE IS NOT INITIAL.
      lv_date = lr_deep_entity-PSTNGDATE.
     MOVE lv_date+0(8)           TO  ls_bapi_hdr-pstng_date.
    ENDIF.

     IF lr_deep_entity-TRANSDATE IS NOT INITIAL.
       lv_date = lr_deep_entity-TRANSDATE.
     MOVE:lv_date+0(8)           TO  ls_bapi_hdr-trans_date.
     ENDIF.
     MOVE:lr_deep_entity-FISCYEAR           TO  ls_bapi_hdr-fisc_year,
      lr_deep_entity-FISPERIOD          TO  ls_bapi_hdr-fis_period,
      lr_deep_entity-DOCTYPE            TO  ls_bapi_hdr-doc_type,
      lr_deep_entity-REFDOCNO           TO  ls_bapi_hdr-ref_doc_no,
      lr_deep_entity-ACDOCNO            TO  ls_bapi_hdr-ac_doc_no,
      lr_deep_entity-OBJKEYR            TO  ls_bapi_hdr-obj_key_r,
      lr_deep_entity-REASONREV          TO  ls_bapi_hdr-reason_rev,
      lr_deep_entity-COMPOACC           TO  ls_bapi_hdr-compo_acc,
      lr_deep_entity-REFDOCNOLONG       TO  ls_bapi_hdr-ref_doc_no_long,
      lr_deep_entity-ACCPRINCIPLE       TO  ls_bapi_hdr-acc_principle,
      lr_deep_entity-NEGPOSTNG          TO  ls_bapi_hdr-neg_postng,
      lr_deep_entity-OBJKEYINV          TO  ls_bapi_hdr-obj_key_inv,
      lr_deep_entity-BILLCATEGORY       TO  ls_bapi_hdr-bill_category.

      IF lr_deep_entity-vatdate IS NOT INITIAL.
       lv_date = lr_deep_entity-VATDATE.
       MOVE: lv_date+0(8)   TO  ls_bapi_hdr-vatdate.
      ENDIF.
      IF lr_deep_entity-invoicerecdate IS NOT INITIAL.
        lv_date = lr_deep_entity-INVOICERECDATE.
        MOVE lv_date+0(8)     TO  ls_bapi_hdr-invoice_rec_date.
      ENDIF.
      MOVE: lr_deep_entity-ECSENV             TO  ls_bapi_hdr-ecs_env,
      lr_deep_entity-PARTIALREV         TO  ls_bapi_hdr-partial_rev,
      lr_deep_entity-DOCSTATUS          TO  ls_bapi_hdr-doc_status.

      IF lr_deep_entity-TAXCALCDATE IS NOT INITIAL.
      LV_DATE = lr_deep_entity-TAXCALCDATE.
      MOVE LV_DATE+0(8)        TO  ls_bapi_hdr-tax_calc_date.
      ENDIF.
      MOVE:lr_deep_entity-GLOREF1HD          TO  ls_bapi_hdr-glo_ref1_hd.
      IF lr_deep_entity-GLODAT1HD IS NOT INITIAL.

        lv_date = lr_deep_entity-GLODAT1HD.
        MOVE lv_date+0(8)          TO  ls_bapi_hdr-glo_dat1_hd.
      ENDIF.
      MOVE: lr_deep_entity-GLOREF2HD          TO  ls_bapi_hdr-glo_ref2_hd.

      IF lr_deep_entity-GLODAT2HD IS NOT INITIAL.
        lv_date = lr_deep_entity-GLODAT2HD.
        MOVE lv_date+0(8)         TO  ls_bapi_hdr-glo_dat2_hd.
      ENDIF.
      MOVE lr_deep_entity-GLOREF3HD          TO  ls_bapi_hdr-glo_ref3_hd.
      IF lr_deep_entity-GLODAT3HD IS NOT INITIAL.
        lv_date = lr_deep_entity-GLODAT3HD.
        MOVE lv_date+0(8)        TO  ls_bapi_hdr-glo_dat3_hd.
      ENDIF.
      MOVE lr_deep_entity-GLOREF4HD          TO  ls_bapi_hdr-glo_ref4_hd.
      IF lr_deep_entity-GLODAT4HD  IS NOT INITIAL.
        lv_date = lr_deep_entity-GLODAT4HD.
        MOVE lv_date+0(8)          TO  ls_bapi_hdr-glo_dat4_hd.
      ENDIF.
      MOVE lr_deep_entity-GLOREF5HD          TO  ls_bapi_hdr-glo_ref5_hd.
      IF lr_deep_entity-GLODAT5HD IS NOT INITIAL.
        lv_date = lr_deep_entity-GLODAT5HD.
        MOVE lv_date+0(8)          TO  ls_bapi_hdr-glo_dat5_hd.
      ENDIF.
      MOVE:lr_deep_entity-GLOBP1HD           TO  ls_bapi_hdr-glo_bp1_hd,
      lr_deep_entity-GLOBP2HD           TO  ls_bapi_hdr-glo_bp2_hd,
      lr_deep_entity-EVPOSTNGCTRL       TO  ls_bapi_hdr-ev_postng_ctrl,
      lr_deep_entity-LEDGERGROUP        TO  ls_bapi_hdr-ledger_group.
      IF lr_deep_entity-PLANNEDREVDATE IS NOT INITIAL.
        lv_date = lr_deep_entity-PLANNEDREVDATE.
        MOVE lv_date+0(8)     TO  ls_bapi_hdr-planned_rev_date.
      ENDIF.
    "End Header

    "Account Item
      LOOP AT lr_deep_entity-accountitemsset INTO DATA(ls_item).
            MOVE: ls_item-ITEMNO_ACC TO ls_bapi_gl-itemno_acc,
            ls_item-GL_ACCOUNT TO ls_bapi_gl-gl_account,
            ls_item-ITEM_TEXT TO ls_bapi_gl-item_text,
            ls_item-STAT_CON  TO ls_bapi_gl-stat_con,
            ls_item-LOG_PROC TO ls_bapi_gl-log_proc,
            ls_item-AC_DOC_NO TO ls_bapi_gl-ac_doc_no,
            ls_item-REF_KEY_1 TO ls_bapi_gl-ref_key_1,
            ls_item-REF_KEY_2 TO ls_bapi_gl-ref_key_2,
            ls_item-REF_KEY_3 TO ls_bapi_gl-ref_key_3,
            ls_item-ACCT_KEY TO ls_bapi_gl-acct_key,
            ls_item-ACCT_TYPE TO ls_bapi_gl-acct_type,
            ls_item-DOC_TYPE TO ls_bapi_gl-doc_type,
            ls_item-COMP_CODE TO ls_bapi_gl-comp_code,
            ls_item-BUS_AREA TO ls_bapi_gl-bus_area,
            ls_item-FUNC_AREA TO ls_bapi_gl-func_area,
            ls_item-PLANT TO ls_bapi_gl-plant,
            ls_item-FIS_PERIOD TO ls_bapi_gl-fis_period,
            ls_item-FISC_YEAR TO ls_bapi_gl-fisc_year.
            IF ls_item-PSTNG_DATE IS NOT INITIAL.
              lv_date = ls_item-PSTNG_DATE.
              MOVE lv_date+0(8) TO ls_bapi_gl-pstng_date.
            ENDIF.
            IF ls_item-VALUE_DATE IS NOT INITIAL.
              lv_date = ls_item-VALUE_DATE.
              MOVE lv_date+0(8) TO ls_bapi_gl-value_date.
            ENDIF.
            MOVE: ls_item-FM_AREA  TO ls_bapi_gl-fm_area,
            ls_item-CUSTOMER TO ls_bapi_gl-customer,
            ls_item-CSHDIS_IND TO ls_bapi_gl-cshdis_ind,
            ls_item-VENDOR_NO  TO ls_bapi_gl-vendor_no,
            ls_item-ALLOC_NMBR TO ls_bapi_gl-alloc_nmbr,
            ls_item-TAX_CODE  TO ls_bapi_gl-tax_code,
            ls_item-TAXJURCODE TO ls_bapi_gl-taxjurcode,
            ls_item-EXT_OBJECT_ID TO ls_bapi_gl-ext_object_id,
            ls_item-BUS_SCENARIO  TO ls_bapi_gl-bus_scenario,
            ls_item-COSTOBJECT  TO ls_bapi_gl-costobject,
            ls_item-COSTCENTER TO ls_bapi_gl-costcenter,
            ls_item-ACTTYPE TO ls_bapi_gl-acttype,
            ls_item-PROFIT_CTR TO ls_bapi_gl-profit_ctr,
            ls_item-PART_PRCTR TO ls_bapi_gl-part_prctr,
            ls_item-NETWORK  TO ls_bapi_gl-network,
            ls_item-WBS_ELEMENT TO ls_bapi_gl-wbs_element,
            ls_item-ORDERID  TO ls_bapi_gl-orderid,
            ls_item-ORDER_ITNO TO ls_bapi_gl-order_itno,
            ls_item-ROUTING_NO TO ls_bapi_gl-routing_no,
            ls_item-ACTIVITY TO ls_bapi_gl-activity,
            ls_item-COND_TYPE TO ls_bapi_gl-cond_type,
            ls_item-COND_COUNT TO ls_bapi_gl-cond_count,
            ls_item-COND_ST_NO TO ls_bapi_gl-cond_st_no,
            ls_item-FUND TO ls_bapi_gl-fund,
            ls_item-FUNDS_CTR TO ls_bapi_gl-funds_ctr,
            ls_item-CMMT_ITEM TO ls_bapi_gl-cmmt_item,
            ls_item-CO_BUSPROC TO ls_bapi_gl-co_busproc,
            ls_item-ASSET_NO TO ls_bapi_gl-asset_no,
            ls_item-SUB_NUMBER TO ls_bapi_gl-sub_number,
            ls_item-BILL_TYPE TO ls_bapi_gl-bill_type,
            ls_item-SALES_ORD TO ls_bapi_gl-sales_ord,
            ls_item-S_ORD_ITEM TO ls_bapi_gl-s_ord_item,
            ls_item-DISTR_CHAN TO ls_bapi_gl-distr_chan,
            ls_item-DIVISION TO ls_bapi_gl-division,
            ls_item-SALESORG TO ls_bapi_gl-salesorg,
            ls_item-SALES_GRP TO ls_bapi_gl-sales_grp,
            ls_item-SALES_OFF TO ls_bapi_gl-sales_off,
            ls_item-SOLD_TO TO ls_bapi_gl-sold_to,
            ls_item-DE_CRE_IND TO ls_bapi_gl-de_cre_ind,
            ls_item-P_EL_PRCTR TO ls_bapi_gl-p_el_prctr,
            ls_item-XMFRW TO ls_bapi_gl-xmfrw,
            ls_item-QUANTITY TO ls_bapi_gl-quantity,
            ls_item-BASE_UOM TO ls_bapi_gl-base_uom,
            ls_item-BASE_UOM_ISO TO ls_bapi_gl-base_uom_iso,
            ls_item-INV_QTY TO ls_bapi_gl-inv_qty,
            ls_item-INV_QTY_SU TO ls_bapi_gl-inv_qty_su,
            ls_item-SALES_UNIT TO ls_bapi_gl-sales_unit,
            ls_item-SALES_UNIT_ISO TO ls_bapi_gl-sales_unit_iso,
            ls_item-PO_PR_QNT TO ls_bapi_gl-po_pr_qnt,
            ls_item-PO_PR_UOM TO ls_bapi_gl-po_pr_uom,
            ls_item-PO_PR_UOM_ISO TO ls_bapi_gl-po_pr_uom_iso,
            ls_item-ENTRY_QNT TO ls_bapi_gl-entry_qnt,
            ls_item-ENTRY_UOM TO ls_bapi_gl-entry_uom,
            ls_item-ENTRY_UOM_ISO TO ls_bapi_gl-entry_uom_iso,
            ls_item-VOLUME TO ls_bapi_gl-volume,
            ls_item-VOLUMEUNIT TO ls_bapi_gl-volumeunit,
            ls_item-VOLUMEUNIT_ISO TO ls_bapi_gl-volumeunit_iso,
            ls_item-GROSS_WT TO ls_bapi_gl-gross_wt,
            ls_item-NET_WEIGHT TO ls_bapi_gl-net_weight,
            ls_item-UNIT_OF_WT TO ls_bapi_gl-unit_of_wt,
            ls_item-UNIT_OF_WT_ISO TO ls_bapi_gl-unit_of_wt_iso,
            ls_item-ITEM_CAT TO ls_bapi_gl-item_cat,
            ls_item-MATERIAL TO ls_bapi_gl-material,
            ls_item-MATL_TYPE TO ls_bapi_gl-matl_type,
            ls_item-MVT_IND TO ls_bapi_gl-mvt_ind,
            ls_item-REVAL_IND TO ls_bapi_gl-reval_ind,
            ls_item-ORIG_GROUP TO ls_bapi_gl-orig_group,
            ls_item-ORIG_MAT TO ls_bapi_gl-orig_mat,
            ls_item-SERIAL_NO TO ls_bapi_gl-serial_no,
            ls_item-PART_ACCT TO ls_bapi_gl-part_acct,
            ls_item-TR_PART_BA TO ls_bapi_gl-tr_part_ba,
            ls_item-TRADE_ID TO ls_bapi_gl-trade_id,
            ls_item-VAL_AREA TO ls_bapi_gl-val_area,
            ls_item-VAL_TYPE TO ls_bapi_gl-val_type.
            IF ls_item-ASVAL_DATE IS NOT INITIAL.
             lv_date = ls_item-ASVAL_DATE.
             MOVE lv_date+0(8) TO ls_bapi_gl-asval_date.
            ENDIF.
            MOVE: ls_item-PO_NUMBER TO ls_bapi_gl-po_number,
            ls_item-PO_ITEM TO ls_bapi_gl-po_item,
            ls_item-ITM_NUMBER TO ls_bapi_gl-itm_number,
            ls_item-COND_CATEGORY TO ls_bapi_gl-cond_category,
            ls_item-FUNC_AREA_LONG TO ls_bapi_gl-func_area_long,
            ls_item-CMMT_ITEM_LONG TO ls_bapi_gl-cmmt_item_long,
            ls_item-GRANT_NBR  TO ls_bapi_gl-grant_nbr,
            ls_item-CS_TRANS_T TO ls_bapi_gl-cs_trans_t,
*            "Since In our custom app, we are passing transaction type in Header
*            lr_deep_entity-transactiontype TO ls_bapi_gl-cs_trans_t,
*            "End
            ls_item-MEASURE TO ls_bapi_gl-measure,
            ls_item-SEGMENT TO ls_bapi_gl-segment,
            ls_item-PARTNER_SEGMENT TO ls_bapi_gl-partner_segment,
            ls_item-RES_DOC TO ls_bapi_gl-res_doc,
            ls_item-RES_ITEM TO ls_bapi_gl-res_item.
            IF ls_item-BILLING_PERIOD_START_DATE IS NOT INITIAL.
             lv_date = ls_item-BILLING_PERIOD_START_DATE.
             MOVE lv_date+0(8) TO ls_bapi_gl-billing_period_start_date.
            ENDIF.
            IF ls_item-BILLING_PERIOD_END_DATE IS NOT INITIAL.
            lv_date = ls_item-BILLING_PERIOD_END_DATE.
            MOVE lv_date+0(8) TO ls_bapi_gl-billing_period_end_date.
            ENDIF.
            MOVE: ls_item-PPA_EX_IND TO ls_bapi_gl-ppa_ex_ind,
            ls_item-FASTPAY TO ls_bapi_gl-fastpay,
            ls_item-PARTNER_GRANT_NBR TO ls_bapi_gl-partner_grant_nbr,
            ls_item-BUDGET_PERIOD TO ls_bapi_gl-budget_period,
            ls_item-PARTNER_BUDGET_PERIOD TO ls_bapi_gl-partner_budget_period,
            ls_item-PARTNER_FUND TO ls_bapi_gl-partner_fund,
            ls_item-ITEMNO_TAX TO ls_bapi_gl-itemno_tax,
            ls_item-PAYMENT_TYPE TO ls_bapi_gl-payment_type,
            ls_item-EXPENSE_TYPE TO ls_bapi_gl-expense_type,
            ls_item-PROGRAM_PROFILE TO ls_bapi_gl-program_profile,
            ls_item-MATERIAL_LONG TO ls_bapi_gl-material_long,
            ls_item-HOUSEBANKID TO ls_bapi_gl-housebankid,
            ls_item-HOUSEBANKACCTID TO ls_bapi_gl-housebankacctid,
            ls_item-PERSON_NO TO ls_bapi_gl-person_no,
            ls_item-ACROBJ_TYPE TO ls_bapi_gl-acrobj_type,
            ls_item-ACROBJ_ID TO ls_bapi_gl-acrobj_id,
            ls_item-ACRSUBOBJ_ID TO ls_bapi_gl-acrsubobj_id,
            ls_item-ACRITEM_TYPE TO ls_bapi_gl-acritem_type,
            ls_item-VALOBJTYPE TO ls_bapi_gl-valobjtype,
            ls_item-VALOBJ_ID TO ls_bapi_gl-valobj_id,
            ls_item-VALSUBOBJ_ID TO ls_bapi_gl-valsubobj_id.
            IF ls_item-TAX_CALC_DATE IS NOT INITIAL.
              lv_date = ls_item-TAX_CALC_DATE.
              MOVE lv_date+0(8) TO ls_bapi_gl-tax_calc_date.
            ENDIF.
            IF ls_item-TAX_CALC_DT_FROM IS NOT INITIAL.
              lv_date = ls_item-TAX_CALC_DT_FROM.
               MOVE lv_date+0(8) TO ls_bapi_gl-tax_calc_dt_from.
            ENDIF.
            MOVE: ls_item-SERVICE_DOC_TYPE TO ls_bapi_gl-service_doc_type,
            ls_item-SERVICE_DOC_ID TO ls_bapi_gl-service_doc_id,
            ls_item-SERVICE_DOC_ITEM_ID TO ls_bapi_gl-service_doc_item_id,
            ls_item-BDGT_ACCOUNT TO ls_bapi_gl-bdgt_account.


            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
              EXPORTING
                input         = ls_bapi_gl-gl_account
             IMPORTING
                output        = ls_bapi_gl-gl_account.

            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
              EXPORTING
                input         = ls_bapi_gl-profit_ctr
             IMPORTING
                output        = ls_bapi_gl-profit_ctr.

            CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
              EXPORTING
                input         = ls_bapi_gl-costcenter
             IMPORTING
                output        = ls_bapi_gl-costcenter.


            APPEND ls_bapi_gl TO lt_bapi_gl.


            "Currency
            MOVE: ls_item-CURRENCY TO ls_bapi_cur-currency,
            ls_item-itemno_acc TO ls_bapi_cur-itemno_acc,
            '00' TO ls_bapi_cur-curr_type,
            ls_item-amt_doccur TO ls_bapi_cur-amt_doccur.
            APPEND ls_bapi_cur TO lt_bapi_cur.

      ENDLOOP.
    "End Account Item

    "Account Custom
     LOOP AT lr_deep_entity-accountitemsset INTO ls_item.
       MOVE-CORRESPONDING ls_item TO ls_acccustom.
       APPEND ls_acccustom TO lt_acccustom.
     ENDLOOP.

    "Account Payable - Customer
    APPEND LINES OF lr_deep_entity-accountpayableset TO lt_accpay.
    LOOP AT lt_accpay INTO DATA(ls_pay).
      MOVE-CORRESPONDING ls_pay TO ls_bapi_ap.
      APPEND ls_bapi_ap TO lt_bapi_ap.

      ls_bapi_cur-itemno_acc = ls_pay-itemno_acc.
      ls_bapi_cur-curr_type = '00'.
      ls_bapi_cur-currency = ls_pay-currency.
      ls_bapi_cur-amt_base = ls_pay-amt_doccur.
      APPEND ls_bapi_cur TO lt_bapi_cur.
    ENDLOOP.

    "Account Receivable - Vendor
    APPEND LINES OF lr_deep_entity-accountreceivableset TO lt_accrec.
    LOOP AT lt_accrec INTO DATA(ls_rec).
      MOVE-CORRESPONDING ls_rec TO ls_bapi_ar.
      APPEND ls_bapi_ar TO lt_bapi_ar.

      CLEAR: ls_bapi_cur.
      ls_bapi_cur-itemno_acc = ls_pay-itemno_acc.
      ls_bapi_cur-curr_type = '00'.
      ls_bapi_cur-currency = ls_pay-currency.
      ls_bapi_cur-amt_doccur = ls_pay-amt_doccur.
      APPEND ls_bapi_cur TO lt_bapi_cur.
    ENDLOOP.

    "Account Tax
    APPEND LINES OF lr_deep_entity-accounttaxset TO lt_acctax.
    LOOP AT lt_acctax INTO DATA(ls_tax).
      MOVE-CORRESPONDING ls_tax TO ls_bapi_tx.
      APPEND ls_bapi_tx TO lt_bapi_tx.

      CLEAR: ls_bapi_cur.
      ls_bapi_cur-itemno_acc = ls_pay-itemno_acc.
      ls_bapi_cur-curr_type = '00'.
      ls_bapi_cur-currency = ls_pay-currency.
      ls_bapi_cur-amt_doccur = ls_pay-amt_doccur.
      APPEND ls_bapi_cur TO lt_bapi_cur.
    ENDLOOP.

    "Account GL
    LOOP AT lt_accgl INTO DATA(ls_gl).
      MOVE-CORRESPONDING ls_gl TO ls_bapi_gl.
      APPEND ls_bapi_gl TO lt_bapi_gl.

      CLEAR: ls_bapi_cur.
      ls_bapi_cur-itemno_acc = ls_pay-itemno_acc.
      ls_bapi_cur-curr_type = '00'.
      ls_bapi_cur-currency = ls_pay-currency.
      ls_bapi_cur-amt_base = ls_pay-amt_doccur.
      APPEND ls_bapi_cur TO lt_bapi_cur.
    ENDLOOP.

    "Assign BAPI Extension Structure
    LOOP AT lt_acccustom INTO ls_acccustom.
        ls_bapi_ext-structure = ls_acccustom-structure.
        ls_bapi_ext-valuepart1 = ls_acccustom-itemnoacc.
        IF ls_acccustom-structure = 'AccountHeader'.
           ls_bapi_ext-valuepart2 = 'C_ACCHD'.
        ELSEIF ls_acccustom-structure = 'AccountItems'.
           ls_bapi_ext-valuepart2 = 'C_ACCIT'.
        ENDIF.
        ls_bapi_ext-valuepart3 = ls_acccustom-key.
        ls_bapi_ext-valuepart4 = ls_acccustom-value.

        APPEND ls_bapi_ext TO lt_bapi_ext.
    ENDLOOP.


    "BAPI Call
    CALL FUNCTION 'BAPI_ACC_DOCUMENT_POST'
        EXPORTING
          documentheader      = ls_bapi_hdr
        TABLES
          accountgl           = lt_bapi_gl
          accountreceivable   = lt_bapi_ar
          accountpayable      = lt_bapi_ap
          accounttax          = lt_bapi_tx
          currencyamount      = lt_bapi_cur
          extension2          = lt_bapi_ext
          return              = lt_return.



    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = 'X'.

    READ TABLE lt_return TRANSPORTING NO FIELDS WITH KEY type = 'E'.
    IF sy-subrc = 0.
      CALL METHOD me->/iwbep/if_mgw_conv_srv_runtime~get_message_container
        RECEIVING
          ro_message_container = lo_msg.

      LOOP AT lt_return INTO DATA(ls_return).
        IF ls_return-type = 'E'.
          CALL METHOD lo_msg->add_message
            EXPORTING
            iv_msg_type    = /iwbep/cl_cos_logger=>error
            iv_msg_id      = ls_return-id
            iv_msg_number  = ls_return-number
            iv_msg_v1      = ls_return-message_v1
            iv_msg_v2      = ls_return-message_v2.
        ELSEIF ls_return-type = 'W'.
          CALL METHOD lo_msg->add_message
            EXPORTING
            iv_msg_type    = /iwbep/cl_cos_logger=>warning
            iv_msg_id      = ls_return-id
            iv_msg_number  = ls_return-number
            iv_msg_v1      = ls_return-message_v1
            iv_msg_v2      = ls_return-message_v2.
        ELSEIF ls_return-type = 'S'.
          CALL METHOD lo_msg->add_message
            EXPORTING
            iv_msg_type    = /iwbep/cl_cos_logger=>success
            iv_msg_id      = ls_return-id
            iv_msg_number  = ls_return-number
            iv_msg_v1      = ls_return-message_v1
            iv_msg_v2      = ls_return-message_v2.
        ENDIF.
      ENDLOOP.

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
           EXPORTING
           message_container = lo_msg.

    ELSE.
      "Assign Messages to LR_DEEP_ENTITY
      LOOP AT lt_return INTO ls_return.
        MOVE-CORRESPONDING ls_return TO ls_msg.
        ls_msg-guid = lr_deep_entity-guid.
        APPEND ls_msg TO lt_msg.
      ENDLOOP.
      APPEND LINES OF lt_msg TO lr_deep_entity-returnset.
      copy_data_to_ref(
        EXPORTING
         is_data = lr_deep_entity
        CHANGING
          cr_data = er_deep_entity
        ).
    ENDIF.

  endmethod.


  method PERIODSET_GET_ENTITY.
**TRY.
*CALL METHOD SUPER->PERIODSET_GET_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    io_request_object       =
**    io_tech_request_context =
*    IT_NAVIGATION_PATH      =
**  IMPORTING
**    er_entity               =
**    es_response_context     =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
*
*   DATA:  ls_keytab TYPE LINE OF /IWBEP/T_MGW_NAME_VALUE_PAIR,
*          lv_date   TYPE bkpf-budat,
*          lv_bukrs  TYPE bkpf-bukrs,
*          lv_monat  TYPE bkpf-monat.
*
*    LOOP AT it_key_tab INTO ls_keytab.
*      IF ls_keytab-name = 'CompanyCode'.
*        lv_bukrs = ls_keytab-value.
*      ELSEIF ls_keytab-name = 'PostingDate'.
*        lv_date  = ls_keytab-value.
*      ENDIF.
*    ENDLOOP.
*
*
*    CALL FUNCTION 'BAPI_COMPANYCODE_GET_PERIOD'
*      EXPORTING
*        companycodeid       = lv_bukrs
*        posting_date        = lv_date
*      IMPORTING
**       FISCAL_YEAR         =
*        fiscal_period       = lv_monat
**       RETURN              =
*              .
*
*    er_entity-companycode  = lv_bukrs.
*    er_entity-postingdate  = lv_date.
*    er_entity-fiscalperiod = lv_monat.

  endmethod.


  method PERIODSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->PERIODSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    io_tech_request_context  =
**  IMPORTING
**    et_entityset             =
**    es_response_context      =
*    .
**  CATCH /iwbep/cx_mgw_busi_exception.
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.



   DATA:  ls_entity        LIKE LINE OF et_entityset,
          ls_filter        TYPE /iwbep/s_mgw_select_option,
          lv_bukrs         TYPE bkpf-bukrs,
          lv_period        TYPE bkpf-monat,
          ls_opt           TYPE /iwbep/s_cod_select_option,
          lt_select_option TYPE /iwbep/t_mgw_select_option,
          lv_date          TYPE bkpf-budat,
          rv_period        TYPE bkpf-monat.

    LOOP AT it_filter_select_options INTO ls_filter.
      IF ls_filter-property = 'CompanyCode'.
        LOOP AT ls_filter-select_options INTO ls_opt.
          lv_bukrs         = ls_opt-low.
        ENDLOOP.
      ELSEIF ls_filter-property = 'PostingDate'.
        LOOP AT ls_filter-select_options INTO ls_opt.
          lv_date         = ls_opt-low+0(8).
        ENDLOOP.
      ENDIF.
    ENDLOOP.


    CALL FUNCTION 'BAPI_COMPANYCODE_GET_PERIOD'
      EXPORTING
        companycodeid       = lv_bukrs
        posting_date        = lv_date
      IMPORTING
*       FISCAL_YEAR         =
        FISCAL_PERIOD       = rv_period
*       RETURN              =
              .

    ls_entity-companycode = lv_bukrs.
    ls_entity-postingdate = lv_date.
    ls_entity-ReturnPeriod = rv_period.

    APPEND ls_entity TO et_entityset.

  endmethod.
ENDCLASS.

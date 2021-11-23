FUNCTION /EY1/FM_PYA_LINES_CALC_N_UPDT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_GJAHR) TYPE  GJAHR
*"     VALUE(IV_TAXINTENTION) TYPE  /EY1/SAV_INTENT
*"     VALUE(IV_BUNIT) TYPE  FC_BUNIT
*"----------------------------------------------------------------------

DATA: lv_intention TYPE zz1_taxintention.

TYPES: BEGIN OF ls_pya,
        BUNIT   type   FC_BUNIT,
        GJAHR   type   GJAHR,
        BELNR   type BELNR_D,
        DOCLN   type DOCLN6,
        BUKRS   type BUKRS,
        PYA_YEAR  type  GJAHR,
        PYA_INTENTION type  /EY1/SAV_INTENT,
        PYA_INTENTION_CODE  type ZZ1_TAXINTENTION,
        ADJ_YEAR  type  GJAHR,
        ADJ_INTENTION type  /EY1/SAV_INTENT,
        ADJ_INTENTION_CODE  type ZZ1_TAXINTENTION,
        TRANSACTIONTYPE type ZRLDNRASSGNTTYPE,
        YEARBALANCE type DMBTR,
        LEDGER  type RLDNR,
        LOCALCURRENCY  type  WAERS,
        AMOUNTGROUPCUR type DMBTR,
        GROUPCURRENCY  type WAERS,
        GLACCOUNT  type RACCT,
        KTOPL type  KTOPL,
        RVERS  type FC_RVERS,
        RITCLG type FC_ITCLG,
        PERIODTO TYPE /EY1/TO_PERIOD,
     END OF ls_pya.

 DATA: wa_pya TYPE ls_pya,
       lt_pya type table of ls_pya,
       ls_pya_amt TYPE /ey1/pya_amount,
       lt_pya_amt TYPE TABLE OF /ey1/pya_amount.


SELECT SINGLE taxintention FROM /ey1/intention
  INTO lv_intention
  WHERE intent = iv_taxintention.

IF sy-subrc = 0.
  CALL METHOD /ey1/cl_pya_docs=>get_documents
    EXPORTING
      iv_gjahr        = iv_gjahr
      iv_taxintention = lv_intention
      iv_bunit        = iv_bunit
    IMPORTING
      et_pya          = lt_pya
      .

   LOOP AT lt_pya INTO wa_pya.
     MOVE-CORRESPONDING wa_pya TO ls_pya_amt.
     APPEND ls_pya_amt TO lt_pya_amt.
   ENDLOOP.

ENDIF.

*SET UPDATE TASK LOCAL.

IF lt_pya_amt[] IS NOT INITIAL.
  CALL FUNCTION '/EY1/FM_PYA_LINES_POST' IN UPDATE TASK
      TABLES
        tt_pya  = lt_pya_amt[]
          .
ENDIF.

COMMIT WORK AND WAIT.

ENDFUNCTION.

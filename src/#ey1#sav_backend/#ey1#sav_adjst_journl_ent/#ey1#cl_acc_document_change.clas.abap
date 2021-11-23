class /EY1/CL_ACC_DOCUMENT_CHANGE definition
  public
  final
  create public .

*"* public components of class /EY1/CL_ACC_DOCUMENT_CHANGE
*"* do not include other source files here!!!
public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ACC_DOCUMENT .
protected section.
*"* protected components of class /EY1/CL_ACC_DOCUMENT_CHANGE
*"* do not include other source files here!!!

  methods CHANGE_ACCHD
    importing
      !IS_ACC_DOC_EX type FINS_CFIN_EX_BADI_DOCADDFIELDS
    changing
      !CS_ACCHD type ACCHD .
  methods CHANGE_ACCIT
    importing
      !IS_ACC_DOC_EX type FINS_CFIN_EX_BADI_DOCADDFIELDS
    changing
      !CS_LINE type ACCIT .
  methods CHANGE_ACCCR
    importing
      !IS_ACCIT type ACCIT
      !IS_ACC_DOC_EX type FINS_CFIN_EX_BADI_DOCADDFIELDS
    changing
      !CS_LINE type ACCCR .
  methods FILL_BAPI_MISSING_FIELDS
    importing
      !IT_EXTENSION type BAPIPAREX_TAB_AC
    changing
      !CS_ACCHD type ACCHD
      !CT_ACCIT type ACCIT_TAB
      !CT_ACCCR type ACCCR_TAB
      !CT_ACCWT type ACCWT_TAB
      !CT_MSG type BAPIRET2_T .
private section.
*"* private components of class /EY1/CL_ACC_DOCUMENT_CHANGE
*"* do not include other source files here!!!
ENDCLASS.



CLASS /EY1/CL_ACC_DOCUMENT_CHANGE IMPLEMENTATION.


method CHANGE_ACCCR.
  CS_LINE-AWREF = IS_ACCIT-AWREF.
  CS_LINE-AWORG = IS_ACCIT-AWORG.
endmethod.


  method CHANGE_ACCHD.
    IF is_acc_doc_ex-obj_key IS NOT INITIAL.
      cf_fins_cfin_ex_services=>get_instance( )->acc_objectkey_split(
        EXPORTING
          id_awkey = is_acc_doc_ex-obj_key
        IMPORTING
          ed_awref = cs_acchd-awref
          ed_aworg = cs_acchd-aworg
        EXCEPTIONS
          OTHERS   = 0 ).
    ENDIF.

  endmethod.


METHOD change_accit.
  IF is_acc_doc_ex-obj_key IS NOT INITIAL.
    cf_fins_cfin_ex_services=>get_instance( )->acc_objectkey_split(
      EXPORTING
        id_awkey = is_acc_doc_ex-obj_key
      IMPORTING
        ed_awref = cs_line-awref
        ed_aworg = cs_line-aworg
      EXCEPTIONS
        OTHERS   = 0 ).
  ENDIF.

  cs_line-logsystem_sender = is_acc_doc_ex-logsystem_sender.
  cs_line-bukrs_sender     = is_acc_doc_ex-bukrs_sender.
  cs_line-belnr_sender     = is_acc_doc_ex-belnr_sender.
  cs_line-gjahr_sender     = is_acc_doc_ex-gjahr_sender.
  cs_line-buzei_sender     = is_acc_doc_ex-buzei_sender.
  cs_line-racct_sender     = is_acc_doc_ex-racct_sender.
  cs_line-accasty_sender   = is_acc_doc_ex-accasty_sender.
  cs_line-accas_sender     = is_acc_doc_ex-accas_sender.
  cs_line-zeile            = cs_line-posnr_sd.
  cs_line-rebzg = is_acc_doc_ex-rebzg.
  cs_line-rebzz = is_acc_doc_ex-rebzz.
  cs_line-rebzj = is_acc_doc_ex-rebzj.
  cs_line-rebzt = 'A'.
  cs_line-rebzg_check = 'N'.
  cs_line-zbfix            = is_acc_doc_ex-zbfix.

ENDMETHOD.


METHOD fill_bapi_missing_fields.

  TYPES:
    BEGIN OF lty_s_idx,
      posnr TYPE posnr_acc,
      idx   TYPE i,
    END OF lty_s_idx,
    lty_ts_idx TYPE SORTED TABLE OF lty_s_idx WITH NON-UNIQUE KEY posnr.

  DATA:
    ls_acc_doc_ext    TYPE fins_cfin_ex_badi_docaddfields,
    ld_container(960) TYPE c,
    lf_cedoc          TYPE abap_bool,
    lv_debug          TYPE boole_d,
    lt_idx_accit      TYPE lty_ts_idx,
    lt_idx_acccr      TYPE lty_ts_idx.

  FIELD-SYMBOLS:
    <ls_accit>     LIKE LINE OF ct_accit,
    <ls_acccr>     LIKE LINE OF ct_acccr,
    <ls_accwt>     LIKE LINE OF ct_accwt,
    <ls_extension> LIKE LINE OF it_extension.



  "PRECONDITION
  CHECK it_extension[] IS NOT INITIAL.

  "Use for index tables for performance optimization
  lt_idx_accit = VALUE #( FOR <fs_accit> IN ct_accit INDEX INTO idx ( posnr = <fs_accit>-posnr idx = idx ) ).
  lt_idx_acccr = VALUE #( FOR <fs_acccr> IN ct_acccr INDEX INTO idx ( posnr = <fs_acccr>-posnr idx = idx ) ).

  "BODY
  LOOP AT it_extension ASSIGNING <ls_extension>.

      ASSIGN COMPONENT <ls_extension>-valuepart3 OF STRUCTURE cs_acchd TO FIELD-SYMBOL(<FS>).
      IF  <fs> IS ASSIGNED.
        "change the header
        <fs> = <ls_extension>-valuepart4.
      ENDIF.

      IF <fs> IS ASSIGNED.
       UNASSIGN <fs>.
      ENDIF.

      LOOP AT ct_accit ASSIGNING FIELD-SYMBOL(<cs_accit>) WHERE posnr = <ls_extension>-valuepart1.
        ASSIGN COMPONENT <ls_extension>-valuepart3 OF STRUCTURE <cs_accit> TO <FS>.
        IF <fs> IS ASSIGNED.
            <fs> = <ls_extension>-valuepart4.
        ENDIF.
      ENDLOOP.

      LOOP AT ct_acccr ASSIGNING FIELD-SYMBOL(<cs_acccr>) WHERE posnr = <ls_extension>-valuepart1.
        ASSIGN COMPONENT <ls_extension>-valuepart3 OF STRUCTURE <cs_acccr> TO <FS>.
        IF <fs> IS ASSIGNED.
            <fs> = <ls_extension>-valuepart4.
        ENDIF.
      ENDLOOP.

  ENDLOOP.

ENDMETHOD.


METHOD if_ex_acc_document~change.
  DATA:
    lo_exit TYPE REF TO badi_fins_cfin_ex_intf.

  " only proceed if this bapi has been set external as active
*  CHECK c_acchd-awtyp = if_fins_cfin_ex_intf_const=>gc_awtyp.

  fill_bapi_missing_fields(
    EXPORTING
      it_extension  = c_extension2
    CHANGING
      cs_acchd      = c_acchd
      ct_accit      = c_accit
      ct_acccr      = c_acccr
      ct_accwt      = c_accwt
      ct_msg        = c_return ).

  lo_exit = cf_fins_cfin_ex_services=>get_exit( ).
  IF lo_exit IS BOUND.
    TRY.
        CALL BADI lo_exit->fill_bapi_missing_fields
          EXPORTING
            it_extension = c_extension2
          CHANGING
            cs_acchd     = c_acchd
            ct_accit     = c_accit
            ct_acccr     = c_acccr
            ct_accwt     = c_accwt
            ct_acctx     = c_acctx
            ct_msg       = c_return.
      CATCH cx_sy_dyn_call_illegal_method .
    ENDTRY.
  ENDIF.
ENDMETHOD.


method IF_EX_ACC_DOCUMENT~FILL_ACCIT.
*  CHECK i_acchd-AWTYP = IF_FINS_CFIN_EX_INTF_CONST=>GC_AWTYP.
endmethod.
ENDCLASS.

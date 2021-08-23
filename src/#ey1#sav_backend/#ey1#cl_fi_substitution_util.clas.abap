class /EY1/CL_FI_SUBSTITUTION_UTIL definition
  public
  final
  create private .

public section.

  types:
    BEGIN OF ts_check_subs,
          field TYPE c LENGTH 50,
          buzei TYPE bseg-buzei,
          checked TYPE c LENGTH 1,
         END OF ts_check_subs .

  class-methods GET_INSTANCE
    returning
      value(RO_OBJECT) type ref to /EY1/CL_FI_SUBSTITUTION_UTIL .
  methods CHECK_ACC_LINE_ITEM
    importing
      value(IS_BKPF) type BKPF
      value(IS_BSEG) type BSEG
      value(IV_RAISE_MSG) type CHAR1 optional
    exporting
      !E_IS_LAST type CHAR1 .
protected section.
private section.

  data:
    tt_check_subs TYPE TABLE OF ts_check_subs .
  data GT_CHECK_SUBS like TT_CHECK_SUBS .
  data GV_RAISE_SPLPRD type CHAR1 .
  data GV_RAISE_LDGRP type CHAR1 .
  class-data GO_OBJECT type ref to /EY1/CL_FI_SUBSTITUTION_UTIL .

  methods CONSTRUCTOR .
ENDCLASS.



CLASS /EY1/CL_FI_SUBSTITUTION_UTIL IMPLEMENTATION.


  METHOD check_acc_line_item.

*    DATA: lv_check_splprd      TYPE c VALUE IS INITIAL,
*          lv_raise_splprd_msg  TYPE c VALUE IS INITIAL,
*          lv_raise_ldgrp_msg   TYPE c VALUE IS INITIAL.
*
*
*    CONSTANTS: c_str        TYPE string VALUE '(SAPMF05A)XBSEG[]', ##NO_TEXT
*               c_ldgrp      TYPE string VALUE 'Ledger Group', ##NO_TEXT
*               c_ldgrp1     TYPE string VALUE ' Ledger Group', ##NO_TEXT
*               c_and        TYPE string VALUE ' and ', ##NO_TEXT
*               c_splprd     TYPE string VALUE 'Special Period'.   ##NO_TEXT
*    DATA:      lv_lines     TYPE i,
*               ls_chk_subs  TYPE ts_check_subs,
*               zs_bseg      TYPE bseg,
*               lv_raise_msg TYPE c.
*
*    FIELD-SYMBOLS: <ft_bseg> TYPE ANY TABLE.
*
*    SELECT SINGLE * FROM zz1_26bf68887807
*     INTO @DATA(ls_splprd)
*     WHERE code = @is_bkpf-monat.
*    IF sy-subrc <> 0.
*      lv_check_splprd = abap_false.
*    ELSE.
*      IF is_bkpf-monat <> is_bseg-zz1_specialperiod_cob.
*        lv_raise_splprd_msg = abap_true.
*        IF gv_raise_splprd = abap_false.
*         gv_raise_splprd   = abap_true.
*        ENDIF.
*      ENDIF.
*      lv_check_splprd = abap_true.
*    ENDIF.
*
*     SELECT SINGLE * FROM zz1_61f30584e2ba
*      INTO @DATA(ls_ldgrp)
*      WHERE code = @is_bkpf-ldgrp.
*    IF sy-subrc = 0.
*      IF is_bkpf-ldgrp <> is_bseg-zz1_ledgergroup_cob.
*        lv_raise_ldgrp_msg = abap_true.
*        IF gv_raise_ldgrp = abap_false.
*          gv_raise_ldgrp = abap_true.
*        ENDIF.
*      ENDIF.
*    ENDIF.
*
*    lv_raise_msg = iv_raise_msg.
*
*    IF is_bkpf-ldgrp IS NOT INITIAL.
*    READ TABLE gt_check_subs ASSIGNING FIELD-SYMBOL(<fs_subs>)
*      WITH KEY buzei = is_bseg-buzei
*               field = 'ZZ1_LEDGERGROUP_COB'.
*    IF sy-subrc <> 0.
*      ls_chk_subs-buzei   = is_bseg-buzei.
*      ls_chk_subs-checked = abap_true.
*      ls_chk_subs-field   = 'ZZ1_LEDGERGROUP_COB'.
*      APPEND ls_chk_subs TO gt_check_subs.
*
*      IF lv_check_splprd = abap_true.
*        ls_chk_subs-buzei   = is_bseg-buzei.
*        IF is_bkpf-monat <> is_bseg-zz1_specialperiod_cob.
*         ls_chk_subs-checked = abap_false.
*        ELSE.
*         lv_raise_msg = abap_true.
*        ENDIF.
*        ls_chk_subs-field   = 'ZZ1_SPECIALPERIOD_COB'.
*        APPEND ls_chk_subs TO gt_check_subs.
*      ENDIF.
*    ELSEIF sy-subrc = 0 AND <fs_subs> IS ASSIGNED.
*      <fs_subs>-buzei   = is_bseg-buzei.
*      <fs_subs>-checked = abap_true.
*      <fs_subs>-field   = 'ZZ1_LEDGERGROUP_COB'.
*
*      IF lv_check_splprd = abap_true.
*      READ TABLE gt_check_subs ASSIGNING FIELD-SYMBOL(<fs_subs1>)
*      WITH KEY buzei = is_bseg-buzei
*               field = 'ZZ1_SPECIALPERIOD_COB'.
*      IF sy-subrc = 0 AND <fs_subs1> IS ASSIGNED.
*        <fs_subs1>-buzei   = is_bseg-buzei.
*        IF iv_raise_msg = abap_true.
*          <fs_subs1>-checked = abap_true.
*        ELSE.
*          IF is_bkpf-monat <> is_bseg-zz1_specialperiod_cob.
*           IF is_bkpf-ldgrp = is_bseg-zz1_ledgergroup_cob.
*             <fs_subs1>-checked = abap_true.
*           ELSE.
*            <fs_subs1>-checked = abap_false.
*           ENDIF.
*          ELSE.
*            <fs_subs1>-checked = abap_true.
*            lv_raise_msg = abap_true.
*          ENDIF.
*        ENDIF.
*
*        <fs_subs1>-field   = 'ZZ1_SPECIALPERIOD_COB'.
*      ELSEIF sy-subrc <> 0.
*        ls_chk_subs-buzei   = is_bseg-buzei.
*        IF is_bkpf-monat <> is_bseg-zz1_specialperiod_cob.
*         IF is_bkpf-ldgrp = is_bseg-zz1_ledgergroup_cob.
*           ls_chk_subs-checked = abap_true.
*         ELSE.
*          ls_chk_subs-checked = abap_false.
*         ENDIF.
*        ELSE.
*         ls_chk_subs-checked = abap_true.
*         lv_raise_msg = abap_true.
*        ENDIF.
*        ls_chk_subs-field   = 'ZZ1_SPECIALPERIOD_COB'.
*        APPEND ls_chk_subs TO gt_check_subs.
*      ENDIF.
*     ENDIF.
*    ENDIF.
*    ELSE.
*      READ TABLE gt_check_subs ASSIGNING <fs_subs>
*      WITH KEY buzei = is_bseg-buzei
*               field = 'ZZ1_SPECIALPERIOD_COB'.
*      IF sy-subrc = 0.
*        IF <fs_subs> IS ASSIGNED.
*          <fs_subs>-checked = abap_true.
*        ENDIF.
*      ELSE.
*        ls_chk_subs-buzei   = is_bseg-buzei.
*        ls_chk_subs-checked = abap_true.
*        ls_chk_subs-field   = 'ZZ1_SPECIALPERIOD_COB'.
*        APPEND ls_chk_subs TO gt_check_subs.
*      ENDIF.
*    ENDIF.
*
*    ASSIGN (c_str) TO <ft_bseg>.
*    IF <ft_bseg> IS ASSIGNED.
*    IF lv_check_splprd EQ abap_false.
*      lv_raise_msg = abap_true.
*    ENDIF.
*    LOOP AT <ft_bseg> INTO zs_bseg.
*      IF is_bkpf-ldgrp IS NOT INITIAL.
*        IF lv_check_splprd = abap_false.
*          IF ( zs_bseg-zz1_ledgergroup_cob IS INITIAL AND gv_raise_ldgrp IS NOT INITIAL ) AND is_bseg-buzei <> zs_bseg-buzei.
*            lv_raise_msg = abap_false.
*            EXIT.
*          ENDIF.
*        ELSE.
*          IF ( ( zs_bseg-zz1_ledgergroup_cob IS INITIAL AND gv_raise_ldgrp IS NOT INITIAL )
*            OR ( zs_bseg-zz1_specialperiod_cob IS INITIAL AND gv_raise_splprd IS NOT INITIAL ) ) AND is_bseg-buzei <> zs_bseg-buzei.
*            lv_raise_msg = abap_false.
*            EXIT.
*          ENDIF.
*        ENDIF.
*      ELSE.
*        IF ( zs_bseg-zz1_specialperiod_cob IS INITIAL AND gv_raise_splprd IS NOT INITIAL ) AND is_bseg-buzei <> zs_bseg-buzei.
*          lv_raise_msg = abap_false.
*          EXIT.
*        ENDIF.
*      ENDIF.
*    ENDLOOP.
*    ENDIF.
*
*    e_is_last = abap_false.
*
*    IF <ft_bseg> IS ASSIGNED.
*      IF <ft_bseg> IS NOT INITIAL.
*        DESCRIBE TABLE <ft_bseg> LINES lv_lines.
*      ENDIF.
*      IF lv_lines IS NOT INITIAL AND lv_lines = is_bseg-buzei.
*        e_is_last = abap_true.
*        LOOP AT gt_check_subs TRANSPORTING NO FIELDS WHERE checked = abap_false.
*          EXIT.
*        ENDLOOP.
*        IF sy-subrc <> 0.
*          IF lv_raise_msg = abap_true.
*           IF gv_raise_splprd EQ abap_true AND gv_raise_ldgrp EQ abap_true.
*              MESSAGE i032(/ey1/sav_savotta) WITH c_splprd c_and space c_ldgrp1. ##MG_MISSING
*           ELSEIF gv_raise_splprd EQ abap_true AND gv_raise_ldgrp EQ abap_false.
*              MESSAGE i032(/ey1/sav_savotta) WITH c_splprd. ##MG_MISSING
*           ELSEIF gv_raise_splprd EQ abap_false AND gv_raise_ldgrp EQ abap_true.
*              MESSAGE i032(/ey1/sav_savotta) WITH c_ldgrp. ##MG_MISSING
*           ENDIF.
*           CLEAR: gv_raise_splprd, gv_raise_ldgrp.
*          ENDIF.
*        ENDIF.
*      ELSE.
*        LOOP AT gt_check_subs TRANSPORTING NO FIELDS WHERE checked = abap_false.
*          EXIT.
*        ENDLOOP.
*        IF sy-subrc <> 0.
*          IF lv_raise_msg = abap_true.
*            IF gv_raise_splprd EQ abap_true AND gv_raise_ldgrp EQ abap_true.
*               MESSAGE i032(/ey1/sav_savotta) WITH c_splprd c_and space c_ldgrp1. ##MG_MISSING
*            ELSEIF gv_raise_splprd EQ abap_true AND gv_raise_ldgrp EQ abap_false.
*               MESSAGE i032(/ey1/sav_savotta) WITH c_splprd. ##MG_MISSING
*            ELSEIF gv_raise_splprd EQ abap_false AND gv_raise_ldgrp EQ abap_true.
*               MESSAGE i032(/ey1/sav_savotta) WITH c_ldgrp. ##MG_MISSING
*            ENDIF.
*            CLEAR: gv_raise_splprd, gv_raise_ldgrp.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  method CONSTRUCTOR.
  endmethod.


  METHOD get_instance.

    IF go_object IS NOT INITIAL.
      ro_object = go_object.
    ELSE.
      CREATE OBJECT go_object.
      ro_object = go_object.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

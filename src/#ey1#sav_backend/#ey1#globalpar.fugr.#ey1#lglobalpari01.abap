
*----------------------------------------------------------------------*
***INCLUDE /EY1/LGLOBALPARO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module HIDE_FIELDS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE hide_fields OUTPUT.
FIELD-SYMBOLS: <fs_cols> LIKE LINE OF tctrl_/ey1/globalparam-cols.
 LOOP AT tctrl_/ey1/globalparam-cols ASSIGNING <fs_cols>.
   CASE <fs_cols>-screen-name.
   	WHEN '/EY1/GLOBALPARAM-LOCAL_CURRENCY_TYPE' OR '/EY1/GLOBALPARAM-GROUP_CURRENCY' OR '/EY1/GLOBALPARAM-GROUP_CURRENCY_TYPE'.
      <fs_cols>-invisible = 'X'.
    WHEN '/EY1/GLOBALPARAM-PERIOD_FROM'.
      <fs_cols>-screen-input = 0.
    WHEN '/EY1/GLOBALPARAM-RVERS'.
      <fs_cols>-invisible = 'X'.
   	WHEN OTHERS.
   ENDCASE.
 ENDLOOP.

ENDMODULE.


MODULE change_data OUTPUT.
  TYPES BEGIN OF total_s1.
           INCLUDE STRUCTURE /EY1/GLOBALPARAM.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s1.

  DATA: lt_total TYPE TABLE OF total_s1.
  FIELD-SYMBOLS: <fs_total1> TYPE total_s1.

  IF sy-ucomm <> 'NEWL'.
  REFRESH: lt_total.
  LOOP AT total ASSIGNING <fs_total1> CASTING.
     APPEND <fs_total1> TO lt_total.
  ENDLOOP.

  SELECT * FROM /ey1/f4_intnt
      INTO TABLE @DATA(lt_tab)
      FOR ALL ENTRIES IN @lt_total
      WHERE bunit  = @lt_total-bunit
      AND   gjahr  = @lt_total-ryear
      AND   intent = @lt_total-intention.

  IF lt_tab[] IS NOT INITIAL.
  LOOP AT total ASSIGNING <fs_total1> CASTING.

      READ TABLE lt_tab INTO DATA(ls_tab)
       WITH KEY bunit = <fs_total1>-bunit
                gjahr = <fs_total1>-ryear
                intent = <fs_total1>-intention.
    IF sy-subrc <> 0.
    SELECT SINGLE Intention FROM /ey1/f4_intnt
      INTO <fs_total1>-intention
      WHERE intent = <fs_total1>-intention.
    ELSEIF sy-subrc = 0.
      <fs_total1>-intention = ls_tab-intention.
    ENDIF.
  ENDLOOP.


  extract[] = total[].
  ENDIF.
  ENDIF.

  MODIFY SCREEN.
ENDMODULE.


FORM /EY1/UPDATE_PERIOD.
 TYPES BEGIN OF total_s9.
           INCLUDE STRUCTURE /EY1/GLOBALPARAM.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s9.

  FIELD-SYMBOLS: <fs_total9> TYPE total_s9.

  IF sy-ucomm = 'KOPF'.
    LOOP AT extract ASSIGNING <fs_total9> CASTING.
      IF <fs_total9>-uname IS NOT INITIAL.
        SELECT SINGLE intention
          FROM /ey1/f4_intnt
          INTO <fs_total9>-intention
          WHERE bunit  = <fs_total9>-bunit
          AND   gjahr  = <fs_total9>-ryear
          AND   status = 'Open'.
      ENDIF.
    ENDLOOP.
  ENDIF.
*
*  FIELD-SYMBOLS: <fs_perf> TYPE any,
*                 <fs_pert> TYPE any,
*                 <fs_int>  TYPE any.
*  DATA: lv_per   TYPE /ey1/intention-periodto,
*        lv_chk   TYPE c.
*
*  CLEAR lv_chk.
*  ASSIGN COMPONENT 'INTENTION' OF STRUCTURE <vim_total_struc> TO <fs_int>.
*  ASSIGN COMPONENT 'PERIOD_FROM' OF STRUCTURE <vim_total_struc> TO <fs_perf>.
*  ASSIGN COMPONENT 'PERIOD_TO' OF STRUCTURE <vim_total_struc> TO <fs_pert>.
*  IF <fs_int> IS ASSIGNED AND <fs_perf> IS ASSIGNED AND <fs_pert> IS ASSIGNED.
*    LOOP AT total ASSIGNING <fs_total> CASTING.
*     IF <fs_total>-vim_action = 'U' OR <fs_total>-vim_action = 'N' OR <fs_total>-vim_action = ''.
*      IF <fs_total>-intention <> 'PER'.
*      SELECT SINGLE PERIODTO FROM /ey1/intention
*       INTO lv_per
*       WHERE intent = <fs_total>-intention.
*      IF sy-subrc = 0.
*        <fs_total>-period_from = 1.
*        <fs_total>-period_to = lv_per.
*        <fs_int> = lv_per.
*      ENDIF.
*      ENDIF.
*
*
*      SELECT SINGLE * FROM FINCS_GRPSTR
*        INTO @DATA(ls_config)
*        WHERE bunit = @<fs_total>-bunit
*        AND   congr = @<fs_total>-congr.
*      IF sy-subrc <> 0.
*        lv_chk = 'X'.
*      ENDIF.
*
*      IF <fs_total>-vim_action = 'N' OR <fs_total>-vim_action = space.
*        /ey1/globalparam-period_from = 1.
*        IF /ey1/globalparam-intention <> 'PER'.
*          SELECT SINGLE PERIODTO FROM /ey1/intention
*           INTO /ey1/globalparam-period_to
*           WHERE intent = /ey1/globalparam-intention.
*          IF sy-subrc = 0.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*
*     ENDIF.
*
*    ENDLOOP.
*
*    IF lv_chk = 'X'.
*       MESSAGE e031(/ey1/sav_savotta) WITH /ey1/globalparam-congr /ey1/globalparam-bunit DISPLAY LIKE 'E'.
**      DATA: zv_str TYPE string.
**      CONCATENATE 'Consolidation Group' space /ey1/globalparam-congr space 'has no mapping with Consolidation Unit '
**       space /ey1/globalparam-bunit INTO zv_str.
**      MESSAGE zv_str TYPE 'E' DISPLAY LIKE 'E'.
*      "RETURN.
*    ENDIF.
*
*  ENDIF.

ENDFORM.

FORM REFRESH_SCREEN.

   extract[] = total[].

ENDFORM.
*&---------------------------------------------------------------------*
*&      Module  SCREEN_FIELD_VALUE_MODF  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE screen_field_value_modf INPUT.
 TYPES BEGIN OF total_s.
           INCLUDE STRUCTURE /EY1/GLOBALPARAM.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s.

  FIELD-SYMBOLS: <fs_total> TYPE total_s1.
  DATA: lv_per   TYPE /ey1/intention-periodto,
        lv_chk   TYPE c,
        lv_changed TYPE c VALUE IS INITIAL.

  DATA: lv_bunit TYPE /ey1/globalparam-bunit,
        lv_congr TYPE /ey1/globalparam-congr,
        lv_curr  TYPE /ey1/globalparam-group_currency.

    CLEAR: lv_chk,lv_changed.
    LOOP AT total ASSIGNING <fs_total> CASTING.
      IF <fs_total>-intention <> 'PER'.
        SELECT SINGLE PERIODTO FROM /ey1/intention
         INTO lv_per
         WHERE intent = <fs_total>-intention.
        IF sy-subrc = 0.
          lv_changed = 'X'.
          <fs_total>-period_to = lv_per.
        ENDIF.
      ENDIF.

      IF <fs_total>-uname IS NOT INITIAL.
        SELECT SINGLE * FROM FINCS_GRPSTR
          INTO @DATA(ls_config)
          WHERE bunit = @<fs_total>-bunit
          AND   congr = @<fs_total>-congr.
        IF sy-subrc <> 0.
          lv_bunit = <fs_total>-bunit.
          lv_congr = <fs_total>-congr.
          lv_chk = 'X'.
          EXIT.
        ENDIF.
      ENDIF.
    ENDLOOP.

    IF lv_chk = 'X' AND sy-ucomm <> 'SAVE'.
      MESSAGE i031(/ey1/sav_savotta) WITH lv_congr lv_bunit DISPLAY LIKE 'E'.
    ELSEIF sy-ucomm = 'SAVE' AND lv_chk = 'X'.
      CLEAR: sy-ucomm, function.
      MESSAGE i031(/ey1/sav_savotta) WITH lv_congr lv_bunit DISPLAY LIKE 'E'.
    ENDIF.


    "Currency Check
    CLEAR lv_chk.
    LOOP AT total ASSIGNING <fs_total> CASTING.
     IF <fs_total>-uname IS NOT INITIAL.
      SELECT consolidationunit,currencytype,currency
       FROM /EY1/SAV_C_CurrLocalGroupVH
       INTO TABLE @DATA(lt_currency)
       WHERE consolidationunit = @<fs_total>-bunit
       AND   currency = @<fs_total>-local_currency.
      IF sy-subrc <> 0.
        lv_chk = 'X'.
        lv_bunit = <fs_total>-bunit.
        lv_curr  = <fs_total>-local_currency.
        EXIT.
      ENDIF.
     ENDIF.
    ENDLOOP.

    IF lv_chk = 'X'.
      CLEAR: sy-ucomm, function.
      MESSAGE i033(/ey1/sav_savotta) WITH lv_curr lv_bunit DISPLAY LIKE 'E'.
    ENDIF.
    IF lv_changed IS NOT INITIAL.
     extract[] = total[].
    ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_SCREEN_VISIBILITY OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_screen_visibility OUTPUT.

  TYPES BEGIN OF total_s2.
           INCLUDE STRUCTURE /EY1/GLOBALPARAM.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s2.

  FIELD-SYMBOLS: <fs_extract> TYPE total_s2,
                 <fs_cols1>    LIKE LINE OF tctrl_/ey1/globalparam-cols.

  ASSIGN extract TO <fs_extract> CASTING.


    LOOP AT SCREEN.
      IF screen-name = '/EY1/GLOBALPARAM-PERIOD_TO'.
        IF <fs_extract>-intention CS 'PERIODIC' OR <fs_extract>-intention CS 'PER' .
           screen-input = 1.
        ELSE.
         screen-input = 0.
        ENDIF.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

ENDMODULE.


MODULE change_data_after_input INPUT.
  TYPES BEGIN OF total_s3.
           INCLUDE STRUCTURE /EY1/GLOBALPARAM.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s3.

*  FIELD-SYMBOLS: <fs_perf> TYPE any,
*                 <fs_pert> TYPE any,
*                 <fs_int>  TYPE any.
  FIELD-SYMBOLS: <fs_total3> TYPE total_s3.
  DATA:ft_total3 TYPE TABLE OF /ey1/globalparam,
       ls_glbparam TYPE /ey1/globalparam.
  FIELD-SYMBOLS: <fs_total14> TYPE total_s3.


  IF sy-ucomm = 'SAVE'.

    LOOP AT total ASSIGNING <fs_total14> CASTING.
      MOVE-CORRESPONDING <fs_total14> TO ls_glbparam.
      APPEND ls_glbparam TO ft_total3.
    ENDLOOP.

    SELECT * FROM /ey1/globalparam
      INTO TABLE @DATA(zzt_tab)
      FOR ALL ENTRIES IN @ft_total3
      WHERE uname = @ft_total3-uname
      AND   bunit = @ft_total3-bunit.
    LOOP AT extract ASSIGNING <fs_total3> CASTING.
      IF <fs_total3>-uname IS NOT INITIAL.
        SELECT SINGLE intent from /ey1/f4_intnt
              INTO <fs_total3>-intention
              WHERE gjahr     = <fs_total3>-ryear
              AND   bunit     = <fs_total3>-bunit
              AND   intention = <fs_total3>-intention.
      IF sy-subrc <> 0.
      SELECT SINGLE Intent FROM /ey1/f4_intnt
        INTO <fs_total3>-intention
        WHERE intention = <fs_total3>-intention.
      ELSE.
        LOOP AT total ASSIGNING <fs_total14> CASTING.
          IF <fs_total14>-uname = <fs_total3>-uname
            AND <fs_total14>-bunit = <fs_total3>-bunit.
            MOVE-CORRESPONDING <fs_total3> TO <fs_total14>.
            READ TABLE zzt_tab TRANSPORTING NO FIELDS WITH KEY bunit = <fs_total3>-bunit
                                                               uname = <fs_total3>-uname.
            IF sy-subrc <> 0.
              <fs_total3>-vim_action = 'N'.
              <fs_total14>-vim_action = 'N'.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
      ENDIF.
    ENDLOOP.

  TYPES BEGIN OF total_snew.
           INCLUDE STRUCTURE /ey1/globalparam.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_snew.
  FIELD-SYMBOLS: <fs_totalnew>  TYPE total_snew.
  FIELD-SYMBOLS: <fs_totalnew1> TYPE total_snew.
  LOOP AT total ASSIGNING <fs_totalnew> CASTING.
    IF <fs_totalnew>-userdefault = 'X'.
      LOOP AT total ASSIGNING <fs_totalnew1> CASTING.
        IF <fs_totalnew1>-uname = <fs_totalnew>-uname AND
           <fs_totalnew1>-bunit <> <fs_totalnew>-bunit AND
           <fs_totalnew1>-userdefault = 'X'.
           CLEAR: sy-ucomm, function.
           MESSAGE i038(/ey1/sav_savotta) WITH <fs_totalnew>-uname DISPLAY LIKE 'E'.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDLOOP.

  DATA: lv_skip_error TYPE c VALUE IS INITIAL.
  SELECT * FROM /ey1/globalparam INTO TABLE @DATA(zlt_tab).
  IF sy-subrc = 0.
    LOOP AT extract ASSIGNING <fs_totalnew> CASTING.
      CLEAR: lv_skip_error.
      IF <fs_totalnew>-userdefault = 'X'.
       LOOP AT extract ASSIGNING <fs_totalnew1> CASTING.
         IF <fs_totalnew1>-uname = <fs_totalnew>-uname
           AND <fs_totalnew1>-bunit <> <fs_totalnew>-bunit
           AND <Fs_totalnew1>-userdefault = ' '.
           lv_skip_error = 'X'.
         ENDIF.
       ENDLOOP.
       IF lv_skip_error = ' '.
        LOOP AT zlt_tab TRANSPORTING NO FIELDS WHERE uname = <fs_totalnew>-uname
                                               AND   bunit <> <fs_totalnew>-bunit
                                               AND   userdefault = 'X'.
           CLEAR: sy-ucomm, function.
           MESSAGE i038(/ey1/sav_savotta) WITH <fs_totalnew>-uname DISPLAY LIKE 'E'.
        ENDLOOP.
       ENDIF.
      ENDIF.
    ENDLOOP.
  ENDIF.
    "total[] = extract[].
  ELSEIF sy-ucomm = 'KOPE'. "Copy As
    LOOP AT extract ASSIGNING <fs_total14> CASTING.
      IF <fs_total14>-uname IS NOT INITIAL.
        CLEAR: <fs_total14>-intention, <fs_total14>-period_to, <fs_total14>-local_currency.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  UPDATE_DATA_IN_LOOP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE update_data_in_loop INPUT.
 TYPES BEGIN OF total_s4.
           INCLUDE STRUCTURE /ey1/globalparam.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s4.

  FIELD-SYMBOLS: <fs_total4> TYPE total_s4,
                 <fs_total5> TYPE total_s4.

  DATA: lv_found TYPE c VALUE IS INITIAL.

  ASSIGN extract TO <fs_total4> CASTING.
  IF <fs_total4> IS ASSIGNED AND <status>-upd_flag = 'X'
    AND <fs_total4>-ryear <> /ey1/globalparam-ryear.

    SELECT SINGLE a~intention, b~periodto
      FROM /ey1/f4_intnt AS a
      INNER JOIN /ey1/intention AS b
      ON a~intent = b~intent
      INTO ( @<fs_total4>-intention , @<fs_total4>-period_to )
      WHERE bunit  = @/ey1/globalparam-bunit
      AND   gjahr  = @/ey1/globalparam-ryear
      AND   status = 'Open'.
   IF sy-subrc <> 0.
     CLEAR: <fs_total4>-intention , <fs_total4>-period_to.
   ELSE.
     <fs_total4>-period_from = '1'.
   ENDIF.
   /ey1/globalparam-period_from = <fs_total4>-period_from.
   /ey1/globalparam-period_to = <fs_total4>-period_to.
   /ey1/globalparam-intention = <fs_total4>-intention.
   /ey1/globalparam-userdefault = <fs_total4>-userdefault.

   CLEAR: lv_found.
   LOOP AT extract ASSIGNING <fs_total5> CASTING.
     DATA(lv_tab) = sy-tabix.
     IF <fs_total5>-uname = /ey1/globalparam-uname
       AND <fs_total5>-bunit = /ey1/globalparam-bunit.
       lv_found = 'X'.
       EXIT.
     ENDIF.
   ENDLOOP.
   IF lv_found = 'X'.
   total = extract.
   MODIFY: total[] FROM total INDEX lv_tab ,extract[] FROM extract INDEX lv_tab.
   ENDIF.
   CLEAR lv_tab.
  ENDIF.


ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SET_STATUS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_status OUTPUT.

DATA: lt_fcode TYPE TABLE OF sy-ucomm,
      wa_fcode TYPE sy-ucomm.

IF sy-ucomm = 'NEWL'.
   CLEAR: wa_fcode.
   REFRESH: lt_fcode.
   wa_fcode = 'NEWL'.
   APPEND wa_fcode TO lt_fcode.
   wa_fcode = 'FILT'.
   APPEND wa_fcode TO lt_fcode.
   SET PF-STATUS 'ZEULG' EXCLUDING lt_fcode.
ELSE.
   SET PF-STATUS 'ZEULG'.
ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command INPUT.
  DATA: BEGIN OF lr_bunit OCCURS 1,
          sign       TYPE c LENGTH 1,
          option     TYPE c LENGTH 2,
          low        TYPE fc_bunit,
          high       TYPE fc_bunit,
        END OF lr_bunit,
        BEGIN OF lr_user OCCURS 1,
          sign       TYPE c LENGTH 1,
          option     TYPE c LENGTH 2,
          low        TYPE uname,
          high       TYPE uname,
        END OF lr_user,
        BEGIN OF lr_year OCCURS 1,
          sign       TYPE c LENGTH 1,
          option     TYPE c LENGTH 2,
          low        TYPE gjahr,
          high       TYPE gjahr,
        END OF lr_year.

  TYPES BEGIN OF total_s19.
           INCLUDE STRUCTURE /ey1/globalparam.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s19.

  FIELD-SYMBOLS: <fs_total_19> TYPE total_s19.
  DATA: lt_tab_19 TYPE TABLE OF total_s19.

  IF sy-ucomm = 'SORT'.
    CALL SCREEN '0005' STARTING AT 10 10 ENDING AT 40 40.
    IF gv_sort = 'X'.
      LOOP AT extract ASSIGNING <fs_total_19> CASTING.
        APPEND <fs_total_19> TO lt_tab_19.
      ENDLOOP.
      CASE /ey1/fieldname.
        WHEN '1'.
          SORT lt_tab_19 BY uname DESCENDING.
        WHEN '2'.
          SORT lt_tab_19 BY bunit DESCENDING.
        WHEN '3'.
          SORT lt_tab_19 BY congr DESCENDING.
        WHEN '4'.
          SORT lt_tab_19 BY ryear DESCENDING.
        WHEN '5'.
          SORT lt_tab_19 BY intention DESCENDING.
        WHEN '6'.
          SORT lt_tab_19 BY itclg DESCENDING.
        WHEN '7'.
          SORT lt_tab_19 BY local_currency DESCENDING.
        WHEN OTHERS.
      ENDCASE.
      REFRESH: extract[], total[].
      extract[] = lt_tab_19.
      total[] = extract[].
    ENDIF.
  ELSEIF sy-ucomm = 'FILT'.
     CALL SCREEN '0006' STARTING AT 10 10 ENDING AT 60 60.
     IF gv_filter = abap_true.
        REFRESH: lt_tab_19[], lr_bunit[], lr_user[], lr_year[].
        CLEAR: lr_bunit, lr_user, lr_year.
        LOOP AT extract ASSIGNING <fs_total_19> CASTING.
          APPEND <fs_total_19> TO lt_tab_19.
        ENDLOOP.
        IF /ey1/bunit IS NOT INITIAL.
         lr_bunit-sign = 'I'.
         lr_bunit-option = 'EQ'.
         lr_bunit-low = /ey1/bunit.
         APPEND lr_bunit.
        ENDIF.
        IF /ey1/username IS NOT INITIAL.
         lr_user-sign = 'I'.
         lr_user-option = 'EQ'.
         lr_user-low = /ey1/username.
         APPEND lr_user.
        ENDIF.
        IF /ey1/ryear IS NOT INITIAL.
         lr_year-sign = 'I'.
         lr_year-option = 'EQ'.
         lr_year-low = /ey1/ryear.
         APPEND lr_year.
        ENDIF.
        SELECT * FROM /ey1/globalparam
          INTO CORRESPONDING FIELDS OF TABLE lt_tab_19
          WHERE bunit IN lr_bunit
          AND   uname IN lr_user
          AND   ryear IN lr_year.
        IF sy-subrc = 0.
        ENDIF.
        extract[] = lt_tab_19.
        total[] = extract[].
     ENDIF.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0005  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0005 INPUT.
 IF sy-ucomm = 'CONT'.
   gv_sort = 'X'.
   LEAVE TO SCREEN 0.
 ELSE.
   CLEAR gv_sort.
   LEAVE TO SCREEN 0.
 ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module FILL_DROPDOWN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE fill_dropdown OUTPUT.

  TYPE-POOLS : VRM.
  DATA: ld_field    TYPE VRM_ID VALUE '/EY1/FIELDNAME',
        it_listbox  TYPE VRM_VALUES,
        wa_listbox  LIKE LINE OF it_listbox.

    REFRESH: it_listbox.
    wa_listbox-key = '1'.
    wa_listbox-text = 'User Name'.
    APPEND wa_listbox TO it_listbox.

    wa_listbox-key = '2'.
    wa_listbox-text = 'Consolidation Unit'.
    APPEND wa_listbox TO it_listbox.


    wa_listbox-key = '3'.
    wa_listbox-text = 'Consolidation Group'.
    APPEND wa_listbox TO it_listbox.

    wa_listbox-key = '4'.
    wa_listbox-text = 'Year'.
    APPEND wa_listbox TO it_listbox.

    wa_listbox-key = '5'.
    wa_listbox-text = 'Intention'.
    APPEND wa_listbox TO it_listbox.

    wa_listbox-key = '6'.
    wa_listbox-text = 'Cons. COA'.
    APPEND wa_listbox TO it_listbox.

    wa_listbox-key = '7'.
    wa_listbox-text = 'Currency'.
    APPEND wa_listbox TO it_listbox.

    ld_field = '/EY1/FIELDNAME'.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id     = ld_field
        values = it_listbox.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0006  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0006 INPUT.
 IF sy-ucomm = 'CONT'.
   gv_filter = 'X'.
   LEAVE TO SCREEN 0.
 ELSE.
   CLEAR gv_filter.
   LEAVE TO SCREEN 0.
 ENDIF.
ENDMODULE.

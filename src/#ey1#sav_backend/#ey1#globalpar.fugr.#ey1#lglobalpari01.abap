
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

  LOOP AT total ASSIGNING <fs_total1> CASTING.
     APPEND <fs_total1> TO lt_total.
  ENDLOOP.

  SELECT * FROM /ey1/f4_intnt
      INTO TABLE @DATA(lt_tab)
      FOR ALL ENTRIES IN @lt_total
      WHERE bunit  = @lt_total-bunit
      AND   gjahr  = @lt_total-ryear
      AND   intent = @lt_total-intention.

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

  MODIFY SCREEN.
ENDMODULE.


FORM /EY1/UPDATE_PERIOD.

  TYPES BEGIN OF total_s.
           INCLUDE STRUCTURE /EY1/GLOBALPARAM.
           INCLUDE STRUCTURE vimtbflags.
  TYPES END OF total_s.


  FIELD-SYMBOLS: <fs_perf> TYPE any,
                 <fs_pert> TYPE any,
                 <fs_int>  TYPE any.
  FIELD-SYMBOLS: <fs_total> TYPE total_s.
  DATA: lv_per   TYPE /ey1/intention-periodto,
        lv_chk   TYPE c.

  CLEAR lv_chk.
  ASSIGN COMPONENT 'INTENTION' OF STRUCTURE <vim_total_struc> TO <fs_int>.
  ASSIGN COMPONENT 'PERIOD_FROM' OF STRUCTURE <vim_total_struc> TO <fs_perf>.
  ASSIGN COMPONENT 'PERIOD_TO' OF STRUCTURE <vim_total_struc> TO <fs_pert>.
  IF <fs_int> IS ASSIGNED AND <fs_perf> IS ASSIGNED AND <fs_pert> IS ASSIGNED.
    LOOP AT total ASSIGNING <fs_total> CASTING.
     IF <fs_total>-vim_action = 'U' OR <fs_total>-vim_action = 'N' OR <fs_total>-vim_action = ''.
      IF <fs_total>-intention <> 'PER'.
      SELECT SINGLE PERIODTO FROM /ey1/intention
       INTO lv_per
       WHERE intent = <fs_total>-intention.
      IF sy-subrc = 0.
        <fs_total>-period_from = 1.
        <fs_total>-period_to = lv_per.
        <fs_int> = lv_per.
      ENDIF.
      ENDIF.


      SELECT SINGLE * FROM FINCS_GRPSTR
        INTO @DATA(ls_config)
        WHERE bunit = @<fs_total>-bunit
        AND   congr = @<fs_total>-congr.
      IF sy-subrc <> 0.
        lv_chk = 'X'.
      ENDIF.

      IF <fs_total>-vim_action = 'N' OR <fs_total>-vim_action = space.
        /ey1/globalparam-period_from = 1.
        IF /ey1/globalparam-intention <> 'PER'.
          SELECT SINGLE PERIODTO FROM /ey1/intention
           INTO /ey1/globalparam-period_to
           WHERE intent = /ey1/globalparam-intention.
          IF sy-subrc = 0.
          ENDIF.
        ENDIF.
      ENDIF.

     ENDIF.

    ENDLOOP.

    IF lv_chk = 'X'.
       MESSAGE e031(/ey1/sav_savotta) WITH /ey1/globalparam-congr /ey1/globalparam-bunit DISPLAY LIKE 'E'.
*      DATA: zv_str TYPE string.
*      CONCATENATE 'Consolidation Group' space /ey1/globalparam-congr space 'has no mapping with Consolidation Unit '
*       space /ey1/globalparam-bunit INTO zv_str.
*      MESSAGE zv_str TYPE 'E' DISPLAY LIKE 'E'.
      "RETURN.
    ENDIF.

  ENDIF.
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
        lv_chk   TYPE c.

  DATA: lv_bunit TYPE /ey1/globalparam-bunit,
        lv_congr TYPE /ey1/globalparam-congr,
        lv_curr  TYPE /ey1/globalparam-group_currency.

    CLEAR: lv_chk.
    LOOP AT total ASSIGNING <fs_total> CASTING.
      IF <fs_total>-intention <> 'PER'.
        SELECT SINGLE PERIODTO FROM /ey1/intention
         INTO lv_per
         WHERE intent = <fs_total>-intention.
        IF sy-subrc = 0.
          <fs_total>-period_to = lv_per.
        ENDIF.
      ENDIF.


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
    ENDLOOP.

    IF lv_chk = 'X'.
      CLEAR: sy-ucomm, function.
      MESSAGE i033(/ey1/sav_savotta) WITH lv_curr lv_bunit DISPLAY LIKE 'E'.
    ENDIF.

    extract[] = total[].

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
        IF <fs_extract>-intention = 'PER'.
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


  IF sy-ucomm = 'SAVE'.

    LOOP AT total ASSIGNING <fs_total3> CASTING.
        SELECT SINGLE intent from /ey1/f4_intnt
              INTO <fs_total3>-intention
              WHERE gjahr     = <fs_total3>-ryear
              AND   bunit     = <fs_total3>-bunit
              AND   intention = <fs_total3>-intention.
      IF sy-subrc <> 0.
      SELECT SINGLE Intent FROM /ey1/f4_intnt
        INTO <fs_total3>-intention
        WHERE intention = <fs_total3>-intention.
      ENDIF.
    ENDLOOP.

    extract[] = total[].

  ENDIF.
ENDMODULE.

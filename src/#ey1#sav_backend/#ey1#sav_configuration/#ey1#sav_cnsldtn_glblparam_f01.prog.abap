*&---------------------------------------------------------------------*
*& Include          ZEY_SAV_CONSLDT_GLBLPARAMS_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form modify
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM modify .
  "For every value of intention, set corresponding period_to value
  CASE /ey1/globalparam-intention.

    WHEN 'Q1'.
      /ey1/globalparam-period_to = '003'.

    WHEN 'Q2'.
      /ey1/globalparam-period_to = '006'.

    WHEN 'Q3'.
      /ey1/globalparam-period_to = '009'.

    WHEN 'CIT' OR 'STR' OR 'TXA' OR 'TXP' OR 'TXU'.
      /ey1/globalparam-period_to = '012'.

  ENDCASE.

  IF /ey1/globalparam-intention = 'Q1'   OR
     /ey1/globalparam-intention = 'Q2'   OR
     /ey1/globalparam-intention = 'Q3'   OR
     /ey1/globalparam-intention = 'CIT'  OR
     /ey1/globalparam-intention = 'STR'  OR
     /ey1/globalparam-intention = 'TXA'  OR
     /ey1/globalparam-intention = 'TXP'  OR
     /ey1/globalparam-intention = 'TXU'.
    LOOP AT SCREEN.
      IF screen-name = '/EY1/GLOBALPARAM-PERIOD_TO'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  "Hide Version
  LOOP AT SCREEN.
    IF screen-name CS 'RVERS'.
      screen-active = 0.
      screen-invisible = 1.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form save
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save .

  gv_ok_flag = 'X'.

  "Check if currency field is filled by the user
  IF i_currency IS INITIAL.
    MESSAGE TEXT-003 TYPE 'E'.
  ENDIF.

  "Valdiate the period value when intention is CIT/STR/TXA/TXU/TXP
  IF  /ey1/globalparam-period_to <= 0 OR /ey1/globalparam-period_to > 12.
    MESSAGE TEXT-002 TYPE 'E'.
  ENDIF.

  "Check if Fiscal Year field is filled by the user
  IF /ey1/globalparam-ryear IS INITIAL.
    MESSAGE TEXT-005 TYPE 'E'.
  ENDIF.

  "Check if Intention field is filled by the user
  IF /ey1/globalparam-intention IS INITIAL.
    MESSAGE TEXT-004 TYPE 'E'.
  ENDIF.

  "Not Required - Since the Version Field will be disabled
  "Check if Version field is filled by the user
*  IF /ey1/globalparam-rvers IS INITIAL.
*    MESSAGE TEXT-006 TYPE 'E'.
*  ELSE.
*    "Validation Check
*    SELECT SINGLE rvers FROM tf200 INTO @DATA(lv_rvers)
*      WHERE rvers = @/ey1/globalparam-rvers.
*      IF sy-subrc IS NOT INITIAL.
*        MESSAGE e029(/ey1/sav_savotta) WITH /ey1/globalparam-rvers.
*      ENDIF.
*  ENDIF.


  "Check if Consolidation COA field is filled by the user
  IF /ey1/globalparam-itclg IS INITIAL.
    MESSAGE TEXT-007 TYPE 'E'.
  ELSE.
    "Validation Check
    SELECT SINGLE itclg FROM tf120 INTO @DATA(lv_itclg)
      WHERE itclg = @/ey1/globalparam-itclg.
      IF sy-subrc IS NOT INITIAL.
        MESSAGE e030(/ey1/sav_savotta) WITH /ey1/globalparam-itclg.
      ENDIF.
  ENDIF.

  SELECT SINGLE * FROM fincs_grpstr
    INTO @DATA(ls_config)
    WHERE bunit = @/ey1/globalparam-bunit
    AND   congr = @/ey1/globalparam-congr.
  IF sy-subrc <> 0.
    MESSAGE i031(/ey1/sav_savotta) WITH /ey1/globalparam-congr /ey1/globalparam-bunit DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  DATA: lw_user_data TYPE /ey1/globalparam.                "Work area for user settings

  lw_user_data-uname       = sy-uname.                     "Logged in user name
  lw_user_data-bunit       = /ey1/globalparam-bunit.       "Consolidation Unit
  lw_user_data-congr       = /ey1/globalparam-congr.       "Consolidation Group
  lw_user_data-intention   = /ey1/globalparam-intention.   "Intention
  lw_user_data-ryear       = /ey1/globalparam-ryear.       "Fiscal Year
  lw_user_data-period_from = /ey1/globalparam-period_from. "Period from is defaulted to 001
  lw_user_data-period_to   = /ey1/globalparam-period_to.   "Period To
  lw_user_data-itclg       = /ey1/globalparam-itclg.       "Consolidation COA

  "Currency fields
  DATA(lv_curtyp_scr) = i_currency+0(5).

  IF lv_curtyp_scr EQ 'Local'.
    lw_user_data-local_currency_type = 'Local'.
    lw_user_data-local_currency = i_currency+7(3).
  ELSEIF lv_curtyp_scr EQ 'Group'.
    lw_user_data-group_currency_type = 'Group'.
    lw_user_data-group_currency = i_currency+7(3).
  ENDIF.

  "Update the table with new entry
  MODIFY /ey1/globalparam FROM lw_user_data.
  IF sy-subrc EQ 0.
    MESSAGE TEXT-001 TYPE 'S'.
    COMMIT WORK.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form populate_period_to
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM populate_period_to .
  gv_ok_flag = 'X'.
  CASE /ey1/globalparam-intention.

    WHEN 'Q1'.
      /ey1/globalparam-period_to = '003'.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'. " Dynamic function code setting

    WHEN 'Q2'.
      /ey1/globalparam-period_to = '006'.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'. " Dynamic function code setting

    WHEN 'Q3'.
      /ey1/globalparam-period_to = '009'.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'. " Dynamic function code setting

    WHEN 'CIT' OR 'STR' OR 'TXA' OR 'TXP' OR 'TXU'.
      /ey1/globalparam-period_to = '012'.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'. " Dynamic function code setting

  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Include          ZEY_SAV_CONSLDT_GLBLPARAMS_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  0100_EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE 0100_exit INPUT.

  ok_code = sy-ucomm. "capture the user command from the screen
  CLEAR sy-ucomm.

  IF ok_code = 'FC_CANCEL'.
    SET SCREEN 0.
    LEAVE PROGRAM.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'FC_OK'.                               "To save
      PERFORM save.

    WHEN 'FC_LB'.                               "When value from a intention listbox is selected
      PERFORM populate_period_to.

    WHEN 'FC_ULB'.                              "When value from a consolidation unit listbox is selected
      gv_ok_flag = 'X'.
      CLEAR i_currency.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'.  " Dynamic function code setting

    WHEN 'FC_CLB' .                             "When value from a currency listbox is selected
      gv_ok_flag = 'X'.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'.  " Dynamic function code setting

    WHEN 'FC_EXIT'.
      SET SCREEN 0. LEAVE SCREEN.

    WHEN 'FC_BACK'.
      SET SCREEN 0. LEAVE SCREEN.

  ENDCASE.
  CLEAR ok_code.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  F4HELP_CONS_UNIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE f4help_cons_unit INPUT.

  CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'
    EXPORTING
      tabname     = 'TF160'
      fieldname   = 'BUNIT'
      dynpprog    = sy-cprog
      dynpnr      = sy-dynnr
      dynprofield = '/EY1/GLOBALPARAM-BUNIT'.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_PERIOD_TO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_period_to INPUT.
  IF ok_Code = 'FC_OK'.
    IF  /ey1/globalparam-period_to <= 0 OR /ey1/globalparam-period_to > 12.
      MESSAGE TEXT-002 TYPE 'E'.
    ENDIF.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  NAVIGATION  INPUT
*&---------------------------------------------------------------------*
*       Navigate to Assign Number Range Object GUI App
*----------------------------------------------------------------------*
MODULE navigation INPUT.
  CASE sy-ucomm.
    WHEN '&IC1'.
      CALL TRANSACTION '/EY1/SAV_CTN'.

      WHEN OTHERS.
        ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  FIELD_VALIDATION  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE field_validation INPUT.
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

*  "Check if Version field is filled by the user
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

ENDMODULE.

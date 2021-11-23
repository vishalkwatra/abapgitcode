*&---------------------------------------------------------------------*
*& Include          ZEY_SAV_CONSLDT_GLBLPARAMS_O01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'PF_0100'. "Setting the status for screen
  SET TITLEBAR 'TITLE_100'. "Title for the screen
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module SET_INIT_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE set_init_0100 OUTPUT.
  /ey1/globalparam-period_from = '001'. "Defaulting period from to 1
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module CALL_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*MODULE call_screen OUTPUT.
*  CALL SCREEN 100 STARTING AT 3 10 "TOP LEFT co-ordinates
*  ENDING AT 60 35 . "Bottom Right co-ordinates
*ENDMODULE.
*&---------------------------------------------------------------------*
*& Module SCREEN_MOD OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE screen_mod OUTPUT.

  PERFORM modify.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_LISTBOX OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_listbox OUTPUT.
  CLEAR: gt_list.

**Select drop down values of intention from table 'ZINTENT_VALUE'

SELECT
   intention            AS intent,
   gjahr                AS gjahr,
   serialnumber         AS seqnr_flb,
   intentdescription    AS description,
   periodto             AS period_to,
   taxintention         AS taxintention,
   curropenperiod       AS curropenper,
   status               AS status
 FROM
  /ey1/cintsn_stat( p_bunit = @/ey1/globalparam-bunit )
 WHERE
  GJAHR = @/ey1/globalparam-ryear
 INTO TABLE @DATA(lt_intention).

*  SELECT a~seqnr_flb,
*         a~intent,
*         a~description,
*         a~periodto,
*         a~taxintention,
*         a~analyticsperiodto,
*         CASE b~intnsn_act_flg
*           WHEN 'X' THEN 'Open'
*           WHEN ' ' THEN 'Closed'
*         END AS status  FROM /ey1/intention AS a
*     LEFT JOIN /ey1/fiscl_intnt AS b
*     ON a~intent = b~intention
*     INTO TABLE @DATA(lt_intention). "#EC CI_NOWHERE
  IF sy-subrc IS INITIAL AND lt_intention IS NOT INITIAL.
    SORT lt_intention ASCENDING BY seqnr_flb.
    LOOP AT lt_intention ASSIGNING FIELD-SYMBOL(<fs_intention>).
      gw_value-key  = <fs_intention>-intent.
      gw_value-text = | { <fs_intention>-description } | && space && |(| && |{ <fs_intention>-taxintention }| &&
       |)| && | - | && |{ <fs_intention>-status }|.
      APPEND gw_value TO gt_list.
    ENDLOOP.
  ENDIF.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = '/EY1/GLOBALPARAM-INTENTION'
      values = gt_list.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_USER OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_user OUTPUT.

  CHECK gv_ok_flag IS INITIAL.
  gv_bunit = /ey1/globalparam-bunit.
  CLEAR : /ey1/globalparam.

  IF gv_bunit IS INITIAL.
  SELECT SINGLE *
    FROM /ey1/globalparam
    INTO @DATA(lw_user_data)
    WHERE uname = @sy-uname
    AND   userdefault = 'X'.
  ELSE.
   SELECT SINGLE *
    FROM /ey1/globalparam
    INTO lw_user_data
    WHERE uname = sy-uname
    AND   bunit = gv_bunit.
  ENDIF.

  IF sy-subrc EQ 0.
    /ey1/globalparam-bunit     = lw_user_data-bunit.                         "Consolidation Unit
    /ey1/globalparam-congr     = lw_user_data-congr.                         "Consolidation Group
    /ey1/globalparam-intention = lw_user_data-intention.                     "Intention
    /ey1/globalparam-ryear     = lw_user_data-ryear.                         "Fiscal Year

    IF lw_user_data-group_currency IS NOT INITIAL.                           "Currency
      CONCATENATE 'Group (' lw_user_data-group_currency ')' INTO i_currency.
    ELSEIF lw_user_data-local_currency IS NOT INITIAL.
      CONCATENATE 'Local (' lw_user_data-local_currency ')' INTO i_currency.
    ENDIF.

    /ey1/globalparam-period_from = lw_user_data-period_from.                 "Period From
    /ey1/globalparam-period_to   = lw_user_data-period_to.                   "Period To
    /ey1/globalparam-itclg       = lw_user_data-itclg.                       "Consolidation COA
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_CURRENCY_LISTBOX OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_currency_listbox OUTPUT.
  CLEAR : gt_list,gt_glb_curr,gw_value.

  " Get the corresponding currency  type and currency based on consolidation unit
  SELECT consolidationunit,currencytype,currency
    FROM /EY1/SAV_C_CurrLocalGroupVH
    INTO TABLE @DATA(lt_currency)
    WHERE consolidationunit = @/ey1/globalparam-bunit.

  LOOP AT lt_currency ASSIGNING FIELD-SYMBOL(<fs_currency>).

    IF <fs_currency>-currencytype = 'Local'.
      CONCATENATE 'Local ( ' <fs_currency>-currency ')' INTO gw_value-key.

    ELSEIF <fs_currency>-currencytype = 'Group'.
      CONCATENATE 'Group ( ' <fs_currency>-currency ')' INTO gw_value-key.
    ENDIF.

    gw_value-text = gw_value-key.

    IF gw_value-key EQ i_Currency.
      SKIP.
    ELSE.
      APPEND gw_value TO gt_list.
    ENDIF.

  ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'I_CURRENCY'
      values = gt_list.

  CLEAR gt_glb_curr.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_BUNIT_LISTBOX OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_bunit_listbox OUTPUT.

  CLEAR: gt_list,gw_value.

  SELECT bunit FROM /ey1/globalparam   "Added Line
    INTO TABLE @DATA(lt_bunit_user)    "Added Line
    WHERE uname = @sy-uname.            "Added Line
  IF sy-subrc = 0.                     "Added Line
    SELECT DISTINCT tf~bunit,txtmi                       "#EC CI_BUFFJOIN
      FROM tf160 AS tf INNER JOIN tf161 AS txt
      ON tf~bunit = txt~bunit
      INTO TABLE @DATA(lt_bunit)
      FOR ALL ENTRIES IN @lt_bunit_user "Added Line
      WHERE langu = @sy-langu
      AND   tf~bunit = @lt_bunit_user-bunit. "Added Line
    IF sy-subrc EQ 0.
      LOOP AT lt_bunit ASSIGNING FIELD-SYMBOL(<fs_bunit>).
        gw_value-key  = <fs_bunit>-bunit.
        gw_value-text = <fs_bunit>-txtmi.
        APPEND gw_value TO gt_list.
      ENDLOOP.
    ENDIF.
  ENDIF.                               "Added Line

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = '/EY1/GLOBALPARAM-BUNIT'
      values = gt_list.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_TEXTS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*MODULE get_texts OUTPUT.
*  "Text to be displayed for consolidation Unit
*  IF NOT /ey1/globalparam-bunit IS INITIAL.
*    SELECT SINGLE txtmi FROM tf161 INTO  i_bunittext    "#EC CI_GENBUFF
*                                   WHERE langu EQ sy-langu
*                                   AND   bunit EQ /ey1/globalparam-bunit.
*    IF sy-subrc NE 0.
*      CLEAR i_bunittext.
*    ENDIF.
*  ENDIF.

*  "Text to be displayed for consolidation Group
*  IF NOT /ey1/globalparam-congr IS INITIAL.
*    SELECT SINGLE txtmi FROM tf181 INTO  i_congrtext    "#EC CI_GENBUFF
*                                   WHERE langu EQ sy-langu
*                                   AND   congr EQ /ey1/globalparam-congr.
*    IF sy-subrc NE 0.
*      CLEAR i_congrtext.
*    ENDIF.
*  ENDIF.
*
*ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_CONGR_LISTBOX OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_congr_listbox OUTPUT.

  CLEAR: gt_list,gw_value.

  SELECT congr FROM /ey1/globalparam
    INTO TABLE @DATA(lt_congr_user)
    WHERE uname = @sy-uname
    AND   bunit = @/ey1/globalparam-bunit.
  IF sy-subrc = 0.
    SELECT DISTINCT tf~congr, txtmi                       "#EC CI_BUFFJOIN
      FROM tf180 AS tf INNER JOIN tf181 AS txt
      ON tf~congr = txt~congr
      INTO TABLE @DATA(lt_congr)
      FOR ALL ENTRIES IN @lt_congr_user
      WHERE langu = @sy-langu
      AND   tf~congr = @lt_congr_user-congr.

    IF sy-subrc EQ 0.
      LOOP AT lt_congr ASSIGNING FIELD-SYMBOL(<fs_congr>).
        gw_value-key  = <fs_congr>-congr.
        gw_value-text = <fs_congr>-txtmi.
        APPEND gw_value TO gt_list.
      ENDLOOP.
    ENDIF.
  ENDIF.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = '/EY1/GLOBALPARAM-CONGR'
      values = gt_list.
ENDMODULE.

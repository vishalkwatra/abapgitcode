*----------------------------------------------------------------------*
***INCLUDE /EY1/LRECONLEDGERF05.
*----------------------------------------------------------------------*
*PERFORM ZUPDATE_DESCRIPTION.
*
*&---------------------------------------------------------------------*
*& Form ZUPDATE_DESCRIPTION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM /EY1/update_description .

  IF /ey1/reconledger-bunit IS NOT INITIAL.

    SELECT SINGLE txtmi "#EC CI_NOORDER
    INTO @DATA(lv_txtmi) "#EC CI_GENBUFF
    FROM tf161 WHERE bunit = @/ey1/reconledger-bunit.
    IF sy-subrc = 0.
      /ey1/reconledger-txtmi = lv_txtmi.
    ENDIF.
  ENDIF.
  CLEAR lv_txtmi.
ENDFORM.

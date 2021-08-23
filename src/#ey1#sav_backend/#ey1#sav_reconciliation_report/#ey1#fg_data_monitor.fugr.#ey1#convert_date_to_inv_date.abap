FUNCTION /EY1/CONVERT_DATE_TO_INV_DATE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_YEAR) TYPE  GJAHR
*"  EXPORTING
*"     REFERENCE(EV_YEAR_INV) TYPE  FC_RYEAR
*"----------------------------------------------------------------------


CONVERT DATE iv_year INTO INVERTED-DATE ev_year_inv.


ENDFUNCTION.

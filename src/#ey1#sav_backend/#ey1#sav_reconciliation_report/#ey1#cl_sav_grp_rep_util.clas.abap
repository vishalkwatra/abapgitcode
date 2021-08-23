CLASS /ey1/cl_sav_grp_rep_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES if_amdp_marker_hdb .

  TYPES:
    BEGIN OF ty_amount,
             amount TYPE wertv12,
           END OF ty_amount .
  TYPES:
    tt_amount TYPE STANDARD TABLE OF ty_amount .
  TYPES:
    BEGIN OF ty_out_amount,
             from_amount   TYPE wertv12,
             from_currency TYPE waers,
             to_amount     TYPE wertv12,
             to_currency   TYPE waers,
           END OF ty_out_amount .
  TYPES:
    tt_out_amount TYPE STANDARD TABLE OF ty_out_amount .

  CLASS-METHODS determine_period
    IMPORTING
      !iv_date TYPE sydatum
      !iv_consolidation_unit TYPE fc_bunit
      !iv_consolidation_ledger TYPE rldnr
    EXPORTING
      !ev_period TYPE monat
      !ev_year TYPE gjahr
    RAISING
      /EY1/CX_SAV_RECONCILIATION .
  CLASS-METHODS convert_currency
    IMPORTING
      VALUE(iv_client) TYPE mandt
      VALUE(it_amount) TYPE tt_amount
      VALUE(iv_from_currency) TYPE waers
      VALUE(iv_to_currency) TYPE waers
      VALUE(iv_exchange_rate_date) TYPE sydatum
    EXPORTING
      VALUE(et_conv_amount) TYPE tt_out_amount .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /ey1/cl_sav_grp_rep_util IMPLEMENTATION.


  METHOD convert_currency BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.

    lt_amount = select amount as from_amount, :iv_from_currency as from_currency from :it_amount;
    lt_conv_amount =  CE_CONVERSION (
              :lt_amount,
              [ family             = 'currency',
                method             = 'ERP',
                steps              = 'shift,convert,shift_back',
                target_unit        = :iv_to_currency,
                client             = :iv_client,
                source_unit_column = from_currency,
                reference_date     = :iv_exchange_rate_date,
                output             = 'input,converted, passed_through, output_unit',
                output_unit_column = "TO_CURRENCY",
                error_handling     = 'keep unconverted' ],
              [ from_amount AS to_amount ] );

     --lt_first_amount =  select top 1 * FROM :lt_conv_amount;
    et_conv_amount = select * FROM :lt_conv_amount;

  ENDMETHOD.


  METHOD determine_period .

    DATA: lv_ledger       TYPE rldnr,
          lv_company_code TYPE bukrs,
          lv_ref_ledger   TYPE fagl_orientation_ledger.

    SELECT SINGLE bukrs FROM t001 INTO lv_company_code WHERE rcomp = iv_consolidation_unit.
    IF sy-subrc IS INITIAL.
        SELECT SINGLE orient_ledger FROM t881 INTO lv_ref_ledger WHERE rldnr = iv_consolidation_ledger.
    ENDIF.



    CALL FUNCTION 'FI_PERIOD_DETERMINE'
      EXPORTING
        i_bukrs = lv_company_code
        i_budat = iv_date
        i_rldnr = lv_ref_ledger
      IMPORTING
        e_gjahr = ev_year
        e_monat = ev_period
      EXCEPTIONS
        fiscal_year    = 1
        period         = 2
        period_version = 3
        posting_period = 4
        special_period = 5
        version        = 6
        posting_date   = 7                " Posting date is initial
        OTHERS         = 8.

*   Exception handling
    IF sy-subrc IS NOT INITIAL.
      RAISE EXCEPTION TYPE /ey1/cx_sav_reconciliation MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno .
    ENDIF.

  ENDMETHOD.
ENDCLASS.

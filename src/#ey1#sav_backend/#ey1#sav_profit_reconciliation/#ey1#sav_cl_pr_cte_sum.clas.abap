class /EY1/SAV_CL_PR_CTE_SUM definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .
protected section.
private section.
ENDCLASS.



CLASS /EY1/SAV_CL_PR_CTE_SUM IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    CHECK NOT it_original_data IS INITIAL.

    "Type Declaration
    TYPES: BEGIN OF ty_amount,
             amount TYPE wertv12,
           END OF ty_amount,
           tt_amount TYPE STANDARD TABLE OF ty_amount,

           BEGIN OF ty_out_amount,
             from_amount   TYPE wertv12,
             from_currency TYPE waers,
             to_amount     TYPE wertv12,
             to_currency   TYPE waers,
           END OF ty_out_amount,

           tt_out_amount TYPE STANDARD TABLE OF ty_out_amount.

    "Data Declaration
    DATA: lt_original_data   TYPE STANDARD TABLE OF /EY1/SAV_C_PR_CTE_Total,
          lt_calculated_data TYPE STANDARD TABLE OF /EY1/SAV_C_PR_CTE_Total,
          lt_amount          TYPE tt_amount,
          lt_conv_amount     TYPE tt_out_amount,

          ls_amount          TYPE ty_amount,

          lv_tax_inc         TYPE wertv12,

          lv_tax_sum_gc      TYPE wertv12,
          lv_tax_sum_lc      TYPE wertv12,
          lv_exchrate_date   TYPE sy-datum,
          lv_inverted_date   TYPE gdatu_inv,
          lv_avg_rate        TYPE ukurs_curr,
          lv_closing_rate    TYPE ukurs_curr,
          lv_external_date   TYPE char12,
          lv_tax_ledger      TYPE rldnr .

     CONSTANTS:lc_avg_rate_type TYPE kurst_curr VALUE 'AVG',
               lc_clo_rate_type TYPE kurst_curr VALUE 'CLO'.

    "Copying input original data to local internal table
    MOVE-CORRESPONDING it_original_data TO lt_original_data.

    "Reading 1st line of Original data to get the required fields value for calculation
    READ TABLE lt_original_data ASSIGNING FIELD-SYMBOL(<fs_data>) INDEX 1.
    IF sy-subrc IS INITIAL AND <fs_data> IS ASSIGNED.

      "Fetch Taxable amount for given Currency type & Country
      SELECT SINGLE * FROM /ey1/sav_i_pr_ota_tilbcl_lcgc( p_toperiod      = @<fs_data>-period,
                                                          p_ryear         = @<fs_data>-fiscalyear,
                                                          p_taxintention  = @<fs_data>-speriod )
        INTO @DATA(ls_ota) WHERE currencytype = @<fs_data>-currencytype
                           AND   Country      = @<fs_data>-countrykey ##WARN_OK.

        IF sy-subrc IS INITIAL.
          lv_tax_inc = ls_ota-taxableinclossbcl.

          "If Currency Type is Local
          IF ls_ota-currencytype = 'Local'.

            "Check Taxabale Amount
            IF lv_tax_inc >= 0.                                         "Loss

              "No Calculation required for Amount & Tax fields
               MOVE-CORRESPONDING lt_original_data TO ct_calculated_data.

            ELSEIF lv_tax_inc < 0.                                       "Reveneue

              "Change Taxabale amount sign from (-) to (+)
              lv_tax_inc = lv_tax_inc * ( -1 ).

              "Calculate Amount & Tax values for existing Tiers
              LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_cal_data_lc>).
                AT FIRST.
                  IF <fs_cal_data_lc>-tieramountlc >= lv_tax_inc.
                    <fs_cal_data_lc>-amount = lv_tax_inc.
                    lv_tax_inc = 0.
                  ELSE.
                    <fs_cal_data_lc>-amount = <fs_cal_data_lc>-tieramountlc.
                    lv_tax_inc = lv_tax_inc - <fs_cal_data_lc>-tieramountlc.
                  ENDIF.
                  <fs_cal_data_lc>-tax = ( <fs_cal_data_lc>-amount / 100 ) * <fs_cal_data_lc>-taxrate.
                  <fs_cal_data_lc>-sumtax = lv_tax_sum_lc + <fs_cal_data_lc>-tax.
                  lv_tax_sum_lc = <fs_cal_data_lc>-sumtax.
                  APPEND <fs_cal_data_lc> TO lt_calculated_data.
                  CONTINUE.
                ENDAT.

                IF lv_tax_inc IS NOT INITIAL.
                  IF <fs_cal_data_lc>-tieramountlc >= lv_tax_inc.
                    <fs_cal_data_lc>-amount = lv_tax_inc.
                    lv_tax_inc = 0.
                  ELSE.
                    <fs_cal_data_lc>-amount = <fs_cal_data_lc>-tieramountlc.
                    lv_tax_inc = lv_tax_inc - <fs_cal_data_lc>-tieramountlc.
                  ENDIF.
                  <fs_cal_data_lc>-tax = ( <fs_cal_data_lc>-amount / 100 ) * <fs_cal_data_lc>-taxrate.
                  <fs_cal_data_lc>-sumtax = lv_tax_sum_lc + <fs_cal_data_lc>-tax.
                  lv_tax_sum_lc = <fs_cal_data_lc>-sumtax.
                ENDIF.
                APPEND <fs_cal_data_lc> TO lt_calculated_data.
              ENDLOOP.

              READ TABLE lt_calculated_data ASSIGNING FIELD-SYMBOL(<fs_str_data>)
              WITH KEY sequence = ' '.
              IF sy-subrc IS INITIAL.
                "Statutory Tax Rate Calculation
                <fs_str_data>-amount = lv_tax_inc.
                lv_tax_inc = 0.
                <fs_str_data>-tax = ( <fs_str_data>-amount / 100 ) * <fs_str_data>-taxrate.

                "Footer Data Calculation
                <fs_str_data>-sumtax = lv_tax_sum_lc + <fs_str_data>-tax.                                                                      "Total Sum
                <fs_str_data>-totalcurrentcorpinctaxexp = <fs_str_data>-sumtax - <fs_str_data>-othertaxcredit.                                 "Total Current Corporate Income Tax Expense
                <fs_str_data>-corpinctaxreceivable = <fs_str_data>-totalcurrentcorpinctaxexp * ( -1 ).                                         "Corporate Income Tax Receivable
                <fs_str_data>-subtotal = <fs_str_data>-witholdingtaxcredit + <fs_str_data>-corpinctaxpaycy + <fs_str_data>-transferinout .     "Subtotal
                <fs_str_data>-corpincreceivable = <fs_str_data>-corpinctaxreceivable + <fs_str_data>-subtotal + <fs_str_data>-cta.             "Corporate Income Receivable for the year

              ENDIF.

              MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
              CLEAR lt_calculated_data.

            ENDIF.

          ENDIF.

          "If Currency Type is Group
          IF ls_ota-currencytype = 'Group'.

            SELECT SINGLE * FROM /ey1/reconledger INTO @DATA(ls_ledger)  "#EC CI_ALL_FIELDS_NEEDED
              WHERE bunit = @ls_ota-consolidationunit.
            IF sy-subrc IS INITIAL.
               lv_tax_ledger = ls_ledger-tax.
            ENDIF.

            "Select fiscal variant assigned to consolidation unit based on
            "Consolidation Dimension, Tax Ledger & Consolidation Unit
            SELECT SINGLE * FROM Tf168 INTO @DATA(ls_tf168)
              WHERE dimen = @ls_ota-consolidationdimension
              AND   rldnr = @lv_tax_ledger                               "Tax Ledger
              AND   bunit = @ls_ota-consolidationunit.
              IF sy-subrc IS INITIAL.

                "Get the exchange rate date for given fiscal year, fiscal period & fiscal variant
                CALL FUNCTION 'LAST_DAY_IN_PERIOD_GET'
                  EXPORTING
                    i_gjahr        = <fs_data>-fiscalyear
                    i_monmit       = 00
                    i_periv        = ls_tf168-periv
                    i_poper        = <fs_data>-period
                  IMPORTING
                    e_date         = lv_exchrate_date
                  EXCEPTIONS
                    input_false    = 1
                    t009_notfound  = 2
                    t009b_notfound = 3
                    OTHERS         = 4.
                IF sy-subrc <> 0.
                  MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
                ENDIF.

                LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_cal_amt_gc>).
                  IF <fs_cal_amt_gc>-tieramountlc IS NOT INITIAL.
                    ls_amount-amount = <fs_cal_amt_gc>-tieramountlc.
                    APPEND ls_amount TO lt_amount.
                  ELSE.
                    CONTINUE.
                  ENDIF.

                  "Currency Conversion using AMDP
                   /ey1/cl_sav_grp_rep_util=>convert_currency(
                    EXPORTING iv_client             = sy-mandt
                              it_amount             = lt_amount
                              iv_from_currency      = <fs_cal_amt_gc>-localcurrency
                              iv_to_currency        = ls_ota-maincurrency
                              iv_exchange_rate_date = lv_exchrate_date
                    IMPORTING et_conv_amount        = lt_conv_amount ).

                  IF lt_conv_amount IS NOT INITIAL.
                    <fs_cal_amt_gc>-tieramountgc = lt_conv_amount[ 1 ]-to_amount.
                  ENDIF.
                  CLEAR: lt_conv_amount, lt_amount.

                ENDLOOP.

                "Check Taxable amount
                IF lv_tax_inc >= 0.                                         "Loss

                  "No Calculation required for Amount & Tax fields
                   MOVE-CORRESPONDING lt_original_data TO ct_calculated_data.

                ELSEIF lv_tax_inc < 0.                                       "Reveneue

                  "Change Taxabale amount sign from (-) to (+)
                  lv_tax_inc = lv_tax_inc * ( -1 ).

                  "Calculate Amount & Tax values for existing Tiers
                  LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_cal_data_gc>).
                    AT FIRST.
                      IF <fs_cal_data_gc>-tieramountgc >= lv_tax_inc.
                        <fs_cal_data_gc>-amount = lv_tax_inc.
                        lv_tax_inc = 0.
                      ELSE.
                        <fs_cal_data_gc>-amount = <fs_cal_data_gc>-tieramountgc.
                        lv_tax_inc = lv_tax_inc - <fs_cal_data_gc>-tieramountgc.
                      ENDIF.
                      <fs_cal_data_gc>-tax = ( <fs_cal_data_gc>-amount / 100 ) * <fs_cal_data_gc>-taxrate.
                      <fs_cal_data_gc>-sumtax = <fs_cal_data_gc>-tax.
                      lv_tax_sum_gc = <fs_cal_data_gc>-sumtax.
                      APPEND <fs_cal_data_gc> TO lt_calculated_data.
                      CONTINUE.
                    ENDAT.

                    IF lv_tax_inc IS NOT INITIAL.
                      IF <fs_cal_data_gc>-tieramountgc >= lv_tax_inc.
                        <fs_cal_data_gc>-amount = lv_tax_inc.
                        lv_tax_inc = 0.
                      ELSE.
                        <fs_cal_data_gc>-amount = <fs_cal_data_gc>-tieramountgc.
                        lv_tax_inc = lv_tax_inc - <fs_cal_data_gc>-tieramountgc.
                      ENDIF.
                      <fs_cal_data_gc>-tax = ( <fs_cal_data_gc>-amount / 100 ) * <fs_cal_data_gc>-taxrate.
                      <fs_cal_data_gc>-sumtax = lv_tax_sum_gc + <fs_cal_data_gc>-tax.
                      lv_tax_sum_gc = <fs_cal_data_gc>-sumtax.
                    ENDIF.
                    APPEND <fs_cal_data_gc> TO lt_calculated_data.
                  ENDLOOP.

                  READ TABLE lt_calculated_data ASSIGNING FIELD-SYMBOL(<fs_str_data_gc>)
                  WITH KEY sequence = ' '.
                  IF sy-subrc IS INITIAL.
                    "Statutory Tax Rate Calculation
                    <fs_str_data_gc>-amount = lv_tax_inc.
                    lv_tax_inc = 0.
                    <fs_str_data_gc>-tax = ( <fs_str_data_gc>-amount / 100 ) * <fs_str_data_gc>-taxrate.

                    "Footer Data Calculation
                    <fs_str_data_gc>-sumtax = lv_tax_sum_gc + <fs_str_data_gc>-tax.                                                                            "Total Sum
                    <fs_str_data_gc>-totalcurrentcorpinctaxexp = <fs_str_data_gc>-sumtax - <fs_str_data_gc>-othertaxcredit.                                    "Total Current Corporate Income Tax Expense
                    <fs_str_data_gc>-corpinctaxreceivable = <fs_str_data_gc>-totalcurrentcorpinctaxexp * ( -1 ).                                               "Corporate Income Tax Receivable
                    <fs_str_data_gc>-subtotal = <fs_str_data_gc>-witholdingtaxcredit + <fs_str_data_gc>-corpinctaxpaycy + <fs_str_data_gc>-transferinout .     "Subtotal

                    "CTA Calculation for Average FX rates & Closing FX rates
                    CALL FUNCTION 'CONVERSION_EXIT_PDATE_OUTPUT'
                      EXPORTING
                        input         = lv_exchrate_date
                      IMPORTING
                        output        = lv_external_date.

                    CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'
                      EXPORTING
                        input         = lv_external_date
                      IMPORTING
                        output        = lv_inverted_date.

                    SELECT * FROM tcurr INTO TABLE @DATA(lt_tcurr)                        "#EC CI_GENBUFF
                      WHERE ( kurst  = @lc_avg_rate_type OR kurst = @lc_clo_rate_type )
                      AND     fcurr  = @<fs_cal_amt_gc>-localcurrency
                      AND     tcurr  = @ls_ota-maincurrency
                      AND     gdatu >= @lv_inverted_date.
                      IF sy-subrc IS INITIAL.
                        SORT lt_tcurr ASCENDING BY gdatu.

                        "Fetch exchange rate for Rate Type 'Average'
                        READ TABLE lt_tcurr ASSIGNING FIELD-SYMBOL(<ls_avg>)
                        WITH KEY kurst = lc_avg_rate_type.
                        IF sy-subrc IS INITIAL.
                          lv_avg_rate = <ls_avg>-ukurs.
                        ENDIF.

                        "Fetch exchange rate for Rate Type 'Closing'
                        READ TABLE lt_tcurr ASSIGNING FIELD-SYMBOL(<ls_clo>)
                        WITH KEY kurst = lc_clo_rate_type.
                        IF sy-subrc IS INITIAL.
                          lv_closing_rate = <ls_clo>-ukurs.
                        ENDIF.
                      ENDIF.

                      IF lv_avg_rate IS NOT INITIAL.
                        <fs_str_data_gc>-cta = ( <fs_str_data_gc>-corpinctaxreceivable / lv_avg_rate ) * ( lv_closing_rate - lv_avg_rate ).
                      ENDIF.

                       <fs_str_data_gc>-corpincreceivable = <fs_str_data_gc>-corpinctaxreceivable + <fs_str_data_gc>-subtotal + <fs_str_data_gc>-cta. "Corporate Income Receivable for the year

                  ENDIF.

                  MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
                  CLEAR lt_calculated_data.

                ENDIF.
              ENDIF.

          ENDIF.
        ENDIF.

    ENDIF.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    "Provide a list of all elements that are required for calculating the values of the virtual element
     IF line_exists( it_requested_calc_elements[ table_line = 'TIERAMOUNTGC' ] )              OR
        line_exists( it_requested_calc_elements[ table_line = 'AMOUNT' ] )                    OR
        line_exists( it_requested_calc_elements[ table_line = 'TAX' ] )                       OR
        line_exists( it_requested_calc_elements[ table_line = 'SUMTAX' ] )                    OR
        line_exists( it_requested_calc_elements[ table_line = 'TOTALCURRENTCORPINCTAXEXP' ] ) OR
        line_exists( it_requested_calc_elements[ table_line = 'CORPINCTAXRECEIVABLE' ] )      OR
        line_exists( it_requested_calc_elements[ table_line = 'SUBTOTAL' ] )                  OR
        line_exists( it_requested_calc_elements[ table_line = 'CTA' ] )                       OR
        line_exists( it_requested_calc_elements[ table_line = 'CORPINCRECEIVABLE' ] ).

       APPEND 'COUNTRYKEY'        TO et_requested_orig_elements.
       APPEND 'CURRENCYTYPE'      TO et_requested_orig_elements.
       APPEND 'FISCALYEAR'        TO et_requested_orig_elements.
       APPEND 'PERIOD'            TO et_requested_orig_elements.
       APPEND 'SPERIOD'           TO et_requested_orig_elements.

     ENDIF.
  ENDMETHOD.
ENDCLASS.

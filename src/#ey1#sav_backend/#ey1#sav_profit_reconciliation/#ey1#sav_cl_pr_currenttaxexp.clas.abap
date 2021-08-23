class /EY1/SAV_CL_PR_CURRENTTAXEXP definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .
protected section.
private section.
ENDCLASS.



CLASS /EY1/SAV_CL_PR_CURRENTTAXEXP IMPLEMENTATION.


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
    DATA: lt_original_data   TYPE STANDARD TABLE OF /EY1/SAV_C_PR_CTE_Details,
          lt_calculated_data TYPE STANDARD TABLE OF /EY1/SAV_C_PR_CTE_Details,
          lt_amount          TYPE tt_amount,
          lt_conv_amount     TYPE tt_out_amount,

          ls_amount          TYPE ty_amount,

          lv_tax_inc         TYPE wertv12,
          lv_exchrate_date   TYPE sy-datum,
          lv_tax_ledger TYPE rldnr.

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
                           AND   Country      = @<fs_data>-countrykey   ##WARN_OK.

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
                  <fs_cal_data_lc>-maincurrency = ls_ota-maincurrency.
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
                  <fs_cal_data_lc>-maincurrency = ls_ota-maincurrency.
                ENDIF.
                APPEND <fs_cal_data_lc> TO lt_calculated_data.
              ENDLOOP.

              IF lv_tax_inc IS NOT INITIAL.
                READ TABLE lt_calculated_data ASSIGNING FIELD-SYMBOL(<fs_str_data>)
                WITH KEY sequence = ' '.
                IF sy-subrc IS INITIAL.
                  <fs_str_data>-amount = lv_tax_inc.
                  lv_tax_inc = 0.
                  <fs_str_data>-tax = ( <fs_str_data>-amount / 100 ) * <fs_str_data>-taxrate.
                  <fs_str_data>-maincurrency = ls_ota-maincurrency.
                ENDIF.
              ENDIF.

              MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
              CLEAR lt_calculated_data.

            ENDIF.
          ENDIF.

          "If Currency Type is Group
          IF ls_ota-currencytype = 'Group'.

            SELECT SINGLE * FROM /ey1/reconledger INTO @DATA(ls_ledger)           "#EC CI_ALL_FIELDS_NEEDED
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
                      <fs_cal_data_gc>-maincurrency = ls_ota-maincurrency.
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
                      <fs_cal_data_gc>-maincurrency = ls_ota-maincurrency.
                    ENDIF.
                    APPEND <fs_cal_data_gc> TO lt_calculated_data.
                  ENDLOOP.

                  IF lv_tax_inc IS NOT INITIAL.
                    READ TABLE lt_calculated_data ASSIGNING FIELD-SYMBOL(<fs_str_data_gc>)
                    WITH KEY sequence = ' '.
                    IF sy-subrc IS INITIAL.
                      <fs_str_data_gc>-amount = lv_tax_inc.
                      lv_tax_inc = 0.
                      <fs_str_data_gc>-tax = ( <fs_str_data_gc>-amount / 100 ) * <fs_str_data_gc>-taxrate.
                      <fs_cal_data_gc>-maincurrency = ls_ota-maincurrency.
                    ENDIF.
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
     IF line_exists( it_requested_calc_elements[ table_line = 'TIERAMOUNTGC' ] ) OR
        line_exists( it_requested_calc_elements[ table_line = 'AMOUNT' ] ) OR
        line_exists( it_requested_calc_elements[ table_line = 'TAX' ] ).

       APPEND 'COUNTRYKEY'        TO et_requested_orig_elements.
       APPEND 'CURRENCYTYPE'      TO et_requested_orig_elements.
       APPEND 'FISCALYEAR'        TO et_requested_orig_elements.
       APPEND 'PERIOD'            TO et_requested_orig_elements.
       APPEND 'SPERIOD'           TO et_requested_orig_elements.

     ENDIF.

  ENDMETHOD.
ENDCLASS.

class /EY1/SAV_CL_PR_CTE_STATTAXRATE definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .
protected section.
private section.
ENDCLASS.



CLASS /EY1/SAV_CL_PR_CTE_STATTAXRATE IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

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
    DATA: lt_original_data   TYPE STANDARD TABLE OF /EY1/SAV_C_PR_CTE_StatTaxRate,
          lt_calculated_data TYPE STANDARD TABLE OF /EY1/SAV_C_PR_CTE_StatTaxRate,
          lt_amount          TYPE tt_amount,
          lt_conv_amount     TYPE tt_out_amount,

          ls_amount          TYPE ty_amount,

          lv_exchrate_date   TYPE sy-datum,
          lv_tier_amt_gc     TYPE wertv12.

    CONSTANTS: lv_tax_ledger TYPE rldnr VALUE 'C3'.

    CHECK NOT it_original_data IS INITIAL.

    "Copying input original data to local internal table
    MOVE-CORRESPONDING it_original_data TO lt_original_data.

    "Read lt_Original_data where Currency Type is 'Group'
    READ TABLE lt_original_data ASSIGNING FIELD-SYMBOL(<fs_data>)
    WITH KEY currencytype = 'Group'.

    IF sy-subrc IS INITIAL.

      "Select fiscal variant assigned to consolidation unit based on
      "Consolidation Dimension, Tax Ledger & Consolidation Unit
       SELECT SINGLE * FROM Tf168 INTO @DATA(ls_tf168)
         WHERE dimen = @<fs_data>-consolidationdimension
         AND   rldnr = @lv_tax_ledger                               "Tax Ledger
         AND   bunit = @<fs_data>-consolidationunit.
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
              "Implement suitable error handling here
            ENDIF.

            ls_amount-amount = <fs_data>-tieramount.
            APPEND ls_amount TO lt_amount.

            "Currency Conversion using AMDP
             /ey1/cl_sav_grp_rep_util=>convert_currency(
              EXPORTING iv_client             = sy-mandt
                        it_amount             = lt_amount
                        iv_from_currency      = <fs_data>-tieramountcurrency "Local currency
                        iv_to_currency        = <fs_data>-taxcurrency        "Target currency (From Taxable income)
                        iv_exchange_rate_date = lv_exchrate_date
              IMPORTING et_conv_amount        = lt_conv_amount ).

            IF lt_conv_amount IS NOT INITIAL.
              lv_tier_amt_gc = lt_conv_amount[ 1 ]-to_amount.
            ENDIF.

            IF <fs_data>-temptaxvalue > lv_tier_amt_gc.
              <fs_data>-amountgc = <fs_data>-temptaxvalue - lv_tier_amt_gc.
            ENDIF.

            IF <fs_data>-amountgc IS NOT INITIAL.
              <fs_data>-statutorytaxgc = ( <fs_data>-amountgc / 100 ) * <fs_data>-taxrate.
            ENDIF.

         ENDIF.

         MOVE-CORRESPONDING lt_original_data TO ct_calculated_data.

    ENDIF.

    CLEAR lt_original_data.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    "Provide a list of all elements that are required for calculating the values of the virtual element
     IF line_exists( it_requested_calc_elements[ table_line = 'AMOUNTGC' ] ) OR
        line_exists( it_requested_calc_elements[ table_line = 'STATUTORYTAXGC' ] ).

       APPEND 'AMOUNTLC'          TO et_requested_orig_elements.
       APPEND 'CONSOLIDATIONUNIT' TO et_requested_orig_elements.
       APPEND 'CURRENCYTYPE'      TO et_requested_orig_elements.
       APPEND 'FISCALYEAR'        TO et_requested_orig_elements.
       APPEND 'PERIOD'            TO et_requested_orig_elements.
       APPEND 'SPERIOD'           TO et_requested_orig_elements.

     ENDIF.

  ENDMETHOD.
ENDCLASS.

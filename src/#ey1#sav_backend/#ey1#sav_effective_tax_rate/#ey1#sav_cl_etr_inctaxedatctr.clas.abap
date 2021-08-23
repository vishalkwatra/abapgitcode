class /EY1/SAV_CL_ETR_INCTAXEDATCTR definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .
protected section.
private section.
ENDCLASS.



CLASS /EY1/SAV_CL_ETR_INCTAXEDATCTR IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    CHECK NOT it_original_data IS INITIAL.

    "Type Declaration
    TYPES: BEGIN OF ty_amount,
            amount    TYPE wertv12,
           END OF ty_amount,
           tt_amount TYPE STANDARD TABLE OF ty_amount,

           BEGIN OF ty_out_amount,
             from_amount    TYPE wertv12,
             from_currency  TYPE waers,
             to_amount      TYPE wertv12,
             to_currency    TYPE waers,
           END OF ty_out_amount,

           tt_out_amount TYPE STANDARD TABLE OF ty_out_amount.

    "Data Declaration
    DATA: lt_original_data    TYPE STANDARD TABLE OF /ey1/sav_c_etr_sum_itdctr,
          lt_calculated_data  TYPE STANDARD TABLE OF /ey1/sav_c_etr_sum_itdctr,
          lt_tiers_split      TYPE STANDARD TABLE OF /ey1/tiers_split,

          lt_amount           TYPE tt_amount,
          lt_conv_amount      TYPE tt_out_amount,

          ls_amount           TYPE ty_amount,
          ls_tiers_split      TYPE /ey1/tiers_split,

          lv_tax_inc          TYPE wertv12,
          lv_pbt              TYPE vlcur12,
          lv_exchrate_date    TYPE sy-datum,
          lv_tax_ledger       TYPE rldnr,

          lv_tax_total        TYPE wertv12,
          lv_per_total        TYPE /ey1/sav_rate.

    "Copying input original data to local internal table
    MOVE-CORRESPONDING it_original_data TO lt_original_data.

    "Reading 1st line of Original data - If data exists, them execute
    READ TABLE lt_original_data ASSIGNING FIELD-SYMBOL(<fs_data>) INDEX 1.
    IF sy-subrc IS INITIAL AND <fs_data> IS ASSIGNED.

      "Fetch Taxable amount for given Currency type & Country
      SELECT SINGLE * FROM /ey1/sav_i_pr_ota_tilbcl_lcgc( p_toperiod      = @<fs_data>-period,
                                                          p_ryear         = @<fs_data>-fiscalyear,
                                                          p_taxintention = @<fs_data>-speriod )
        INTO @DATA(ls_ota) WHERE currencytype = @<fs_data>-currencytype
                            AND  country      = @<fs_data>-countrykey.

        IF sy-subrc IS INITIAL.
          lv_tax_inc = ls_ota-taxableinclossbcl.

          "Fetch Profit Before tax amount
           SELECT SINGLE * FROM /EY1/SAV_I_ETR_RS_SUM_ExpTaxEB( p_ryear          = @<fs_data>-fiscalyear,
                                                                p_fromperiod     = @<fs_data>-FromPeriod,
                                                                p_toperiod       = @<fs_data>-period,
                                                                p_switch         = @<fs_data>-switch,
                                                                p_taxintention  = @<fs_data>-speriod,
                                                                p_rbunit         = @ls_ota-consolidationunit )
             INTO @DATA(ls_exp_tax_eb) WHERE currtype           = @<fs_data>-currencytype
                                       AND   consolidationunit  = @ls_ota-consolidationunit.
           IF sy-subrc IS INITIAL.
             lv_pbt = ls_exp_tax_eb-pbt.
           ENDIF.


          "If Currency is Local
          IF <fs_data>-currencytype = 'Local'.

            "Check Taxable Amount
            IF lv_tax_inc >= 0.

              "No Calculation required for Amount
              MOVE-CORRESPONDING lt_original_data TO ct_calculated_data.

            ELSEIF lv_tax_inc < 0.

              "Change Taxabale amount sign from (-) to (+)
              lv_tax_inc = lv_tax_inc * ( -1 ).

              "Calculate Amount values for existing Tiers
              LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_cal_data_lc>).

                IF lv_tax_inc IS  NOT INITIAL.
                  IF lv_tax_inc >= <fs_cal_data_lc>-tieramountlc.
                    <fs_cal_data_lc>-amount = <fs_cal_data_lc>-tieramountlc.
                    lv_tax_inc = lv_tax_inc - <fs_cal_data_lc>-tieramountlc.
                  ELSE.
                    <fs_cal_data_lc>-amount = lv_tax_inc.
                    lv_tax_inc = 0.
                  ENDIF.
                  <fs_cal_data_lc>-maincurrency   = ls_ota-maincurrency.
                  <fs_cal_data_lc>-tax            = ( <fs_cal_data_lc>-amount * <fs_cal_data_lc>-rate ) / 100.
                  lv_tax_total                    = lv_tax_total + <fs_cal_data_lc>-tax.
                  IF lv_pbt IS NOT INITIAL.
                    <fs_cal_data_lc>-percentage   = ( <fs_cal_data_lc>-tax / lv_pbt ) * 100.
                    lv_per_total                  = lv_per_total + <fs_cal_data_lc>-percentage.
                  ENDIF.

                ENDIF.

                APPEND <fs_cal_data_lc> TO lt_calculated_data.
              ENDLOOP.

              MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
              CLEAR lt_calculated_data.

            ENDIF.
          ENDIF.

          IF <fs_data>-currencytype = 'Group'.

            SELECT SINGLE * FROM /ey1/reconledger INTO @DATA(ls_ledger)
              WHERE bunit = @ls_ota-consolidationunit.
            IF sy-subrc IS INITIAL.
              lv_tax_ledger = ls_ledger-tax.
            ENDIF.

            "Select fiscal variant assigned to consolidation unit based on
            "Consolidation Dimension, Tax Ledger & Consolidation Unit
            SELECT SINGLE * FROM tf168 INTO @DATA(ls_tf168)
              WHERE dimen = @ls_ota-consolidationdimension
              AND rldnr   = @lv_tax_ledger
              AND bunit   = @ls_ota-consolidationunit.
              IF sy-subrc IS INITIAL.

                "Get the exchange rate date for given fiscal year, fiscal period & fiscal variant
                CALL FUNCTION 'LAST_DAY_IN_PERIOD_GET'
                  EXPORTING
                    i_gjahr              = <fs_data>-fiscalyear
                    i_monmit             = 00
                    i_periv              = ls_tf168-periv
                    i_poper              = <fs_data>-period
                 IMPORTING
                   e_date               = lv_exchrate_date
                 EXCEPTIONS
                   input_false          = 1
                   t009_notfound        = 2
                   t009b_notfound       = 3
                   OTHERS               = 4
                          .
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
                IF lv_tax_inc >= 0.           "Loss
                  "No Calculation required for Amount & Tax fields
                   MOVE-CORRESPONDING lt_original_data TO ct_calculated_data.

                ELSEIF lv_tax_inc < 0.        "Revenue

                  "Change Taxabale amount sign from (-) to (+)
                  lv_tax_inc = lv_tax_inc * ( -1 ).

                  "Calculate Amount values for existing Tiers
                  LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_cal_data_gc>).

                    IF lv_tax_inc IS NOT INITIAL.
                      IF lv_tax_inc >= <fs_cal_data_gc>-tieramountgc.
                        <fs_cal_data_gc>-amount = <fs_cal_data_gc>-tieramountgc.
                        lv_tax_inc = lv_tax_inc - <fs_cal_data_gc>-tieramountgc.
                      ELSE.
                        <fs_cal_data_gc>-amount = lv_tax_inc.
                        lv_tax_inc = 0.
                      ENDIF.
                      <fs_cal_data_gc>-maincurrency   = ls_ota-maincurrency.
                      <fs_cal_data_gc>-tax            = ( <fs_cal_data_gc>-amount * <fs_cal_data_gc>-rate ) / 100.
                      lv_tax_total                    = lv_tax_total + <fs_cal_data_gc>-tax.
                       IF lv_pbt IS NOT INITIAL.
                         <fs_cal_data_gc>-percentage  = ( <fs_cal_data_gc>-tax / lv_pbt ) * 100.
                         lv_per_total                 = lv_per_total + <fs_cal_data_gc>-percentage.
                       ENDIF.
                    ENDIF.
                    APPEND <fs_cal_data_gc> TO lt_calculated_data.
                  ENDLOOP.

                  MOVE-CORRESPONDING lt_calculated_data TO ct_calculated_data.
                  CLEAR lt_calculated_data.

                ENDIF.
              ENDIF.
          ENDIF.

          "Modifying Table /EY1/Tiers_split
          ls_tiers_split-ritclg                   = ls_exp_tax_eb-consolidationchartofaccounts.
          ls_tiers_split-ktopl                    = ls_exp_tax_eb-chartofaccounts.
          ls_tiers_split-ryear                    = ls_exp_tax_eb-fiscalyear.
          ls_tiers_split-bunit                    = ls_exp_tax_eb-consolidationunit.
          ls_tiers_split-land1                    = <fs_data>-countrykey.
          ls_tiers_split-intention                = <fs_data>-intention.
          ls_tiers_split-main_currency            = ls_exp_tax_eb-maincurrency.
          ls_tiers_split-percentage               = lv_per_total.
          ls_tiers_split-tax                      = lv_tax_total.

          APPEND ls_tiers_split TO lt_tiers_split.
          CLEAR ls_tiers_split.

          MODIFY /ey1/tiers_split FROM TABLE lt_tiers_split.
          IF sy-subrc IS NOT INITIAL.
            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          ENDIF.
          CLEAR: ls_exp_tax_eb,lv_per_total, lv_tax_total.
        ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    IF line_exists( it_requested_calc_elements[ table_line = 'AMOUNT' ] ) OR
       line_exists( it_requested_calc_elements[ table_line = 'MAINCURRENCY' ] ).

      APPEND 'COUNTRYKEY'   TO et_requested_orig_elements.
      APPEND 'CURRENCYTYPE' TO et_requested_orig_elements.
      APPEND 'FISCALYEAR'   TO et_requested_orig_elements.
*      APPEND 'PERIOD'       TO et_requested_orig_elements.
*      APPEND 'SPERIOD'      TO et_requested_orig_elements.


    ENDIF.

  ENDMETHOD.
ENDCLASS.

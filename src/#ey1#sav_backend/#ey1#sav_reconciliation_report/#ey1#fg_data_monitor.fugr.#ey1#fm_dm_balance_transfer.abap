FUNCTION /EY1/FM_DM_BALANCE_TRANSFER.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_DIMEN) TYPE  FC_DIMEN
*"     VALUE(IV_CONGR) TYPE  FC_CONGR
*"     VALUE(IV_BUNIT) TYPE  FC_BUNIT
*"     VALUE(IV_RVERS) TYPE  FC_RVERS
*"     VALUE(IV_RYEAR) TYPE  FC_RYEAR
*"     VALUE(IV_PERIOD_FROM) TYPE  POPER
*"     VALUE(IV_PERIOD_TO) TYPE  POPER
*"     VALUE(IV_JOBNAME) TYPE  TBTCJOB-JOBNAME
*"     VALUE(IV_RLDNR) TYPE  RLDNR OPTIONAL
*"     VALUE(IV_ITCLG) TYPE  FC03BCFTAB-ITCLG
*"----------------------------------------------------------------------
    DATA:  lv_time      TYPE sy-uzeit,
           lv_lines     TYPE i.

    DATA: lv_year       TYPE gjahr.

    DATA: jobcount      TYPE tbtcjob-jobcount,
          host          TYPE msxxlist-host.
    TYPES: BEGIN OF ts_starttime.
            INCLUDE TYPE tbtcstrt.
    TYPES: END OF ts_starttime.
    DATA: starttime TYPE ts_starttime.
    DATA: starttimeimmediate TYPE btch0000-char1 VALUE 'X'.

    DATA: BEGIN OF ra_bunit OCCURS 1,
                sign    TYPE char1,
                option  TYPE char2,
                low     TYPE fc_bunit,
                high    TYPE fc_bunit,
           END  OF ra_bunit.


    lv_year = iv_ryear.

    CALL FUNCTION 'JOB_OPEN'
           EXPORTING
                delanfrep        = ' '
                jobgroup         = ' '
                jobname          = iv_jobname
                sdlstrtdt        = sy-datum
                sdlstrttm        = sy-uzeit
           IMPORTING
                jobcount         = jobcount
           EXCEPTIONS
                cant_create_job  = 01
                invalid_job_data = 02
                jobname_missing  = 03.
      IF sy-subrc NE 0.
                                           "error processing
      ENDIF.

      ra_bunit-sign = 'I'.
      ra_bunit-option = 'EQ'.
      ra_bunit-low = iv_bunit.
      APPEND ra_bunit.


      SUBMIT ficbcf00 AND RETURN
                 USER sy-uname
                 VIA JOB iv_jobname
                 NUMBER jobcount
                 WITH pa_dimen EQ iv_dimen
                 WITH pa_congr EQ iv_congr
                 WITH so_bunit IN ra_bunit
                 WITH pa_rvers EQ iv_rvers
                 WITH pa_prvyr EQ lv_year
                 WITH pa_itclg EQ iv_itclg
                 WITH pa_prot  EQ 'X'
                 WITH pa_test  EQ space
                 WITH pa_lorig EQ ''
                 WITH pa_perid EQ 001.



      starttime-sdlstrtdt = sy-datum.
      starttime-sdlstrttm = sy-uzeit.
      CALL FUNCTION 'JOB_CLOSE'
           EXPORTING
                jobcount             = jobcount
                jobname              = iv_jobname
                strtimmed            = starttimeimmediate
            EXCEPTIONS
                cant_start_immediate = 01
                invalid_startdate    = 02
                jobname_missing      = 03
                job_close_failed     = 04
                job_nosteps          = 05
                job_notex            = 06
                lock_failed          = 07
                others               = 99.
      IF sy-subrc EQ 0.
                                           "error processing
      ENDIF.




ENDFUNCTION.

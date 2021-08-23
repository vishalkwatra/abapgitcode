FUNCTION /EY1/FM_BDC_CX1Q.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CONGR) TYPE  FC_CONGR
*"     VALUE(IV_RLDNR) TYPE  RLDNR
*"--------------------------------------------------------------------
DATA:  lv_time      TYPE sy-uzeit,
           lv_lines     TYPE i.

    DATA: jobcount      TYPE tbtcjob-jobcount,
          host          TYPE msxxlist-host,
          lv_jobname    TYPE tbtcjob-jobname.
    TYPES: BEGIN OF ts_starttime.
            INCLUDE TYPE tbtcstrt.
    TYPES: END OF ts_starttime.
    DATA: starttime TYPE ts_starttime.
    DATA: starttimeimmediate TYPE btch0000-char1 VALUE 'X'.


 CONCATENATE 'MasterDataUpdate' sy-uzeit INTO lv_jobname.

 CALL FUNCTION 'JOB_OPEN'
           EXPORTING
                delanfrep        = ' '
                jobgroup         = ' '
                jobname          = lv_jobname
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



SUBMIT /EY1/CX1Q AND RETURN
              USER sy-uname
              VIA JOB lv_jobname
              NUMBER jobcount
              WITH CTU = 'X'
              WITH p_congr = iv_congr
              WITH p_rldnr = iv_rldnr .



CALL FUNCTION 'JOB_CLOSE'
           EXPORTING
                jobcount             = jobcount
                jobname              = lv_jobname
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


  DO 20 TIMES.
       SELECT SINGLE * FROM tbtco
         INTO @DATA(ls_job)
         WHERE jobname = @lv_jobname.
       IF sy-subrc = 0.
         IF ls_job-status = 'A' OR ls_job-status = 'F'.
           EXIT.
         ELSE.
           WAIT UP TO 1 SECONDS.
         ENDIF.
       ELSE.
         WAIT UP TO 1 SECONDS.
       ENDIF.
   ENDDO.


ENDFUNCTION.

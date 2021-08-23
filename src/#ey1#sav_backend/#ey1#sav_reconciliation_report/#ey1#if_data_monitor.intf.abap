interface /EY1/IF_DATA_MONITOR
  public .


  methods SUBMIT_ACTION
    exporting
      !ET_MESSAGE type BAPIRET2_T
      !ET_LOG type /EY1/TT_CUR_TRANS_LOG
    changing
      !CV_LOG type FINCS_LOGNUMBER optional
      !CV_URL type CHAR1024 optional .
  methods VALIDATE
    exporting
      !ET_MESSAGE type BAPIRET2_T .
endinterface.

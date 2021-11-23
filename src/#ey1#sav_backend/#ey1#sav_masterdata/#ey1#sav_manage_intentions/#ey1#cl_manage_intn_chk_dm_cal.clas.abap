class /EY1/CL_MANAGE_INTN_CHK_DM_CAL definition
  public
  final
  create private .

public section.

  methods CHECK_DATA_MONITOR_CALL
    importing
      value(IV_BUNIT) type FC_BUNIT
      value(IV_YEAR) type GJAHR
    exporting
      !EV_INT type /EY1/SAV_INTENT .
  class-methods GET_OBJECT
    returning
      value(RO_INTENTION_CHK) type ref to /EY1/CL_MANAGE_INTN_CHK_DM_CAL .
protected section.
private section.

  class-data LO_MANAGE_INTENTION type ref to /EY1/CL_MANAGE_INTN_CHK_DM_CAL .

  methods CONSTRUCTOR .
ENDCLASS.



CLASS /EY1/CL_MANAGE_INTN_CHK_DM_CAL IMPLEMENTATION.


METHOD check_data_monitor_call.

  DATA: lv_next_year      TYPE gjahr,
        lv_next_seqnr     TYPE seqnr_flb,
        lv_curr_seqnr     TYPE seqnr_flb,
        ls_next_intention TYPE /ey1/fiscl_intnt.


 SELECT SINGLE seqnr_flb
   FROM /ey1/fiscl_intnt
   INTO lv_curr_seqnr
   WHERE bunit = iv_bunit
   AND gjahr = iv_year.


  lv_next_year = iv_year - 1.

  SELECT SINGLE *
    FROM /ey1/fiscl_intnt
    INTO ls_next_intention
    WHERE bunit = iv_bunit
    AND   gjahr = lv_next_year.


  lv_next_seqnr = ls_next_intention-seqnr_flb - 1.

  IF lv_curr_seqnr < lv_next_seqnr.
    "Allow
    ev_int = lv_curr_seqnr.
  ELSE.
    "Only Close
  ENDIF.

ENDMETHOD.


  method CONSTRUCTOR.
  endmethod.


  METHOD get_object.

    IF lo_manage_intention IS INITIAL.
      CREATE OBJECT lo_manage_intention.
    ENDIF.

    ro_intention_chk = lo_manage_intention.

  ENDMETHOD.
ENDCLASS.

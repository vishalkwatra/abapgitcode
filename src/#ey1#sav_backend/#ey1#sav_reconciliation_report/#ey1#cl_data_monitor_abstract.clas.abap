class /EY1/CL_DATA_MONITOR_ABSTRACT definition
  public
  abstract
  create public .

public section.

  interfaces /EY1/IF_DATA_MONITOR .

  methods READ_CONSOLIDATION_TYPE
    exporting
      !ET_CACTI type /EY1/TT_CACTI .
protected section.

  data GR_GLOBAL_PARAM type ref to /EY1/SAV_CL_GLOBAL_PARAMS .
  data GS_GLOBAL_PARAMS type /EY1/SAV_STR_GLBL_PARAMS .
  data GS_TF004 type TF004 .
  class-data GR_DATA_MON type ref to /EY1/CL_DATA_MONITOR_ABSTRACT .

  methods READ_GLOBAL_PARAMS .
private section.
ENDCLASS.



CLASS /EY1/CL_DATA_MONITOR_ABSTRACT IMPLEMENTATION.


  method /EY1/IF_DATA_MONITOR~SUBMIT_ACTION.
  endmethod.


  method /EY1/IF_DATA_MONITOR~VALIDATE.
  endmethod.


  METHOD READ_CONSOLIDATION_TYPE.

*    TYPES: BEGIN OF ty_cacti,
*             cacti TYPE tf261-cacti,
*           END OF ty_cacti,
*           BEGIN OF tr_cacti,
*             sign      TYPE char1,
*             option    TYPE char2,
*             low       TYPE tf261-cacti,
*             high      TYPE tf261-cacti,
*           END OF tr_cacti.
*    DATA: r_cacti  TYPE TABLE OF tr_cacti,
*          rs_cacti TYPE tr_cacti.
*
*
*    SELECT DISTINCT cacti
*       FROM tf261
*       INTO TABLE et_cacti
*       WHERE dimen = gs_tf004-dimen
*       AND   itclg = gs_global_params-itclg
**       AND   rvers = gs_global_params-rvers
*       AND   ryear = gs_global_params-ryear
*       AND   perid = gs_global_params-period_to
*       AND   bunit = gs_global_params-bunit
*       ORDER BY cacti.
*  IF sy-subrc = 0.
    "To Be Removed
*    rs_cacti-sign = 'I'.
*    rs_cacti-option = 'EQ'.
*    rs_cacti-low = '1100'.
*    APPEND rs_cacti TO r_cacti.
*    rs_cacti-low = '1015'.
*    APPEND rs_cacti TO r_cacti.

    APPEND '1015' TO et_cacti.
    APPEND '1011' TO et_cacti.
    "DELETE et_cacti WHERE cacti NOT IN r_cacti[].

*  ENDIF.


  ENDMETHOD.


  METHOD READ_GLOBAL_PARAMS.

    "Get Global Parameters for the user
    gr_data_mon->gr_global_param->get_user_settings(
      IMPORTING
        es_user_global_params = me->gs_global_params ).
    IF me->gs_global_params IS INITIAL.
      MESSAGE e001(00) WITH text-001 '' '' ''.##MG_MISSING
    ENDIF.

    SELECT SINGLE * from tf004 INTO me->gs_tf004
        WHERE uname EQ sy-uname.
    IF sy-subrc <> 0.
      MESSAGE e001(00) WITH text-001 '' '' ''.##MG_MISSING
    ENDIF.
  ENDMETHOD.
ENDCLASS.

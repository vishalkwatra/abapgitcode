class /EY1/CL_DATA_MONITOR_JV_RELEAS definition
  public
  inheriting from /EY1/CL_DATA_MONITOR_ABSTRACT
  final
  create private .

public section.

  class-methods GET_INSTANCE
    importing
      !BUNIT type FC_BUNIT optional
      !RYEAR type FC_RYEAR optional
      !INTENTION type /EY1/SAV_INTENT optional
      !PERIOD_FROM type POPER optional
      !PERIOD_TO type POPER optional
      !LOCAL_CURRENCY type FINS_VHCUR12 optional
      !LOCAL_CURRENCY_TYPE type FC_CURR optional
      !GROUP_CURRENCY type GCURR optional
      !GROUP_CURRENCY_TYPE type FINCS_GROUPCURRENCY optional
      !ITCLG type FC_ITCLG optional
      !RVERS type FC_RVERS optional
      !RLDNR type RLDNR optional
    returning
      value(RO_DATA_MON) type ref to /EY1/CL_DATA_MONITOR_ABSTRACT .

  methods /EY1/IF_DATA_MONITOR~SUBMIT_ACTION
    redefinition .
  methods /EY1/IF_DATA_MONITOR~VALIDATE
    redefinition .
protected section.
private section.

  methods CONSTRUCTOR .
ENDCLASS.



CLASS /EY1/CL_DATA_MONITOR_JV_RELEAS IMPLEMENTATION.


METHOD /EY1/IF_DATA_MONITOR~SUBMIT_ACTION.

   DATA: if_cuind     TYPE fc_flg,
         if_testrun   TYPE fc_testrun  VALUE 'X',
         if_lorig     TYPE fc_lorig,
         i_ok_code    TYPE syst_tcode  VALUE 'EXEC',
         ls_msg       TYPE bapiret2.


   DATA: lt_bunit         TYPE fc01_t_bunit_closetime,
         lf_success       TYPE fc_flg,
         lt_message       TYPE fc00_t_message,
         ls_message       TYPE fc00_s_message,
         lf_error         TYPE fc_flg,
         gf_bundled_exec  TYPE fc_flg.

   TYPES:t_fc00lst00m TYPE STANDARD TABLE OF fc00lst00m_s4h.

   DATA:gt_4630_bunit       TYPE fc01_t_bunit_closetime,
        gt_4630_bunit_mark  TYPE fc01_t_bunit_closetime,
        gt_4630_rfd_full    TYPE t_fc00lst00m,
        gt_4630_rfd_delta   TYPE t_fc00lst00m.

   DATA:gd_test             TYPE  fc_testrun,
        gd_lorig            TYPE  fc_lorig.

   DATA:zs_msg              TYPE bapiret2.
   DATA:lt_tf184            TYPE TABLE OF tf184,
        ls_tf184            TYPE tf184.

*   DATA: lv_year     TYPE gjahr,
*         lv_year_inv TYPE fc_ryear.
*
     "New
*     lv_year = gs_global_params-ryear.
*     CALL FUNCTION '/EY1/CONVERT_DATE_TO_INV_DATE'
*       EXPORTING
*         iv_year           = lv_year
*       IMPORTING
*        ev_year_inv        = lv_year_inv.
*
*     SELECT SINGLE rvers FROM tf184
*         INTO gs_global_params-rvers
*         WHERE dimen = gs_tf004-dimen
*         AND   congr = gs_tf004-congr
*         AND   rldnr = gs_tf004-rldnr
*         AND   ryear = lv_year_inv.

      SELECT  rvers FROM tf184
        UP TO 1 ROWS
        INTO CORRESPONDING FIELDS OF TABLE lt_tf184
        WHERE dimen = gs_tf004-dimen
        AND   congr = gs_tf004-congr
        AND   rldnr = gs_tf004-rldnr
        ORDER BY ryear ASCENDING.
     IF sy-subrc = 0.
       READ TABLE lt_tf184 TRANSPORTING rvers INTO ls_tf184 INDEX 1.
       IF sy-subrc = 0.
          gs_global_params-rvers = ls_tf184-rvers.
       ENDIF.
     ENDIF.

     "End


   REFRESH et_message.

   MOVE:
         if_testrun TO gd_test,
         if_lorig   TO gd_lorig.

   IF gs_global_params-bunit IS INITIAL AND
      gs_tf004-congr IS INITIAL.
     "MESSAGE x000(gk).
     zs_msg-id =  'GK'.
     zs_msg-number = '000'.
     zs_msg-type   = 'E'.
     APPEND zs_msg TO et_message.
     RETURN.
   ENDIF.

   IF i_ok_code EQ 'KONS' OR
      i_ok_code EQ 'KOOH' OR
      i_ok_code EQ 'BALL' OR
      i_ok_code EQ 'BPER' OR
      i_ok_code EQ 'IRUN' .
      gf_bundled_exec = abap_true.
   ELSE.
      gf_bundled_exec = abap_false.
   ENDIF.


   IF NOT gd_lorig IS INITIAL AND
         gd_test  IS INITIAL.
     IF gf_bundled_exec IS INITIAL.
       zs_msg-id =  'GK'.
       zs_msg-number = '359'.
       zs_msg-type   = 'E'.
       CALL FUNCTION 'MESSAGE_TEXT_BUILD'
         EXPORTING
           msgid                     = 'GK'
           msgnr                     = '359'
         IMPORTING
           message_text_output       = zs_msg-message.
                 .

       APPEND zs_msg TO et_message.
       RETURN.
       "MESSAGE e359(gk).##MG_MISSING
     ELSE.
       RETURN.
     ENDIF.
  ENDIF.

  REFRESH: gt_4630_bunit, gt_4630_rfd_full, gt_4630_rfd_delta.

  PERFORM analyze_sel_for_bunit IN PROGRAM saplfc02 USING gs_tf004-dimen gs_tf004-rvers gs_global_params-ryear gs_global_params-period_to
             gs_tf004-congr gs_global_params-bunit 'X'
    CHANGING gt_4630_bunit.

  IF gt_4630_bunit IS INITIAL.
    IF gf_bundled_exec IS INITIAL.
       zs_msg-id     =  'G01'.
       zs_msg-number =  '704'.
       zs_msg-type   =  'I'.
       CALL FUNCTION 'MESSAGE_TEXT_BUILD'
         EXPORTING
           msgid                     = 'G01'
           msgnr                     = '704'
         IMPORTING
           message_text_output       = zs_msg-message.
                 .


       APPEND zs_msg TO et_message.
      "MESSAGE i704(g01).##MG_MISSING
    ENDIF.
    RETURN.
  ENDIF.

  PERFORM read_closetime IN PROGRAM saplfc02 USING gs_tf004-dimen
             gs_tf004-rldnr
             gs_tf004-rvers gs_global_params-ryear gs_global_params-period_to
    CHANGING gt_4630_bunit.


   APPEND LINES OF gt_4630_bunit TO gt_4630_bunit_mark.

  "Save Functionality
  PERFORM update_closetime IN PROGRAM saplfc02 USING
           gs_tf004-dimen
           gs_tf004-rldnr
           gs_global_params-itclg
           gs_global_params-rvers
           gs_global_params-ryear
           gs_global_params-period_to
           gt_4630_bunit_mark
           gf_bundled_exec
         CHANGING lf_success
                  lt_message
                  gt_4630_bunit.

   PERFORM update_status_dsr IN PROGRAM saplfc02 USING
                '' gs_tf004-dimen gs_global_params-itclg gs_global_params-rvers gs_global_params-ryear gs_global_params-period_to
                gt_4630_bunit_mark
                space.

   COMMIT WORK AND WAIT.
   IF sy-subrc = 0.
     ls_msg-id      = '/EY1/'.
     ls_msg-number  = '000'.
     ls_msg-type    = 'S'.
     ls_msg-message = | JV Release(1015): Successfully Updated For Version | && gs_global_params-rvers && | Year | && gs_global_params-ryear.
   ELSE.
     ls_msg-id      = '/EY1/'.
     ls_msg-number  = '000'.
     ls_msg-type    = 'E'.
     ls_msg-message = | JV Release(1015): Error In Update For Version | && gs_global_params-rvers && | Year | && gs_global_params-ryear.
   ENDIF.

   APPEND ls_msg TO et_message.
ENDMETHOD.


 method /EY1/IF_DATA_MONITOR~VALIDATE.
*CALL METHOD SUPER->ZIF_DATA_MONITOR~VALIDATE
**  IMPORTING
**    et_message =
*    .

   DATA: lt_tf184 TYPE TABLE OF tf184,
         ls_tf184 TYPE tf184.

   DATA:zs_msg              TYPE bapiret2,
        ld_peropen          TYPE c,
        lv_flag             TYPE fc_flg VALUE 'X'.


*   DATA: lv_year     TYPE gjahr,
*         lv_year_inv TYPE fc_ryear.

     "New
*     lv_year = gs_global_params-ryear.
*     CALL FUNCTION '/EY1/CONVERT_DATE_TO_INV_DATE'
*       EXPORTING
*         iv_year           = lv_year
*       IMPORTING
*        ev_year_inv        = lv_year_inv.

*     SELECT SINGLE rvers FROM tf184
*         INTO gs_global_params-rvers
*         WHERE dimen = gs_tf004-dimen
*         AND   congr = gs_tf004-congr
*         AND   rldnr = gs_tf004-rldnr
*         AND   ryear = lv_year_inv.
*

     SELECT  rvers FROM tf184
        UP TO 1 ROWS
        INTO CORRESPONDING FIELDS OF TABLE lt_tf184
        WHERE dimen = gs_tf004-dimen
        AND   congr = gs_global_params-congr
        AND   rldnr = gs_tf004-rldnr
        ORDER BY ryear ASCENDING.
     IF sy-subrc = 0.
       READ TABLE lt_tf184 TRANSPORTING rvers INTO ls_tf184 INDEX 1.
       IF sy-subrc = 0.
          gs_global_params-rvers = ls_tf184-rvers.
       ENDIF.
     ENDIF.
     "End


    call function 'FC_CHECK_PERIOD_OPEN'
       exporting
            e_dimen        = gs_tf004-dimen
            e_itclg        = gs_global_params-itclg
            e_rvers        = gs_global_params-rvers
            e_bunit        = gs_global_params-bunit
            e_ryear        = gs_global_params-ryear
            e_perid        = gs_global_params-period_to
            e_read_flag    = lv_flag
            e_monitor_flag = space
       importing
            i_peropen      = ld_peropen
       exceptions
            others         = 1.

  case ld_peropen.
    when '0'.
      "message e180(g0) with gs_global_params-period_to gs_global_params-ryear gs_global_params-bunit.
       zs_msg-id      = 'G0'.
       zs_msg-number = '180'.
       zs_msg-type   = 'E'.
       CALL FUNCTION 'MESSAGE_TEXT_BUILD'
         EXPORTING
           msgid                     = 'G0'
           msgnr                     = '180'
           msgv1                     = gs_global_params-period_to
           msgv2                     = gs_global_params-ryear
           msgv3                     = gs_global_params-bunit
         IMPORTING
           message_text_output       = zs_msg-message.
                 .

       APPEND zs_msg TO et_message.
    when '1'.
      "message e186(g0) with gs_global_params-period_to gs_global_params-ryear gs_global_params-bunit..
       zs_msg-id      = 'G0'.
       zs_msg-number = '186'.
       zs_msg-type   = 'E'.
       CALL FUNCTION 'MESSAGE_TEXT_BUILD'
         EXPORTING
           msgid                     = 'G0'
           msgnr                     = '186'
           msgv1                     = gs_global_params-period_to
           msgv2                     = gs_global_params-ryear
           msgv3                     = gs_global_params-bunit
         IMPORTING
           message_text_output       = zs_msg-message.
                 .

       APPEND zs_msg TO et_message.
    when others.
  endcase.
*
  endmethod.


  METHOD CONSTRUCTOR.
    super->constructor( ).
  ENDMETHOD.


  METHOD GET_INSTANCE.
   DATA: lr_obj TYPE REF TO /ey1/cl_data_monitor_jv_releas.

   IF gr_data_mon IS NOT INITIAL.
     FREE gr_data_mon.
   ENDIF.

   CREATE OBJECT lr_obj.

   gr_data_mon ?= lr_obj.

    "Get Global Param Reference
   gr_data_mon->gr_global_param = /ey1/sav_cl_global_params=>get_instance( ).

   gr_data_mon->read_global_params( ).

   IF bunit IS NOT INITIAL.
     gr_data_mon->gs_global_params-bunit = bunit.
   ENDIF.

   IF ryear IS NOT INITIAL.
     gr_data_mon->gs_global_params-ryear = ryear.
   ENDIF.

   IF intention IS NOT INITIAL.
     gr_data_mon->gs_global_params-intention = intention.
   ENDIF.

   IF period_from IS NOT INITIAL.
     gr_data_mon->gs_global_params-period_from = period_from.
   ENDIF.

   IF period_to IS NOT INITIAL.
     gr_data_mon->gs_global_params-period_to = period_to.
   ENDIF.

   IF local_currency IS NOT INITIAL.
     gr_data_mon->gs_global_params-local_currency = local_currency.
   ENDIF.

   IF local_currency_type IS NOT INITIAL.
     gr_data_mon->gs_global_params-local_currency_type = local_currency_type.
   ENDIF.

   IF group_currency IS NOT INITIAL.
     gr_data_mon->gs_global_params-group_currency = group_currency.
   ENDIF.

   IF group_currency_type IS NOT INITIAL.
     gr_data_mon->gs_global_params-group_currency_type = group_currency_type.
   ENDIF.

   IF itclg IS NOT INITIAL.
     gr_data_mon->gs_global_params-itclg = itclg.
   ENDIF.

   IF rvers IS NOT INITIAL.
     gr_data_mon->gs_global_params-rvers = rvers.
   ENDIF.

   IF rldnr IS NOT INITIAL.
     gr_data_mon->gs_tf004-rldnr         = rldnr.
   ENDIF.

   ro_data_mon ?= gr_data_mon.

  ENDMETHOD.
ENDCLASS.

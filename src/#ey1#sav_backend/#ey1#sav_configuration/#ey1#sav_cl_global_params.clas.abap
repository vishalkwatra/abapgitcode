class /EY1/SAV_CL_GLOBAL_PARAMS definition
  public
  final
  create private .

public section.

  class-methods GET_INSTANCE
    returning
      value(RO_SELF) type ref to /EY1/SAV_CL_GLOBAL_PARAMS .
  methods GET_USER_SETTINGS
    exporting
      value(ES_USER_GLOBAL_PARAMS) type /EY1/SAV_STR_GLBL_PARAMS .
protected section.
private section.

  class-data LV_SELF type ref to /EY1/SAV_CL_GLOBAL_PARAMS .
ENDCLASS.



CLASS /EY1/SAV_CL_GLOBAL_PARAMS IMPLEMENTATION.


  METHOD get_instance.

    "if the class is called for the first time i.e., an instance has never been created
    IF lv_self IS NOT BOUND.
      CREATE OBJECT ro_self. "create an object of the class
      lv_self = ro_self.
    ELSE.
      ro_self = lv_self.     "else, assign the already created instance to the returning parameter
    ENDIF.

  ENDMETHOD.


  METHOD get_user_settings.
    SELECT * FROM /ey1/globalparam
      INTO @DATA(ls_global_params) UP TO 1 ROWS
      WHERE uname = @sy-uname.
      IF sy-subrc EQ 0.
        MOVE-CORRESPONDING ls_global_params TO es_user_global_params.
      ENDIF.
    ENDSELECT.
  ENDMETHOD.
ENDCLASS.

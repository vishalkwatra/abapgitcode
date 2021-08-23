PROGRAM /ey1/rggbs000 .
*---------------------------------------------------------------------*
* Corrections/ repair
* wms092357 070703 Note 638886: template routines to be used for
*                  workaround to substitute bseg-bewar from bseg-xref1/2
*---------------------------------------------------------------------*
*                                                                     *
*   Substitutions: EXIT-Formpool for Uxxx-Exits                       *
*                                                                     *
*   This formpool is used by SAP for testing purposes only.           *
*                                                                     *
*   Note: If you define a new user exit, you have to enter your       *
*         user exit in the form routine GET_EXIT_TITLES.              *
*                                                                     *
*---------------------------------------------------------------------*
INCLUDE /EY1/FGBBGD00.
*INCLUDE fgbbgd00.              "Standard data types


*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*
*    PLEASE INCLUDE THE FOLLOWING "TYPE-POOL"  AND "TABLES" COMMANDS  *
*        IF THE ACCOUNTING MODULE IS INSTALLED IN YOUR SYSTEM         *
 TYPE-POOLS: GB002. " TO BE INCLUDED IN                       "wms092357
 TABLES: BKPF,      " ANY SYSTEM THAT                         "wms092357
         BSEG,      " HAS 'FI' INSTALLED                      "wms092357
         COBL,                                                "wms092357
         CSKS,                                                "wms092357
         ANLZ,                                                "wms092357
         GLU1.                                                "wms092357
*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*


*----------------------------------------------------------------------*
*       FORM GET_EXIT_TITLES                                           *
*----------------------------------------------------------------------*
*       returns name and title of all available standard-exits         *
*       every exit in this formpool has to be added to this form.      *
*       You have to specify a parameter type in order to enable the    *
*       code generation program to determine correctly how to          *
*       generate the user exit call, i.e. how many and what kind of    *
*       parameter(s) are used in the user exit.                        *
*       The following parameter types exist:                           *
*                                                                      *
*       TYPE                Description              Usage             *
*    ------------------------------------------------------------      *
*       C_EXIT_PARAM_NONE   Use no parameter         Subst. and Valid. *
*                           except B_RESULT                            *
*       C_EXIT_PARAM_FIELD  Use one field as param.  Only Substitution *
*       C_EXIT_PARAM_CLASS  Use a type as parameter  Subst. and Valid  *
*                                                                      *
*----------------------------------------------------------------------*
*  -->  EXIT_TAB  table with exit-name and exit-titles                 *
*                 structure: NAME(5), PARAM(1), TITEL(60)
*----------------------------------------------------------------------*
FORM get_exit_titles TABLES etab.

  DATA: BEGIN OF exits OCCURS 50,
          name(5)   TYPE c,
          param     LIKE c_exit_param_none,
          title(60) TYPE c,
        END OF exits.

  exits-name  = 'U100'.
  exits-param = c_exit_param_none.
  exits-title = text-100.             "Cost center from CSKS
  APPEND exits.

  exits-name  = 'U101'.
  exits-param = c_exit_param_field.
  exits-title = text-101.             "Cost center from CSKS
  APPEND exits.

* begin of insertion                                          "wms092357
  exits-name  = 'U200'.
  exits-param = c_exit_param_field.
  exits-title = text-200.             "Cons. transaction type
  APPEND exits.                       "from xref1/2
* end of insertion                                            "wms092357


**** [GB02]-Development for Savotta Project - Ledger Group
* begin of insertion                                          "CS4K900269
  EXITS-NAME  = 'ZGB02'.
  EXITS-PARAM = C_EXIT_PARAM_FIELD.
  EXITS-TITLE = TEXT-201.
  APPEND EXITS.
* end of insertion                                            "CS4K900269
**** [GB02]-Development for Savotta Project

**** [GB02]-Development for Savotta Project - Special Period
* begin of insertion                                          "CS4K900269
  EXITS-NAME  = 'ZGB03'.
  EXITS-PARAM = C_EXIT_PARAM_FIELD.
  EXITS-TITLE = TEXT-201.
  APPEND EXITS.
* end of insertion                                            "CS4K900269
**** [GB02]-Development for Savotta Project



************************************************************************
* PLEASE DELETE THE FIRST '*' FORM THE BEGINING OF THE FOLLOWING LINES *
*        IF THE ACCOUNTING MODULE IS INSTALLED IN YOUR SYSTEM:         *
*  EXITS-NAME  = 'U102'.
*  EXITS-PARAM = C_EXIT_PARAM_CLASS.
*  EXITS-TITLE = TEXT-102.             "Sum is used for the reference.
*  APPEND EXITS.


***********************************************************************
** EXIT EXAMPLES FROM PUBLIC SECTOR INDUSTRY SOLUTION
**
** PLEASE DELETE THE FIRST '*' FORM THE BEGINING OF THE FOLLOWING LINE
** TO ENABLE PUBLIC SECTOR EXAMPLE SUBSTITUTION EXITS
***********************************************************************
INCLUDE /EY1/RGGBS_PS_TITLES.
*  INCLUDE rggbs_ps_titles.

  REFRESH etab.
  LOOP AT exits.
    etab = exits.
    APPEND etab.
  ENDLOOP.

ENDFORM.                    "GET_EXIT_TITLES


* eject
*---------------------------------------------------------------------*
*       FORM U100                                                     *
*---------------------------------------------------------------------*
*       Reads the cost-center from the CSKS table .                   *
*---------------------------------------------------------------------*
FORM u100.

*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* PLEASE DELETE THE FIRST '*' FORM THE BEGINING OF THE FOLLOWING LINES *
*        IF THE ACCOUNTING MODULE IS INSTALLED IN YOUR SYSTEM:         *
*  SELECT * FROM CSKS
*            WHERE KOSTL EQ COBL-KOSTL
*              AND KOKRS EQ COBL-KOKRS.
*    IF CSKS-DATBI >= SY-DATUM AND
*       CSKS-DATAB <= SY-DATUM.
*
*      MOVE CSKS-ABTEI TO COBL-KOSTL.
*
*    ENDIF.
*  ENDSELECT.

ENDFORM.                                                    "U100

* eject
*---------------------------------------------------------------------*
*       FORM U101                                                     *
*---------------------------------------------------------------------*
*       Reads the cost-center from the CSKS table for accounting      *
*       area '0001'.                                                  *
*       This exit uses a parameter for the cost_center so it can      *
*       be used irrespective of the table used in the callup point.   *
*---------------------------------------------------------------------*
FORM u101 USING cost_center.

*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* PLEASE DELETE THE FIRST '*' FORM THE BEGINING OF THE FOLLOWING LINES *
*        IF THE ACCOUNTING MODULE IS INSTALLED IN YOUR SYSTEM:         *
*  SELECT * FROM CSKS
*            WHERE KOSTL EQ COST_CENTER
*              AND KOKRS EQ '0001'.
*    IF CSKS-DATBI >= SY-DATUM AND
*       CSKS-DATAB <= SY-DATUM.
*
*      MOVE CSKS-ABTEI TO COST_CENTER .
*
*    ENDIF.
*  ENDSELECT.

ENDFORM.                                                    "U101

* eject
*---------------------------------------------------------------------*
*       FORM U102                                                     *
*---------------------------------------------------------------------*
*       Inserts the sum of the posting into the reference field.      *
*       This exit can be used in FI for the complete document.        *
*       The complete data is passed in one parameter.                 *
*---------------------------------------------------------------------*


*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
* PLEASE DELETE THE FIRST '*' FORM THE BEGINING OF THE FOLLOWING LINES *
*        IF THE ACCOUNTING MODULE IS INSTALLED IN YOUR SYSTEM:         *
*FORM u102 USING bool_data TYPE gb002_015.
*DATA: SUM(10) TYPE C.
*
*    LOOP AT BOOL_DATA-BSEG INTO BSEG
*                    WHERE    SHKZG = 'S'.
*       BSEG-ZUONR = 'Test'.
*       MODIFY BOOL_DATA-BSEG FROM BSEG.
*       ADD BSEG-DMBTR TO SUM.
*    ENDLOOP.
*
*    BKPF-XBLNR = TEXT-001.
*    REPLACE '&' WITH SUM INTO BKPF-XBLNR.
*
*ENDFORM.


***********************************************************************
** EXIT EXAMPLES FROM PUBLIC SECTOR INDUSTRY SOLUTION
**
** PLEASE DELETE THE FIRST '*' FORM THE BEGINING OF THE FOLLOWING LINE
** TO ENABLE PUBLIC SECTOR EXAMPLE SUBSTITUTION EXITS
***********************************************************************
*INCLUDE rggbs_ps_forms.


*eject
* begin of insertion                                          "wms092357
*&---------------------------------------------------------------------*
*&      Form  u200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM u200 USING e_rmvct TYPE bseg-bewar.
  PERFORM xref_to_rmvct USING bkpf bseg 1 CHANGING e_rmvct.
ENDFORM.


***  [GB02]-Development for Savotta Project
FORM zgb02 USING p_ledgrp TYPE bseg-zz1_ledgergroup_cob.
  DATA: lv_chk TYPE c.
  CLEAR: lv_chk.
  IF p_ledgrp IS NOT INITIAL AND p_ledgrp = bseg-zz1_ledgergroup_cob.
    lv_chk = 'X'.
  ENDIF.

  DATA: lv_tabname TYPE dd08l-tabname.
  CLEAR: lv_tabname.
  FIELD-SYMBOLS: <ft_ldgrp> TYPE STANDARD TABLE,
                 <fs_ldgrp> TYPE any.
  DATA: gt_tab TYPE REF TO data,
        gs_tab TYPE REF TO data.


    SELECT SINGLE tabname FROM DD08L
        INTO lv_tabname
        WHERE CHECKTABLE = ( SELECT ENTITYTAB FROM DD01L WHERE DOMNAME = 'ZZ1_LEDGERGROUP' )
             AND FRKART = 'TEXT'
             AND AS4LOCAL = 'A'.

    CREATE DATA gt_tab TYPE TABLE OF (lv_tabname).
    CREATE DATA gs_tab TYPE (lv_tabname).
    ASSIGN gt_tab->* TO <ft_ldgrp>.
    ASSIGN gs_tab->* TO <fs_ldgrp>.

    SELECT * FROM (lv_tabname)
        INTO TABLE <ft_ldgrp>.

    IF sy-subrc = 0.
      LOOP AT <ft_ldgrp> ASSIGNING <fs_ldgrp>.
        DATA(lv_tab) = sy-tabix.
        ASSIGN COMPONENT 'CODE' OF STRUCTURE <fs_ldgrp> TO FIELD-SYMBOL(<fs>).
        IF <fs> IS ASSIGNED.
          IF <fs> <> bkpf-ldgrp.
            UNASSIGN: <fs>.
            DELETE <ft_ldgrp> INDEX lv_tab.
          ENDIF.
        ENDIF.
      ENDLOOP.

      IF <ft_ldgrp> IS ASSIGNED.
        READ TABLE <ft_ldgrp> ASSIGNING <fs_ldgrp> INDEX 1.
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'CODE' OF STRUCTURE <fs_ldgrp> TO FIELD-SYMBOL(<fs1>).
          IF <fs1> IS ASSIGNED.
            p_ledgrp = <fs1>.
          ELSE.
            p_ledgrp = ''.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

   CONSTANTS: c_str        TYPE string VALUE '(SAPMF05A)XBSEG[]', ##NO_TEXT
   c_ldgrp      TYPE string VALUE 'Ledger Group '. ##NO_TEXT
   FIELD-SYMBOLS: <ft_bseg> TYPE ANY TABLE,
                  <fs2> TYPE any.
   DATA: lv_msg   TYPE i,
         ls_bseg  TYPE bseg,
         lv_line  TYPE i.
   CLEAR: lv_msg,lv_line.
   ASSIGN (c_str) TO <ft_bseg>.

   IF <ft_bseg> IS ASSIGNED.
     DESCRIBE TABLE <ft_bseg> LINES lv_line.


   LOOP AT <ft_bseg> INTO ls_bseg.
     ASSIGN COMPONENT 'ZZ1_LEDGERGROUP_COB' OF STRUCTURE ls_bseg TO <fs2>.
     IF <fs2> IS ASSIGNED AND <fs2> IS NOT INITIAL.
       IF lv_chk IS INITIAL.
        lv_msg = lv_msg + 1.
       ENDIF.
     ENDIF.
   ENDLOOP.
   IF ( lv_msg = ( lv_line - 1 ) ).
    MESSAGE i032(/ey1/sav_savotta) WITH c_ldgrp.
   ENDIF.

   ENDIF.

ENDFORM.
*** [GB02]- Development for Savotta Project

***  [GB02]-Development for Savotta Project
FORM zgb03 USING p_intnsn TYPE bseg-zz1_taxintention_cob.

  DATA: lv_chk TYPE c.
  DATA: lv_tabname TYPE dd08l-tabname.
  CLEAR: lv_tabname.
  FIELD-SYMBOLS: <ft_intnsn> TYPE STANDARD TABLE,
                 <fs_intnsn> TYPE any.
  DATA: gt_tab TYPE REF TO data,
        gs_tab TYPE REF TO data.


  SELECT SINGLE tabname FROM DD08L
    INTO lv_tabname
    WHERE CHECKTABLE = ( SELECT ENTITYTAB FROM DD01L WHERE DOMNAME = 'ZZ1_TAXINTENTION' )
         AND FRKART = 'TEXT'
         AND AS4LOCAL = 'A'.

  CLEAR: lv_chk.
  IF p_intnsn IS NOT INITIAL AND p_intnsn = bseg-zz1_taxintention_cob.
    lv_chk = 'X'.
  ENDIF.
  SELECT SINGLE * FROM /ey1/fiscl_intnt
     INTO @DATA(ls_intention)
     WHERE gjahr          = @bseg-gjahr
     AND   bunit          = @bseg-bukrs
     AND   intnsn_act_flg = @space.
   IF sy-subrc = 0.
     SELECT SINGLE * FROM
       /ey1/intention
       INTO @DATA(ls_intn)
       WHERE intent = @ls_intention-intention.
     IF sy-subrc = 0.
          CREATE DATA gt_tab TYPE TABLE OF (lv_tabname).
          CREATE DATA gs_tab TYPE (lv_tabname).
          ASSIGN gt_tab->* TO <ft_intnsn>.
          ASSIGN gs_tab->* TO <fs_intnsn>.
          SELECT * FROM (lv_tabname)
            INTO TABLE <ft_intnsn>.
          IF sy-subrc = 0.
            LOOP AT <ft_intnsn> ASSIGNING <fs_intnsn>.
              DATA(lv_ind) = sy-tabix.
              ASSIGN COMPONENT 'DESCRIPTION' OF STRUCTURE <fs_intnsn> TO FIELD-SYMBOL(<fs>).
              IF <fs> IS ASSIGNED.
                IF <fs> <> ls_intn-description.
                  UNASSIGN <fs>.
                  DELETE <ft_intnsn> INDEX lv_ind.
                ENDIF.
              ENDIF.
            ENDLOOP.
          ENDIF.
         ENDIF.



      IF <ft_intnsn> IS ASSIGNED.
        READ TABLE <ft_intnsn> ASSIGNING <fs_intnsn> INDEX 1.
        IF sy-subrc = 0.
          ASSIGN COMPONENT 'CODE' OF STRUCTURE <fs_intnsn> TO FIELD-SYMBOL(<fs_code>).
          IF <fs_code> IS ASSIGNED.
            "WRITE: <fs_code>.
          ENDIF.
        ENDIF.
      ENDIF.

      IF <fs_code> IS ASSIGNED.
        p_intnsn = <fs_code>.
      ELSE.
        p_intnsn = ''.
      ENDIF.
   ELSE.
      p_intnsn = ''.
   ENDIF.


   CONSTANTS: c_str        TYPE string VALUE '(SAPMF05A)XBSEG[]', ##NO_TEXT
   c_intn      TYPE string VALUE 'Intention '. ##NO_TEXT
   FIELD-SYMBOLS: <ft_bseg> TYPE ANY TABLE,
                  <fs1> TYPE any.
   DATA: lv_msg   TYPE i,
         ls_bseg  TYPE bseg,
         lv_line  TYPE i.
   CLEAR: lv_msg,lv_line.
   ASSIGN (c_str) TO <ft_bseg>.

   IF <ft_bseg> IS ASSIGNED.
     DESCRIBE TABLE <ft_bseg> LINES lv_line.


   LOOP AT <ft_bseg> INTO ls_bseg.
     ASSIGN COMPONENT 'ZZ1_TAXINTENTION_COB' OF STRUCTURE ls_bseg TO <fs1>.
     IF <fs1> IS ASSIGNED AND <fs1> IS NOT INITIAL.
       IF lv_chk IS INITIAL.
         lv_msg = lv_msg + 1.
       ENDIF.
     ENDIF.
   ENDLOOP.
   IF ( lv_msg = ( lv_line - 1 ) ).
    MESSAGE i034(/ey1/sav_savotta) WITH c_intn.
   ENDIF.

   ENDIF.

ENDFORM.
*** [GB02]- Development for Savotta Project







*&---------------------------------------------------------------------*
*&      Form  xref_to_rmvct
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM xref_to_rmvct
     USING    is_bkpf         TYPE bkpf
              is_bseg         TYPE bseg
              i_xref_field    type i
     CHANGING c_rmvct         TYPE rmvct.

  data l_msgv type symsgv.
  statics st_rmvct type hashed table of rmvct with unique default key.

* either bseg-xref1 or bseg-xref2 must be used as source...
  if i_xref_field <> 1 and i_xref_field <> 2.
    message x000(gk) with 'UNEXPECTED VALUE I_XREF_FIELD ='
      i_xref_field '(MUST BE = 1 OR = 2)' ''.
  endif.
  if st_rmvct is initial.
    select trtyp from t856 into table st_rmvct.
  endif.
  if i_xref_field = 1.
    c_rmvct = is_bseg-xref1.
  else.
    c_rmvct = is_bseg-xref2.
  endif.
  if c_rmvct is initial.
    write i_xref_field to l_msgv left-justified.
    concatenate text-m00 l_msgv into l_msgv separated by space.
*   cons. transaction type is not specified => send an error message...
    message e123(g3) with l_msgv.
*   Bitte geben Sie im Feld &1 eine Konsolidierungsbewegungsart an
  endif.
* c_rmvct <> initial...
  read table st_rmvct transporting no fields from c_rmvct.
  check not sy-subrc is initial.
* cons. transaction type does not exist => send error message...
  write i_xref_field to l_msgv left-justified.
  concatenate text-m00 l_msgv into l_msgv separated by space.
  message e124(g3) with c_rmvct l_msgv.
* KonsBewegungsart &1 ist ungültig (bitte Eingabe im Feld &2 korrigieren
endform.
* end of insertion                                            "wms092357

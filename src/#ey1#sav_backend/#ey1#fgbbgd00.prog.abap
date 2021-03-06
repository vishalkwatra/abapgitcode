***INCLUDE FGBBGD00 .

TYPE-POOLS: gb001, gblfb, gb0fb.

*----------------------------------------------------------------------*
*       INCLUDE FGBBGD00                                               *
*----------------------------------------------------------------------*
*       The data structures needed by the calling program.             *
*----------------------------------------------------------------------*
************************************************************************
*  Data types                                                          *
************************************************************************
DATA:       d_int LIKE sy-tabix,
            d_bool TYPE c.
************************************************************************
*  Enumeration types.                                                  *
************************************************************************

*     B_         The general enumeration type for TRUE and FALSE.      *
DATA: b_true     LIKE d_bool  VALUE 'T',   "  true,
      b_false    LIKE b_true  VALUE 'F'.   "  false

*           BO_            The different boolean operator enumerations
*                          used in the boolean expressions.            *
DATA:                "             atom enumerations
            bo_and           LIKE glgb_formi-ttype  VALUE   1 ,  " AND
            bo_or            LIKE bo_and VALUE   2 ,       " OR
            bo_nor           LIKE bo_and VALUE   3 ,       " NOR
            bo_nand          LIKE bo_and VALUE   4 ,       " NAND
            bo_implication   LIKE bo_and VALUE   5 ,       " -->
            bo_coimplication LIKE bo_and VALUE   6 ,       " <->
            bo_not           LIKE bo_and VALUE   7 ,       " NOT
            bo_none          LIKE bo_and VALUE   0 ,       " no value

*           VL_    The boolean enumeration type values.  This is used  *
*                  in the subset field.  It should not be used as the  *
*                  general boolean TRUE and FALSE statements.          *
            vl_true          LIKE glgb_formi-subtype    VALUE   1 ,
            vl_false         LIKE bo_and          VALUE   2 ,

*           AT_              The different types of atoms used in the  *
*                            boolean expressions                       *
            at_none          LIKE glgb_formi-ttype        VALUE   0 ,
            at_obrack        LIKE at_none   VALUE   1 ,
            at_cbrack        LIKE at_obrack VALUE   2 ,
            at_field         LIKE at_obrack VALUE   3 ,
            at_tab           LIKE at_obrack VALUE   4 ,
            at_set           LIKE at_obrack VALUE   5 ,
            at_subrul        LIKE at_obrack VALUE   6 ,
            at_exit          LIKE at_obrack VALUE   7 ,
            at_absval        LIKE at_obrack VALUE   8 ,
            at_lit           LIKE at_obrack VALUE   9 ,
            at_relat         LIKE at_obrack VALUE  10 ,
            at_condit        LIKE at_obrack VALUE  11 ,
            at_not           LIKE at_obrack VALUE  12 ,
            at_boolop        LIKE at_obrack VALUE  13 ,
            at_in_set        LIKE at_obrack VALUE  14 ,
            at_maths         LIKE at_obrack VALUE  15 ,
* Note: at_fieldcomp must come last!!
            at_fieldcomp     LIKE at_obrack VALUE  16 .

*           BE_              The different types of                    *
*                            boolean expressions                       *
DATA:       be_subrule       LIKE d_bool      VALUE   'A' ,
            be_subst         LIKE be_subrule  VALUE   'B' ,
            be_substcond     LIKE be_subrule  VALUE   'C' ,
            be_valid         LIKE be_subrule  VALUE   'D' ,
            be_validcond     LIKE be_subrule  VALUE   'E' ,
            be_validchck     LIKE be_subrule  VALUE   'F' ,
            be_set           LIKE be_subrule  VALUE   'G' ,
            be_exit          LIKE be_subrule  VALUE   'H' ,
            be_mess          LIKE be_subrule  VALUE   'M' ,
            be_wflo          LIKE be_subrule  VALUE   'W' ,
            be_such          LIKE be_subrule  VALUE   'S' ,
            be_apprule       LIKE be_subrule  VALUE   'I' .

*           MTF_             The different types of                    *
*                            uses of maths in a boolean expression     *
DATA:       mtf_sing_none(1) TYPE c             VALUE   'A' ,
            mtf_sing_math    LIKE mtf_sing_none VALUE   'B' ,
            mtf_sing_cong    LIKE mtf_sing_none VALUE   'C' ,
            mtf_mult_none    LIKE mtf_sing_none VALUE   'D' ,
            mtf_mult_math    LIKE mtf_sing_none VALUE   'E' ,
            mtf_mult_cong    LIKE mtf_sing_none VALUE   'F' .

************************************************************************
*  Internal structures.                                                *
************************************************************************

*  This structure defines one record of the table which describes      *
*  All the atoms in the complete statement.  The order in the table    *
*  is identical to the order within the statement.                     *
*  Together with the SOLUT table this describes the complete statement.*
DATA:   BEGIN OF s_pars_formula.
        INCLUDE STRUCTURE  glgb_formi.
DATA:   END   OF s_pars_formula.

*         ttype                     " Token type
*         subtype   like bo_and   , " Subtype for boolean ops.
*         order     like d_int,     " The original sequence no. of token
*         brackid   like d_int,     " The bracket pair ID:
*         word      like d_int,     " word to which the token belongs.
*         token     like sy-lisel,  " Name of the token
*         tab       like help_info-tabname,
*                                   " Table name.
*         relat(2)  type c,         " Relation between field and literal
*         field     like help_info-fieldname ,
*                                   " Literal string for field compare
*         modifier(10) type c,      " Which part of the field to use.
*         tab2      like s_pars_formula-tab,
*         field2    like s_pars_formula-field,
*         modifier2 like s_pars_formula-modifier,
*       end of s_pars_formula.

* Internal structure for set usage.
DATA: BEGIN OF s_sets_usage.
        INCLUDE STRUCTURE gbset_name.
DATA: END   OF s_sets_usage.

* Internal structure for rule usage.
DATA: BEGIN OF s_rule_usage,
         boolid     LIKE      gb90-boolid,
      END   OF s_rule_usage.
* Internal structure for field usage.
DATA: BEGIN OF s_field_usage,
         table      LIKE      help_info-tabname,
         field      LIKE      help_info-fieldname,
      END   OF s_field_usage.

* Internal structure for exit  usage.
DATA: BEGIN OF s_exit_usage,
         exit      LIKE      gb922-exitsubst,
      END   OF s_exit_usage.

* Internal table of form routines and their line numbers.
DATA: BEGIN OF form_names OCCURS 10,
              form_name TYPE ex_cpu_val,
              start(8),
              end   LIKE sy-tabix,
              cnt   LIKE sy-tabix,
      END   OF form_names.


************************************************************************
*  Types                                                               *
************************************************************************
TYPES: class_range_str TYPE  gb001_class_range_lin.
TYPES: class_range_lst TYPE  gb001_class_range_lst.

************************************************************************
*  Common variable                                                     *
************************************************************************
DATA:
      c_modpool(10)  TYPE c    VALUE '(SAPFGBB1)',
      c_modpool_main(8)   TYPE c
                           VALUE 'SAPFGBB1',
      c_modpool_top(8)    TYPE c
                           VALUE 'FGBB1TOP',
      c_client_mem_id(10) TYPE c
                           VALUE 'VSR_CLIENT'.

*     Exit parameter types.
*       No extra parameters
DATA:   c_exit_param_none(4)  TYPE c                  VALUE '0000' ,

*       The field as an extra parameter (substitutions only)
        c_exit_param_field    LIKE c_exit_param_none  VALUE 'ffff' ,

*       The complete class record as an extra parameters.
        c_exit_param_class    LIKE c_exit_param_none  VALUE 'cccc' .


DATA: BEGIN OF COMMON PART poolname,
      g_mandt             LIKE sy-mandt,
      g_boolid            LIKE gb901-boolid,
      g_modpool           LIKE trdir-name,
      g_modpool_main      LIKE g_modpool,
      g_modpool_top       LIKE g_modpool,
      g_rulepool_main     LIKE g_modpool,
      g_setspool_main     LIKE g_modpool,
      g_valuser           LIKE gb03-valuser,
      g_valevent          LIKE gb31-valevent,
      g_suffix(2)         TYPE c,
*     flag for XPRA RGBXBR01 (release >= 40C) in action
      g_xpra(1) TYPE c,
*     flag for RGUGBR00 (coding generating reports)
      g_en_rep(1) TYPE c,
*     flag if the master data are to be read
      g_read_master_data(1) TYPE c,
*     flag = 'T' if system'contains FI'i.e. sets exist aso; = 'F' if not
      g_fi(1) TYPE c,
      END OF COMMON PART.

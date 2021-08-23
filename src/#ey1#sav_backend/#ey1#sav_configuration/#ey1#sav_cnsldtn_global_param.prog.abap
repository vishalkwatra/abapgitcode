*&---------------------------------------------------------------------*
*& Modulpool ZEY_SAV_CONSLDT_GLBL_PARAMS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM /ey1/sav_cnsldtn_global_param.

*Global data declarations
INCLUDE /ey1/sav_cnsldtn_glblparam_top.

*Process before ouput modules
INCLUDE /ey1/sav_cnsldtn_glblparam_o01.

*Process after input modules
INCLUDE /ey1/sav_cnsldtn_glblparam_i01.

*Subroutines
INCLUDE /ey1/sav_cnsldtn_glblparam_f01.

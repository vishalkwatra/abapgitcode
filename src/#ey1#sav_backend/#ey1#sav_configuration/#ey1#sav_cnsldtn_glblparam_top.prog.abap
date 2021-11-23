*&---------------------------------------------------------------------*
*& Include          ZEY_SAV_CONSLDT_GLBLPARAMS_TOP
*&---------------------------------------------------------------------*

TABLES : /ey1/globalparam. " Table to store the user dependent settings

TYPES : BEGIN OF ty_glb_curr,
          currency_with_type TYPE char20,
        END OF ty_glb_curr.

DATA : ok_code             TYPE sy-ucomm, "User command variable
       gt_glb_curr         TYPE STANDARD TABLE OF ty_glb_curr,
       gw_dynpfields       TYPE dynpread,
       gt_dynpfields       TYPE TABLE OF dynpread,
       gt_return           TYPE STANDARD TABLE OF ddshretval,
       gw_return           LIKE LINE OF gt_return,
       i_currency          TYPE char20,
       gv_name             TYPE vrm_id,
       gt_list             TYPE vrm_values,
       gw_value            LIKE LINE OF gt_list,
       gv_ok_flag(1),
       gv_bunit            TYPE fc_bunit,
       i_bunittext(50),
       i_congrtext(50),
       i_intentiontext(50).

FIELD-SYMBOLS: <fs_glb_curr> TYPE ty_glb_curr.

class /EY1/CL_SAV_D_INITIALISE_FS_IT definition
  public
  inheriting from /BOBF/CL_LIB_D_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DETERMINATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_D_INITIALISE_FS_IT IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA: lt_fs_item TYPE STANDARD TABLE OF /EY1/S_SAV_I_ACC_FS_ITEM,
          lt_ac_class TYPE STANDARD TABLE OF /EY1/S_SAV_I_ACC_CLASS,
          lt_acc_class_key TYPE /bobf/t_frw_key.

    io_read->retrieve(                                            ##NEEDED
      EXPORTING
        iv_node                 = is_ctx-node_key                 " Node Name
        it_key                  = it_key                          " Key Table
      IMPORTING
        eo_message              = DATA(lo_message)                " Message Object
        et_data                 = lt_fs_item                      " Data Return Structure
        et_failed_key           = et_failed_key  ).               " Key Table


    READ TABLE lt_fs_item INTO DATA(ls_fs_item) INDEX 1.
    lt_acc_class_key = VALUE #( ( key = ls_fs_item-root_key  ) ).

    io_read->retrieve(
      EXPORTING
        iv_node       = /EY1/IF_SAV_I_ACC_CLASS_C=>sc_node-/EY1/SAV_I_ACC_CLASS " Node Name
        it_key        = lt_acc_class_key                          " Key Table
      IMPORTING
        eo_message    = lo_message                                " Message Object
        et_data       = lt_ac_class                               " Data Return Structure
        et_failed_key = et_failed_key ).                          " Key Table

    READ TABLE lt_ac_class INTO DATA(ls_ac_class) INDEX 1.

    LOOP AT lt_fs_item REFERENCE INTO DATA(lr_fs_item) WHERE accountclasscode is INITIAL.
      lr_fs_item->accountclasscode = ls_ac_class-accountclasscode.
      io_modify->update(
        EXPORTING
          iv_node           = is_ctx-node_key                    " Node
          iv_key            = lr_fs_item->key                    " Key
          is_data           = lr_fs_item   ).                    " Data
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

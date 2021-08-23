class /EY1/CL_SAV_D_INITIALIZE_SGAAP definition
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



CLASS /EY1/CL_SAV_D_INITIALIZE_SGAAP IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.
    DATA: lt_sgaap TYPE STANDARD TABLE OF /ey1/s_sav_i_sgaap_tas,
          lt_ggaap TYPE STANDARD TABLE OF /ey1/s_sav_i_ggaap_tas,
          lt_key TYPE /bobf/t_frw_key.

    io_read->retrieve(                                            ##NEEDED
      EXPORTING
        iv_node                 = is_ctx-node_key                 " Node Name
        it_key                  = it_key                          " Key Table
      IMPORTING
        eo_message              = DATA(lo_message)                " Message Object
        et_data                 = lt_sgaap                        " Data Return Structure
        et_failed_key           = et_failed_key  ).               " Key Table

    READ TABLE lt_sgaap INTO DATA(ls_sgaap) INDEX 1.
    lt_key = VALUE #( ( key = ls_sgaap-root_key  ) ).

    io_read->retrieve(
      EXPORTING
        iv_node       = /ey1/if_sav_i_ggaap_tas_c=>sc_node-/ey1/sav_i_ggaap_tas " Node Name
        it_key        = lt_key                                                  " Key Table
      IMPORTING
        eo_message    = lo_message                                              " Message Object
        et_data       = lt_ggaap                                                " Data Return Structure
        et_failed_key = et_failed_key ).                                        " Key Table

    READ TABLE lt_ggaap INTO DATA(ls_ggaap) INDEX 1.

    LOOP AT lt_sgaap REFERENCE INTO DATA(lr_sgaap) WHERE consolidationgroup IS INITIAL.
      lr_sgaap->consolidationgroup = ls_ggaap-consolidationgroup.
      io_modify->update(
        EXPORTING
          iv_node           = is_ctx-node_key                    " Node
          iv_key            = lr_sgaap->key                      " Key
          is_data           = lr_sgaap   ).                      " Data
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

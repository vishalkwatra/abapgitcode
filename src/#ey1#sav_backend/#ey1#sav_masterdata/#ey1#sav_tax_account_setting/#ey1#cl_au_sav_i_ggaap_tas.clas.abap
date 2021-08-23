class /EY1/CL_AU_SAV_I_GGAAP_TAS definition
  public
  inheriting from /BOBF/CL_LIB_AUTH_DRAFT_ACTIVE
  final
  create public .

public section.

  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY
    redefinition .
  methods /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS /EY1/CL_AU_SAV_I_GGAAP_TAS IMPLEMENTATION.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_INSTANCE_AUTHORITY.
  endmethod.


  method /BOBF/IF_LIB_AUTH_DRAFT_ACTIVE~CHECK_STATIC_AUTHORITY.
    " Check the creation of new instance here
    AUTHORITY-CHECK OBJECT '/EY1/TAXCG' FOR USER sy-uname
                                             ID 'ACTVT' FIELD is_ctx-activity.
    IF sy-subrc EQ 0.
      rv_failed = abap_false.
    ELSE.
      rv_failed = abap_true.
    ENDIF.

    " Message handling if authorization check failed
    IF rv_failed = abap_true AND is_ctx-activity EQ /bobf/cl_frw_authority_check=>sc_activity-create.
      CALL METHOD /scmtms/cl_common_helper=>msg_helper_add_symsg(
        CHANGING
          co_message = eo_message ).

      eo_message->add_message(
  is_msg  = VALUE #( msgid = 'S7'
                     msgno = 000
                     msgv1 = text-001
                     msgty = /bobf/cm_frw=>co_severity_error
                 )
  iv_node = is_ctx-node_key
  iv_key  = is_ctx-bo_key
  iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-node_data
 ).
    ENDIF.

    IF rv_failed = abap_true AND is_ctx-activity EQ /bobf/cl_frw_authority_check=>sc_activity-change.
      CALL METHOD /scmtms/cl_common_helper=>msg_helper_add_symsg(
        CHANGING
          co_message = eo_message ).

      eo_message->add_message(
  is_msg  = VALUE #( msgid = 'S7'
                     msgno = 001
                     msgv1 = text-002
                     msgty = /bobf/cm_frw=>co_severity_error
                 )
  iv_node = is_ctx-node_key
  iv_key  = is_ctx-bo_key
  iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-node_data
 ).
    ENDIF.

   IF rv_failed = abap_true AND is_ctx-activity EQ /bobf/cl_frw_authority_check=>sc_activity-delete.
      CALL METHOD /scmtms/cl_common_helper=>msg_helper_add_symsg(
        CHANGING
          co_message = eo_message ).

      eo_message->add_message(
  is_msg  = VALUE #( msgid = 'S7'
                     msgno = 002
                     msgv1 = text-003
                     msgty = /bobf/cm_frw=>co_severity_error
                 )
  iv_node = is_ctx-node_key
  iv_key  = is_ctx-bo_key
  iv_attribute = /ey1/if_sav_i_ggaap_tas_c=>sc_node_attribute-/ey1/sav_i_sgaap_tas-node_data
 ).
    ENDIF.


  endmethod.
ENDCLASS.

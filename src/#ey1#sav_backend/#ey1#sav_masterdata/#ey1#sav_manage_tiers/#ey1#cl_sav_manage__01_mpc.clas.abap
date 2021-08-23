class /EY1/CL_SAV_MANAGE__01_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
  begin of TS_AUTH,
     CREATEALLOWED type FLAG,
     CHANGEALLOWED type FLAG,
  end of TS_AUTH .
  types:
TT_AUTH type standard table of TS_AUTH .
  types:
   begin of ts_text_element,
      artifact_name  type c length 40,       " technical name
      artifact_type  type c length 4,
      parent_artifact_name type c length 40, " technical name
      parent_artifact_type type c length 4,
      text_symbol    type textpoolky,
   end of ts_text_element .
  types:
         tt_text_elements type standard table of ts_text_element with key text_symbol .
  types:
   TS_XEY1XSAV_C_CNSLDCOUNTRYVHTY type /EY1/SAV_C_CNSLDCOUNTRYVH .
  types:
   TT_XEY1XSAV_C_CNSLDCOUNTRYVHTY type standard table of TS_XEY1XSAV_C_CNSLDCOUNTRYVHTY .
  types:
   TS_XEY1XSAV_C_COUNTRY_VHTYPE type /EY1/SAV_C_COUNTRY_VH .
  types:
   TT_XEY1XSAV_C_COUNTRY_VHTYPE type standard table of TS_XEY1XSAV_C_COUNTRY_VHTYPE .
  types:
    begin of TS_XEY1XSAV_C_INTENTIONSSTATUS.
      include type /EY1/SAV_C_INTENTIONSSTATUS.
  types:
      P_BUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_INTENTIONSSTATUS .
  types:
   TT_XEY1XSAV_C_INTENTIONSSTATUS type standard table of TS_XEY1XSAV_C_INTENTIONSSTATUS .
  types:
    begin of TS_XEY1XSAV_C_INTENTIONSSTATU.
      include type /EY1/SAV_C_INTENTIONSSTATUS.
  types:
      P_BUNIT type FC_BUNIT,
    end of TS_XEY1XSAV_C_INTENTIONSSTATU .
  types:
   TT_XEY1XSAV_C_INTENTIONSSTATU type standard table of TS_XEY1XSAV_C_INTENTIONSSTATU .
  types:
   TS_XEY1XSAV_C_READINTENTVHTYPE type /EY1/SAV_C_READINTENTVH .
  types:
   TT_XEY1XSAV_C_READINTENTVHTYPE type standard table of TS_XEY1XSAV_C_READINTENTVHTYPE .
  types:
   TS_XEY1XSAV_C_TIERSTYPE type /EY1/SAV_C_TIERS .
  types:
   TT_XEY1XSAV_C_TIERSTYPE type standard table of TS_XEY1XSAV_C_TIERSTYPE .

  constants GC_AUTH type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'AUTH' ##NO_TEXT.
  constants GC_XEY1XSAV_C_CNSLDCOUNTRYVHTY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_CnsldCountryVHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_COUNTRY_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Country_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_INTENTIONSSTATU type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_IntentionsStatusType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_INTENTIONSSTATUS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_IntentionsStatusParameters' ##NO_TEXT.
  constants GC_XEY1XSAV_C_READINTENTVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ReadIntentVHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_TIERSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_TIERSType' ##NO_TEXT.

  methods LOAD_TEXT_ELEMENTS
  final
    returning
      value(RT_TEXT_ELEMENTS) type TT_TEXT_ELEMENTS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  methods DEFINE_AUTH
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS /EY1/CL_SAV_MANAGE__01_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'EY1.SAV_MANAGE_TIER_SRV' ).

define_auth( ).
define_rds_4( ).
get_last_modified_rds_4( ).
  endmethod.


  method DEFINE_AUTH.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  data:
        lo_annotation     type ref to /iwbep/if_mgw_odata_annotation,                "#EC NEEDED
        lo_entity_type    type ref to /iwbep/if_mgw_odata_entity_typ,                "#EC NEEDED
        lo_complex_type   type ref to /iwbep/if_mgw_odata_cmplx_type,                "#EC NEEDED
        lo_property       type ref to /iwbep/if_mgw_odata_property,                  "#EC NEEDED
        lo_entity_set     type ref to /iwbep/if_mgw_odata_entity_set.                "#EC NEEDED

***********************************************************************************************************************************
*   ENTITY - AUTH
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'AUTH' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'createAllowed' iv_abap_fieldname = 'CREATEALLOWED' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'changeAllowed' iv_abap_fieldname = 'CHANGEALLOWED' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_boolean( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE__01_MPC=>TS_AUTH' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'AUTHSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_false ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
    TRY.
        if_sadl_gw_model_exposure_data~get_model_exposure( )->expose( model )->expose_vocabulary( vocab_anno_model ).
      CATCH cx_sadl_exposure_error INTO DATA(lx_sadl_exposure_error).
        RAISE EXCEPTION TYPE /iwbep/cx_mgw_med_exception
          EXPORTING
            previous = lx_sadl_exposure_error.
    ENDTRY.
  endmethod.


  method GET_LAST_MODIFIED.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20210823024756'.                  "#EC NOTEXT
 DATA: lv_rds_last_modified TYPE timestamp .
  rv_last_modified = super->get_last_modified( ).
  IF rv_last_modified LT lc_gen_date_time.
    rv_last_modified = lc_gen_date_time.
  ENDIF.
 lv_rds_last_modified =  GET_LAST_MODIFIED_RDS_4( ).
 IF rv_last_modified LT lv_rds_last_modified.
 rv_last_modified  = lv_rds_last_modified .
 ENDIF .
  endmethod.


  method GET_LAST_MODIFIED_RDS_4.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS          &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL   &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                    &*
*&                                                                     &*
*&---------------------------------------------------------------------*
*   This code is generated for Reference Data Source
*   4
*&---------------------------------------------------------------------*
*    @@TYPE_SWITCH:
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20210823044757'.
    TRY.
        rv_last_modified_rds = CAST cl_sadl_gw_model_exposure( if_sadl_gw_model_exposure_data~get_model_exposure( ) )->get_last_modified( ).
      CATCH cx_root ##CATCH_ALL.
        rv_last_modified_rds = co_gen_date_time.
    ENDTRY.
    IF rv_last_modified_rds < co_gen_date_time.
      rv_last_modified_rds = co_gen_date_time.
    ENDIF.
  endmethod.


  method IF_SADL_GW_MODEL_EXPOSURE_DATA~GET_MODEL_EXPOSURE.
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20210823044757'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="V2" >|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_CNSLDCOUNTRYVH" binding="/EY1/SAV_C_CNSLDCOUNTRYVH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_COUNTRY_VH" binding="/EY1/SAV_C_COUNTRY_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_INTENTIONSSTATUS" binding="/EY1/SAV_C_INTENTIONSSTATUS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_READINTENTVH" binding="/EY1/SAV_C_READINTENTVH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_TIERS" binding="/EY1/SAV_C_TIERS" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xEY1xSAV_C_CnsldCountryVH" dataSource="/EY1/SAV_C_CNSLDCOUNTRYVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_Country_VH" dataSource="/EY1/SAV_C_COUNTRY_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_IntentionsStatusSet" dataSource="/EY1/SAV_C_INTENTIONSSTATUS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ReadIntentVH" dataSource="/EY1/SAV_C_READINTENTVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_TIERS" dataSource="/EY1/SAV_C_TIERS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( '/EY1/SAV_MANAGE_TIER' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.


  method LOAD_TEXT_ELEMENTS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


DATA:
     ls_text_element TYPE ts_text_element.                                 "#EC NEEDED
CLEAR ls_text_element.
  endmethod.
ENDCLASS.

class /EY1/CL_SAV_TAX_ACCOUN_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
    begin of TS_XEY1XSAV_C_GGAAP_TASTYPE.
      include type /EY1/SAV_C_GGAAP_TAS.
  types:
      HASDRAFTENTITY type SDRAFT_FIELDS-HASDRAFTENTITY,
      DRAFTUUID type SDRAFT_FIELDS-DRAFTUUID,
      DRAFTENTITYCREATIONDATETIME type SDRAFT_FIELDS-DRAFTENTITYCREATIONDATETIME,
      DRAFTENTITYLASTCHANGEDATETIME type SDRAFT_FIELDS-DRAFTENTITYLASTCHANGEDATETIME,
      HASACTIVEENTITY type SDRAFT_FIELDS-HASACTIVEENTITY,
      ISACTIVEENTITY type SDRAFT_FIELDS-ISACTIVEENTITY,
      A_ACTIVATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_EDIT type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_PREPARATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_VALIDATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      F_CHANGEDBY type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_CHANGEDON type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_CONSOLIDATIONGROUPFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      M_DELETE type SADL_GW_DYNAMIC_METH_PROPERTY,
      M_UPDATE type SADL_GW_DYNAMIC_METH_PROPERTY,
    end of TS_XEY1XSAV_C_GGAAP_TASTYPE .
  types:
   TT_XEY1XSAV_C_GGAAP_TASTYPE type standard table of TS_XEY1XSAV_C_GGAAP_TASTYPE .
  types:
    begin of TS_XEY1XSAV_C_SGAAP_TASTYPE.
      include type /EY1/SAV_C_SGAAP_TAS.
  types:
      HASDRAFTENTITY type SDRAFT_FIELDS-HASDRAFTENTITY,
      DRAFTUUID type SDRAFT_FIELDS-DRAFTUUID,
      PARENTDRAFTUUID type SDRAFT_FIELDS-PARENTDRAFTUUID,
      DRAFTENTITYCREATIONDATETIME type SDRAFT_FIELDS-DRAFTENTITYCREATIONDATETIME,
      DRAFTENTITYLASTCHANGEDATETIME type SDRAFT_FIELDS-DRAFTENTITYLASTCHANGEDATETIME,
      HASACTIVEENTITY type SDRAFT_FIELDS-HASACTIVEENTITY,
      ISACTIVEENTITY type SDRAFT_FIELDS-ISACTIVEENTITY,
      A_PREPARATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      A_VALIDATION type SADL_GW_DYNAMIC_ACTN_PROPERTY,
      F_CHANGEDBY type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_CHANGEDON type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_CONSOLIDATIONUNITFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      M_DELETE type SADL_GW_DYNAMIC_METH_PROPERTY,
      M_UPDATE type SADL_GW_DYNAMIC_METH_PROPERTY,
    end of TS_XEY1XSAV_C_SGAAP_TASTYPE .
  types:
   TT_XEY1XSAV_C_SGAAP_TASTYPE type standard table of TS_XEY1XSAV_C_SGAAP_TASTYPE .
  types:
   TS_XEY1XSAV_I_CLASSIFICATION_V type /EY1/SAV_I_CLASSIFICATION_VH .
  types:
   TT_XEY1XSAV_I_CLASSIFICATION_V type standard table of TS_XEY1XSAV_I_CLASSIFICATION_V .
  types:
   TS_XEY1XSAV_I_DTARECOGNITION_V type /EY1/SAV_I_DTARECOGNITION_VH .
  types:
   TT_XEY1XSAV_I_DTARECOGNITION_V type standard table of TS_XEY1XSAV_I_DTARECOGNITION_V .
  types:
   TS_XEY1XSAV_I_DTICELIMINATION_ type /EY1/SAV_I_DTICELIMINATION_VH .
  types:
   TT_XEY1XSAV_I_DTICELIMINATION_ type standard table of TS_XEY1XSAV_I_DTICELIMINATION_ .
  types:
   TS_XEY1XSAV_I_TAXRATECHANGE_VH type /EY1/SAV_I_TAXRATECHANGE_VH .
  types:
   TT_XEY1XSAV_I_TAXRATECHANGE_VH type standard table of TS_XEY1XSAV_I_TAXRATECHANGE_VH .
  types:
   TS_C_CNSLDTNGROUPALLVHTYPE type C_CNSLDTNGROUPALLVH .
  types:
   TT_C_CNSLDTNGROUPALLVHTYPE type standard table of TS_C_CNSLDTNGROUPALLVHTYPE .
  types:
   TS_C_CNSLDTNUNITVALUEHELPTYPE type C_CNSLDTNUNITVALUEHELP .
  types:
   TT_C_CNSLDTNUNITVALUEHELPTYPE type standard table of TS_C_CNSLDTNUNITVALUEHELPTYPE .
  types:
   TS_I_DRAFTADMINISTRATIVEDATATY type I_DRAFTADMINISTRATIVEDATA .
  types:
   TT_I_DRAFTADMINISTRATIVEDATATY type standard table of TS_I_DRAFTADMINISTRATIVEDATATY .

  constants GC_C_CNSLDTNGROUPALLVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnGroupAllVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNUNITVALUEHELPTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnUnitValueHelpType' ##NO_TEXT.
  constants GC_I_DRAFTADMINISTRATIVEDATATY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_DraftAdministrativeDataType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_GGAAP_TASTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_GGAAP_TASType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_SGAAP_TASTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_SGAAP_TASType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_CLASSIFICATION_V type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_CLASSIFICATION_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_DTARECOGNITION_V type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_DTARecognition_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_DTICELIMINATION_ type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_DTICElimination_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_TAXRATECHANGE_VH type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_TaxRateChange_VHType' ##NO_TEXT.

  methods DEFINE
    redefinition .
  methods GET_LAST_MODIFIED
    redefinition .
protected section.
private section.

  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS /EY1/CL_SAV_TAX_ACCOUN_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'EY1.SAV_TAX_ACCOUNT_SETTING_SRV' ).

define_rds_4( ).
get_last_modified_rds_4( ).
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


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20210217173800'.                  "#EC NOTEXT
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
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20210217183801'.
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
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20210217183801'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_GGAAP_TAS" binding="/EY1/SAV_C_GGAAP_TAS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_SGAAP_TAS" binding="/EY1/SAV_C_SGAAP_TAS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_CLASSIFICATION_VH" binding="/EY1/SAV_I_CLASSIFICATION_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_DTARECOGNITION_VH" binding="/EY1/SAV_I_DTARECOGNITION_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_DTICELIMINATION_VH" binding="/EY1/SAV_I_DTICELIMINATION_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_TAXRATECHANGE_VH" binding="/EY1/SAV_I_TAXRATECHANGE_VH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNGROUPALLVH" binding="C_CNSLDTNGROUPALLVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNUNITVALUEHELP" binding="C_CNSLDTNUNITVALUEHELP" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xEY1xSAV_C_GGAAP_TAS" dataSource="/EY1/SAV_C_GGAAP_TAS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CLASSIFICATION" binding="_CLASSIFICATION" target="xEY1xSAV_I_CLASSIFICATION_VH" cardinality="one" />|  &
               | <sadl:association name="TO_DTARECOGNITION" binding="_DTARECOGNITION" target="xEY1xSAV_I_DTARecognition_VH" cardinality="one" />|  &
               | <sadl:association name="TO_DTICELIMINATION" binding="_DTICELIMINATION" target="xEY1xSAV_I_DTICElimination_VH" cardinality="one" />|  &
               | <sadl:association name="TO_SGAAP" binding="_SGAAP" target="xEY1xSAV_C_SGAAP_TAS" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_TAXRATECHANGE" binding="_TAXRATECHANGE" target="xEY1xSAV_I_TaxRateChange_VH" cardinality="one" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_SGAAP_TAS" dataSource="/EY1/SAV_C_SGAAP_TAS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_CLASSIFICATION_VH" dataSource="/EY1/SAV_I_CLASSIFICATION_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_DTARecognition_VH" dataSource="/EY1/SAV_I_DTARECOGNITION_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_DTICElimination_VH" dataSource="/EY1/SAV_I_DTICELIMINATION_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_TaxRateChange_VH" dataSource="/EY1/SAV_I_TAXRATECHANGE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnGroupAllVH" dataSource="C_CNSLDTNGROUPALLVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnUnitValueHelp" dataSource="C_CNSLDTNUNITVALUEHELP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( '/EY1/SAV_TAX_ACCOUNT_SETTING' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.
ENDCLASS.

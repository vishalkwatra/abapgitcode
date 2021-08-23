class /EY1/CL_SAV_TAX_RATES_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
   TS_XEY1XI_READINTENTVHTYPE type /EY1/I_READINTENTVH .
  types:
   TT_XEY1XI_READINTENTVHTYPE type standard table of TS_XEY1XI_READINTENTVHTYPE .
  types:
    begin of TS_XEY1XSAV_C_CTR_TAX_RATESTYP.
      include type /EY1/SAV_C_CTR_TAX_RATES.
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
      F_CHANGED_BY type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_CHANGED_ON type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_GJAHRFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_INTENTIONFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_RBUNITFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      M_DELETE type SADL_GW_DYNAMIC_METH_PROPERTY,
      M_UPDATE type SADL_GW_DYNAMIC_METH_PROPERTY,
    end of TS_XEY1XSAV_C_CTR_TAX_RATESTYP .
  types:
   TT_XEY1XSAV_C_CTR_TAX_RATESTYP type standard table of TS_XEY1XSAV_C_CTR_TAX_RATESTYP .
  types:
   TS_C_CNSLDTNUNITVALUEHELPTYPE type C_CNSLDTNUNITVALUEHELP .
  types:
   TT_C_CNSLDTNUNITVALUEHELPTYPE type standard table of TS_C_CNSLDTNUNITVALUEHELPTYPE .
  types:
    begin of TS_I_CNSLDTNDIMENSIONTYPE.
      include type I_CNSLDTNDIMENSION.
  types:
      T_CONSOLIDATIONDIMENSION type I_CNSLDTNDIMENSIONT-CONSOLIDATIONDIMENSIONTEXT,
    end of TS_I_CNSLDTNDIMENSIONTYPE .
  types:
   TT_I_CNSLDTNDIMENSIONTYPE type standard table of TS_I_CNSLDTNDIMENSIONTYPE .
  types:
   TS_I_CNSLDTNUNITTTYPE type I_CNSLDTNUNITT .
  types:
   TT_I_CNSLDTNUNITTTYPE type standard table of TS_I_CNSLDTNUNITTTYPE .
  types:
   TS_I_DRAFTADMINISTRATIVEDATATY type I_DRAFTADMINISTRATIVEDATA .
  types:
   TT_I_DRAFTADMINISTRATIVEDATATY type standard table of TS_I_DRAFTADMINISTRATIVEDATATY .
  types:
    begin of TS_I_LANGUAGETYPE.
      include type I_LANGUAGE.
  types:
      T_LANGUAGE type I_LANGUAGETEXT-LANGUAGENAME,
    end of TS_I_LANGUAGETYPE .
  types:
   TT_I_LANGUAGETYPE type standard table of TS_I_LANGUAGETYPE .
  types:
   TS_Z_I_READINTENTVHTYPE type Z_I_READINTENTVH .
  types:
   TT_Z_I_READINTENTVHTYPE type standard table of TS_Z_I_READINTENTVHTYPE .

  constants GC_C_CNSLDTNUNITVALUEHELPTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnUnitValueHelpType' ##NO_TEXT.
  constants GC_I_CNSLDTNDIMENSIONTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_CnsldtnDimensionType' ##NO_TEXT.
  constants GC_I_CNSLDTNUNITTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_CnsldtnUnitTType' ##NO_TEXT.
  constants GC_I_DRAFTADMINISTRATIVEDATATY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_DraftAdministrativeDataType' ##NO_TEXT.
  constants GC_I_LANGUAGETYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_LanguageType' ##NO_TEXT.
  constants GC_XEY1XI_READINTENTVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xI_ReadIntentVHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_CTR_TAX_RATESTYP type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_CTR_Tax_RatesType' ##NO_TEXT.
  constants GC_Z_I_READINTENTVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Z_I_ReadIntentVHType' ##NO_TEXT.

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



CLASS /EY1/CL_SAV_TAX_RATES_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'EY1.SAV_TAX_RATES_SRV' ).

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


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20210119102226'.                  "#EC NOTEXT
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
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20210119112227'.
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
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20210119112227'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="/EY1/I_READINTENTVH" binding="/EY1/I_READINTENTVH" />|  &
               | <sadl:dataSource type="CDS" name="I_CNSLDTNUNITT" binding="I_CNSLDTNUNITT" />|  &
               | <sadl:dataSource type="CDS" name="I_LANGUAGE" binding="I_LANGUAGE" />|  &
               | <sadl:dataSource type="CDS" name="Z_I_READINTENTVH" binding="Z_I_READINTENTVH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_CTR_TAX_RATES" binding="/EY1/SAV_C_CTR_TAX_RATES" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNUNITVALUEHELP" binding="C_CNSLDTNUNITVALUEHELP" />|  &
               | <sadl:dataSource type="CDS" name="I_CNSLDTNDIMENSION" binding="I_CNSLDTNDIMENSION" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xEY1xI_ReadIntentVH" dataSource="/EY1/I_READINTENTVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="I_CnsldtnUnitT" dataSource="I_CNSLDTNUNITT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_DIMENSION" binding="_DIMENSION" target="I_CnsldtnDimension" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_LANGUAGE" binding="_LANGUAGE" target="I_Language" cardinality="zeroToOne" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="I_Language" dataSource="I_LANGUAGE" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="Z_I_ReadIntentVH" dataSource="Z_I_READINTENTVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_CTR_Tax_Rates" dataSource="/EY1/SAV_C_CTR_TAX_RATES" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CNSLDTNUNITTEXT" binding="_CNSLDTNUNITTEXT" target="I_CnsldtnUnitT" cardinality="one" />|  &
               | <sadl:association name="TO_INTENTVH" binding="_INTENTVH" target="xEY1xI_ReadIntentVH" cardinality="one" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnUnitValueHelp" dataSource="C_CNSLDTNUNITVALUEHELP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="I_CnsldtnDimension" dataSource="I_CNSLDTNDIMENSION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( '/EY1/SAV_TAX_RATES' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.
ENDCLASS.

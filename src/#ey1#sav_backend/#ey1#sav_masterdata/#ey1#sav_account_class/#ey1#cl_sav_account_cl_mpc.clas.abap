class /EY1/CL_SAV_ACCOUNT_CL_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
    begin of TS_XEY1XSAV_C_ACC_CLASSTYPE.
      include type /EY1/SAV_C_ACC_CLASS.
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
      F_ACCOUNTCLASSCODEFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_CURRENTNONCURRENT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      M_DELETE type SADL_GW_DYNAMIC_METH_PROPERTY,
      M_UPDATE type SADL_GW_DYNAMIC_METH_PROPERTY,
    end of TS_XEY1XSAV_C_ACC_CLASSTYPE .
  types:
   TT_XEY1XSAV_C_ACC_CLASSTYPE type standard table of TS_XEY1XSAV_C_ACC_CLASSTYPE .
  types:
    begin of TS_XEY1XSAV_C_ACC_FS_ITEMTYPE.
      include type /EY1/SAV_C_ACC_FS_ITEM.
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
      F_CONSOLIDATIONCOAFOREDIT type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      F_FINANCIALSTATEMENTIT_A622884 type SADL_GW_DYNAMIC_FIELD_PROPERTY,
      M_DELETE type SADL_GW_DYNAMIC_METH_PROPERTY,
      M_UPDATE type SADL_GW_DYNAMIC_METH_PROPERTY,
    end of TS_XEY1XSAV_C_ACC_FS_ITEMTYPE .
  types:
   TT_XEY1XSAV_C_ACC_FS_ITEMTYPE type standard table of TS_XEY1XSAV_C_ACC_FS_ITEMTYPE .
  types:
   TS_XEY1XSAV_I_ACCTYPE_VHTYPE type /EY1/SAV_I_ACCTYPE_VH .
  types:
   TT_XEY1XSAV_I_ACCTYPE_VHTYPE type standard table of TS_XEY1XSAV_I_ACCTYPE_VHTYPE .
  types:
   TS_XEY1XSAV_I_ACC_CLASS_TEXTTY type /EY1/SAV_I_ACC_CLASS_TEXT .
  types:
   TT_XEY1XSAV_I_ACC_CLASS_TEXTTY type standard table of TS_XEY1XSAV_I_ACC_CLASS_TEXTTY .
  types:
   TS_XEY1XSAV_I_FSTYPE_VHTYPE type /EY1/SAV_I_FSTYPE_VH .
  types:
   TT_XEY1XSAV_I_FSTYPE_VHTYPE type standard table of TS_XEY1XSAV_I_FSTYPE_VHTYPE .
  types:
   TS_XEY1XSAV_I_TRANSACTIONTYPE_ type /EY1/SAV_I_TRANSACTIONTYPE_VH .
  types:
   TT_XEY1XSAV_I_TRANSACTIONTYPE_ type standard table of TS_XEY1XSAV_I_TRANSACTIONTYPE_ .
  types:
   TS_C_CNSLDTNCHARTOFACCOUNTSVHT type C_CNSLDTNCHARTOFACCOUNTSVH .
  types:
   TT_C_CNSLDTNCHARTOFACCOUNTSVHT type standard table of TS_C_CNSLDTNCHARTOFACCOUNTSVHT .
  types:
   TS_C_CNSLDTNFSITEMINCLRPTGITEM type C_CNSLDTNFSITEMINCLRPTGITEMVH .
  types:
   TT_C_CNSLDTNFSITEMINCLRPTGITEM type standard table of TS_C_CNSLDTNFSITEMINCLRPTGITEM .
  types:
   TS_I_DRAFTADMINISTRATIVEDATATY type I_DRAFTADMINISTRATIVEDATA .
  types:
   TT_I_DRAFTADMINISTRATIVEDATATY type standard table of TS_I_DRAFTADMINISTRATIVEDATATY .
  types:
   TS_Z_I_ACCTYPE_VHTYPE type Z_I_ACCTYPE_VH .
  types:
   TT_Z_I_ACCTYPE_VHTYPE type standard table of TS_Z_I_ACCTYPE_VHTYPE .
  types:
   TS_Z_I_FSTYPE_VHTYPE type Z_I_FSTYPE_VH .
  types:
   TT_Z_I_FSTYPE_VHTYPE type standard table of TS_Z_I_FSTYPE_VHTYPE .
  types:
   TS_Z_I_TRANSACTIONTYPE_VHTYPE type Z_I_TRANSACTIONTYPE_VH .
  types:
   TT_Z_I_TRANSACTIONTYPE_VHTYPE type standard table of TS_Z_I_TRANSACTIONTYPE_VHTYPE .

  constants GC_C_CNSLDTNCHARTOFACCOUNTSVHT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnChartOfAccountsVHType' ##NO_TEXT.
  constants GC_C_CNSLDTNFSITEMINCLRPTGITEM type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnFSItemInclRptgItemVHType' ##NO_TEXT.
  constants GC_I_DRAFTADMINISTRATIVEDATATY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_DraftAdministrativeDataType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ACC_CLASSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Acc_ClassType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_ACC_FS_ITEMTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_Acc_FS_ItemType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_ACCTYPE_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_AccType_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_ACC_CLASS_TEXTTY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_Acc_Class_TextType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_FSTYPE_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_FSType_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_I_TRANSACTIONTYPE_ type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_I_TransactionType_VHType' ##NO_TEXT.
  constants GC_Z_I_ACCTYPE_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Z_I_ACCTYPE_VHType' ##NO_TEXT.
  constants GC_Z_I_FSTYPE_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Z_I_FSTYPE_VHType' ##NO_TEXT.
  constants GC_Z_I_TRANSACTIONTYPE_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Z_I_TransactionType_VHType' ##NO_TEXT.

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



CLASS /EY1/CL_SAV_ACCOUNT_CL_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'EY1.SAV_ACCOUNT_CLASS_SRV' ).

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


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20210119102239'.                  "#EC NOTEXT
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
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20210119112240'.
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
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20210119112240'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ACC_CLASS" binding="/EY1/SAV_C_ACC_CLASS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_ACCTYPE_VH" binding="/EY1/SAV_I_ACCTYPE_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_ACC_CLASS_TEXT" binding="/EY1/SAV_I_ACC_CLASS_TEXT" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_FSTYPE_VH" binding="/EY1/SAV_I_FSTYPE_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_I_TRANSACTIONTYPE_VH" binding="/EY1/SAV_I_TRANSACTIONTYPE_VH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNCHARTOFACCOUNTSVH" binding="C_CNSLDTNCHARTOFACCOUNTSVH" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNFSITEMINCLRPTGITEMVH" binding="C_CNSLDTNFSITEMINCLRPTGITEMVH" />|  &
               | <sadl:dataSource type="CDS" name="Z_I_ACCTYPE_VH" binding="Z_I_ACCTYPE_VH" />|  &
               | <sadl:dataSource type="CDS" name="Z_I_FSTYPE_VH" binding="Z_I_FSTYPE_VH" />|  &
               | <sadl:dataSource type="CDS" name="Z_I_TRANSACTIONTYPE_VH" binding="Z_I_TRANSACTIONTYPE_VH" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_ACC_FS_ITEM" binding="/EY1/SAV_C_ACC_FS_ITEM" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xEY1xSAV_C_Acc_Class" dataSource="/EY1/SAV_C_ACC_CLASS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_ACCCLASSCODETEXT" binding="_ACCCLASSCODETEXT" target="xEY1xSAV_I_Acc_Class_Text" cardinality="one" />|  &
               | <sadl:association name="TO_ACCOUNTTYPETEXT" binding="_ACCOUNTTYPETEXT" target="xEY1xSAV_I_AccType_VH" cardinality="one" />|  &
               | <sadl:association name="TO_FINSTATITEM" binding="_FINSTATITEM" target="xEY1xSAV_C_Acc_FS_Item" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_FSTYPETEXT" binding="_FSTYPETEXT" target="xEY1xSAV_I_FSType_VH" cardinality="one" />|  &
               | <sadl:association name="TO_TRANSACTIONTYPETEXT" binding="_TRANSACTIONTYPETEXT" target="xEY1xSAV_I_TransactionType_VH" cardinality="one" />|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_AccType_VH" dataSource="/EY1/SAV_I_ACCTYPE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_Acc_Class_Text" dataSource="/EY1/SAV_I_ACC_CLASS_TEXT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_FSType_VH" dataSource="/EY1/SAV_I_FSTYPE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_I_TransactionType_VH" dataSource="/EY1/SAV_I_TRANSACTIONTYPE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnChartOfAccountsVH" dataSource="C_CNSLDTNCHARTOFACCOUNTSVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnFSItemInclRptgItemVH" dataSource="C_CNSLDTNFSITEMINCLRPTGITEMVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="Z_I_ACCTYPE_VH" dataSource="Z_I_ACCTYPE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               |</sadl:structure>|  &
               |<sadl:structure name="Z_I_FSTYPE_VH" dataSource="Z_I_FSTYPE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="Z_I_TransactionType_VH" dataSource="Z_I_TRANSACTIONTYPE_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_Acc_FS_Item" dataSource="/EY1/SAV_C_ACC_FS_ITEM" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( '/EY1/SAV_ACCOUNT_CLASS' )
                                                                    iv_timestamp = co_gen_timestamp
                                                                    iv_sadl_xml  = lv_sadl_xml ).
  endmethod.
ENDCLASS.

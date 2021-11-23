class /EY1/CL_SAV_MANAGE_INT_MPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_MODEL
  create public .

public section.

  interfaces IF_SADL_GW_MODEL_EXPOSURE_DATA .

  types:
    begin of TS_BALANCETRASNFERDATAMONITOR,
        PERIODTO type string,
        LEDGER type string,
        FISCALYEAR type string,
        CONSOLIDATIONUNIT type string,
        INTENTION type string,
    end of TS_BALANCETRASNFERDATAMONITOR .
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
     TS_INTENTIONS type /EY1/TS_FISCL_INTNT .
  types:
TT_INTENTIONS type standard table of TS_INTENTIONS .
  types:
  begin of TS_INTENTIONVALUES,
     GJAHR type string,
     SERIALNUMBER type string,
     INTENTION type string,
     DESCRIPTION type string,
     PERIODTO type string,
  end of TS_INTENTIONVALUES .
  types:
TT_INTENTIONVALUES type standard table of TS_INTENTIONVALUES .
  types:
  begin of TS_AUTH,
     CREATEALLOWED type FLAG,
     CHANGEALLOWED type FLAG,
  end of TS_AUTH .
  types:
TT_AUTH type standard table of TS_AUTH .
  types:
  begin of TS_BALANCETRANSFERDATAMONITOR,
     TYPE type C length 1,
     ID type C length 20,
     NUMBER type C length 3,
     MESSAGETEXT type C length 220,
     LOGNO type C length 20,
     LOGMSGNO type C length 6,
     MESSAGEV1 type C length 50,
     MESSAGEV2 type C length 50,
     MESSAGEV3 type C length 50,
     MESSAGEV4 type C length 50,
     PARAMETER type C length 32,
     ROW type I,
     FIELD type C length 30,
     SYSTEM type C length 10,
     GUID type SYSUUID_X,
     LOGNUMBER type SYSUUID_X,
     URL type string,
  end of TS_BALANCETRANSFERDATAMONITOR .
  types:
TT_BALANCETRANSFERDATAMONITOR type standard table of TS_BALANCETRANSFERDATAMONITOR .
  types:
  begin of TS_LEDGER,
     BUNIT type string,
     RLDNR type string,
  end of TS_LEDGER .
  types:
TT_LEDGER type standard table of TS_LEDGER .
  types:
  begin of TS_INTENTIONSMAPPING,
     INTENTION type string,
     INTENTIONDESCRIPTION type string,
     PERIODTO type string,
  end of TS_INTENTIONSMAPPING .
  types:
TT_INTENTIONSMAPPING type standard table of TS_INTENTIONSMAPPING .
  types:
    begin of TS_XEY1XC_INTENTIONS_VHPARAMET.
      include type /EY1/C_INTENTIONS_VH.
  types:
      P_BUNIT type FC_BUNIT,
      P_GJAHR type GJAHR,
    end of TS_XEY1XC_INTENTIONS_VHPARAMET .
  types:
   TT_XEY1XC_INTENTIONS_VHPARAMET type standard table of TS_XEY1XC_INTENTIONS_VHPARAMET .
  types:
    begin of TS_XEY1XC_INTENTIONS_VHTYPE.
      include type /EY1/C_INTENTIONS_VH.
  types:
      P_BUNIT type FC_BUNIT,
      P_GJAHR type GJAHR,
    end of TS_XEY1XC_INTENTIONS_VHTYPE .
  types:
   TT_XEY1XC_INTENTIONS_VHTYPE type standard table of TS_XEY1XC_INTENTIONS_VHTYPE .
  types:
    begin of TS_XEY1XSAV_C_INTENTIONSTYPE.
      include type /EY1/SAV_C_INTENTIONS.
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
    end of TS_XEY1XSAV_C_INTENTIONSTYPE .
  types:
   TT_XEY1XSAV_C_INTENTIONSTYPE type standard table of TS_XEY1XSAV_C_INTENTIONSTYPE .
  types:
   TS_XEY1XSAV_C_READINTENTVHTYPE type /EY1/SAV_C_READINTENTVH .
  types:
   TT_XEY1XSAV_C_READINTENTVHTYPE type standard table of TS_XEY1XSAV_C_READINTENTVHTYPE .
  types:
   TS_CONSOLIDATIONDIMENSIONTYPE type A_CNSLDTNDIMENSION .
  types:
   TT_CONSOLIDATIONDIMENSIONTYPE type standard table of TS_CONSOLIDATIONDIMENSIONTYPE .
  types:
   TS_TRANSACTIONCURRENCYTEXTTYPE type A_CNSLDTNTRANSCURRENCYT .
  types:
   TT_TRANSACTIONCURRENCYTEXTTYPE type standard table of TS_TRANSACTIONCURRENCYTEXTTYPE .
  types:
    begin of TS_CONSOLIDATIONUNITTYPE.
      include type A_CNSLDTNUNIT.
  types:
      T_CONSOLIDATIONUNIT type A_CNSLDTNUNITT-CONSOLIDATIONUNITTEXT,
      T_CONSOLIDATIONUNITLOC_585D1CB type A_CNSLDTNTRANSCURRENCYT-TRANSACTIONCURRENCYTEXT,
    end of TS_CONSOLIDATIONUNITTYPE .
  types:
   TT_CONSOLIDATIONUNITTYPE type standard table of TS_CONSOLIDATIONUNITTYPE .
  types:
    begin of TS_CONSOLIDATIONUNITHIERTYPE.
      include type A_CNSLDTNUNITHIER.
  types:
      T_HIERARCHYNODE type A_CNSLDTNUNITHIERT-HIERARCHYNODETEXT,
      T_CONSOLIDATIONUNIT type A_CNSLDTNUNITT-CONSOLIDATIONUNITTEXT,
    end of TS_CONSOLIDATIONUNITHIERTYPE .
  types:
   TT_CONSOLIDATIONUNITHIERTYPE type standard table of TS_CONSOLIDATIONUNITHIERTYPE .
  types:
   TS_CNSLDTNUNITLATESTLOCALCRCYT type A_CNSLDTNUNITLATESTLOCALCRCY .
  types:
   TT_CNSLDTNUNITLATESTLOCALCRCYT type standard table of TS_CNSLDTNUNITLATESTLOCALCRCYT .
  types:
   TS_CONSOLIDATIONUNITTEXTTYPE type A_CNSLDTNUNITT .
  types:
   TT_CONSOLIDATIONUNITTEXTTYPE type standard table of TS_CONSOLIDATIONUNITTEXTTYPE .
  types:
   TS_C_CNSLDTNUNITVALUEHELPTYPE type C_CNSLDTNUNITVALUEHELP .
  types:
   TT_C_CNSLDTNUNITVALUEHELPTYPE type standard table of TS_C_CNSLDTNUNITVALUEHELPTYPE .
  types:
   TS_I_DRAFTADMINISTRATIVEDATATY type I_DRAFTADMINISTRATIVEDATA .
  types:
   TT_I_DRAFTADMINISTRATIVEDATATY type standard table of TS_I_DRAFTADMINISTRATIVEDATATY .

  constants GC_AUTH type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'AUTH' ##NO_TEXT.
  constants GC_BALANCETRANSFERDATAMONITOR type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'BalanceTransferDataMonitor' ##NO_TEXT.
  constants GC_CNSLDTNUNITLATESTLOCALCRCYT type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'CnsldtnUnitLatestLocalCrcyType' ##NO_TEXT.
  constants GC_CONSOLIDATIONDIMENSIONTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationDimensionType' ##NO_TEXT.
  constants GC_CONSOLIDATIONUNITHIERTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationUnitHierType' ##NO_TEXT.
  constants GC_CONSOLIDATIONUNITTEXTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationUnitTextType' ##NO_TEXT.
  constants GC_CONSOLIDATIONUNITTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'ConsolidationUnitType' ##NO_TEXT.
  constants GC_C_CNSLDTNUNITVALUEHELPTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'C_CnsldtnUnitValueHelpType' ##NO_TEXT.
  constants GC_INTENTIONS type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Intentions' ##NO_TEXT.
  constants GC_INTENTIONSMAPPING type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'IntentionsMapping' ##NO_TEXT.
  constants GC_INTENTIONVALUES type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'IntentionValues' ##NO_TEXT.
  constants GC_I_DRAFTADMINISTRATIVEDATATY type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'I_DraftAdministrativeDataType' ##NO_TEXT.
  constants GC_LEDGER type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'Ledger' ##NO_TEXT.
  constants GC_TRANSACTIONCURRENCYTEXTTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'TransactionCurrencyTextType' ##NO_TEXT.
  constants GC_XEY1XC_INTENTIONS_VHPARAMET type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xC_INTENTIONS_VHParameters' ##NO_TEXT.
  constants GC_XEY1XC_INTENTIONS_VHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xC_INTENTIONS_VHType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_INTENTIONSTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_IntentionsType' ##NO_TEXT.
  constants GC_XEY1XSAV_C_READINTENTVHTYPE type /IWBEP/IF_MGW_MED_ODATA_TYPES=>TY_E_MED_ENTITY_NAME value 'xEY1xSAV_C_ReadIntentVHType' ##NO_TEXT.

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

  constants GC_INCL_NAME type STRING value '/EY1/CL_SAV_MANAGE_INT_MPC====CP' ##NO_TEXT.

  methods DEFINE_INTENTIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_INTENTIONVALUES
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_AUTH
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_BALANCETRANSFERDATAMONI
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_LEDGER
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_INTENTIONSMAPPING
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_ACTIONS
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods DEFINE_RDS_4
    raising
      /IWBEP/CX_MGW_MED_EXCEPTION .
  methods GET_LAST_MODIFIED_RDS_4
    returning
      value(RV_LAST_MODIFIED_RDS) type TIMESTAMP .
ENDCLASS.



CLASS /EY1/CL_SAV_MANAGE_INT_MPC IMPLEMENTATION.


  method DEFINE.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*

model->set_schema_namespace( 'EY1.SAV_MANAGE_INTENTIONS_SRV' ).

define_intentions( ).
define_intentionvalues( ).
define_auth( ).
define_balancetransferdatamoni( ).
define_ledger( ).
define_intentionsmapping( ).
define_actions( ).
define_rds_4( ).
get_last_modified_rds_4( ).
  endmethod.


  method DEFINE_ACTIONS.
*&---------------------------------------------------------------------*
*&           Generated code for the MODEL PROVIDER BASE CLASS         &*
*&                                                                     &*
*&  !!!NEVER MODIFY THIS CLASS. IN CASE YOU WANT TO CHANGE THE MODEL  &*
*&        DO THIS IN THE MODEL PROVIDER SUBCLASS!!!                   &*
*&                                                                     &*
*&---------------------------------------------------------------------*


data:
lo_action         type ref to /iwbep/if_mgw_odata_action,                 "#EC NEEDED
lo_parameter      type ref to /iwbep/if_mgw_odata_parameter.              "#EC NEEDED

***********************************************************************************************************************************
*   ACTION - BalanceTrasnferDataMonitor
***********************************************************************************************************************************

lo_action = model->create_action( 'BalanceTrasnferDataMonitor' ).  "#EC NOTEXT
*Set return entity type
lo_action->set_return_entity_type( 'BalanceTransferDataMonitor' ). "#EC NOTEXT
*Set HTTP method GET or POST
lo_action->set_http_method( 'GET' ). "#EC NOTEXT
* Set return type multiplicity
lo_action->set_return_multiplicity( 'N' ). "#EC NOTEXT
***********************************************************************************************************************************
* Parameters
***********************************************************************************************************************************

lo_parameter = lo_action->create_input_parameter( iv_parameter_name = 'PeriodTo'    iv_abap_fieldname = 'PERIODTO' ). "#EC NOTEXT
lo_parameter->/iwbep/if_mgw_odata_property~set_type_edm_string( ).
lo_parameter = lo_action->create_input_parameter( iv_parameter_name = 'Ledger'    iv_abap_fieldname = 'LEDGER' ). "#EC NOTEXT
lo_parameter->/iwbep/if_mgw_odata_property~set_type_edm_string( ).
lo_parameter = lo_action->create_input_parameter( iv_parameter_name = 'FiscalYear'    iv_abap_fieldname = 'FISCALYEAR' ). "#EC NOTEXT
lo_parameter->/iwbep/if_mgw_odata_property~set_type_edm_string( ).
lo_parameter = lo_action->create_input_parameter( iv_parameter_name = 'ConsolidationUnit'    iv_abap_fieldname = 'CONSOLIDATIONUNIT' ). "#EC NOTEXT
lo_parameter->/iwbep/if_mgw_odata_property~set_type_edm_string( ).
lo_parameter = lo_action->create_input_parameter( iv_parameter_name = 'Intention'    iv_abap_fieldname = 'INTENTION' ). "#EC NOTEXT
lo_parameter->/iwbep/if_mgw_odata_property~set_type_edm_string( ).
lo_action->bind_input_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE_INT_MPC=>TS_BALANCETRASNFERDATAMONITOR' ). "#EC NOTEXT
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

lo_property = lo_entity_type->create_property( iv_property_name = 'CreateAllowed' iv_abap_fieldname = 'CREATEALLOWED' ). "#EC NOTEXT
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
lo_property = lo_entity_type->create_property( iv_property_name = 'ChangeAllowed' iv_abap_fieldname = 'CHANGEALLOWED' ). "#EC NOTEXT
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

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE_INT_MPC=>TS_AUTH' ). "#EC NOTEXT


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


  method DEFINE_BALANCETRANSFERDATAMONI.
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
*   ENTITY - BalanceTransferDataMonitor
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'BalanceTransferDataMonitor' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Type' iv_abap_fieldname = 'TYPE' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 1 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Id' iv_abap_fieldname = 'ID' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Number' iv_abap_fieldname = 'NUMBER' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 3 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MessageText' iv_abap_fieldname = 'MESSAGETEXT' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 220 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LogNo' iv_abap_fieldname = 'LOGNO' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 20 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LogMsgNo' iv_abap_fieldname = 'LOGMSGNO' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 6 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MessageV1' iv_abap_fieldname = 'MESSAGEV1' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 50 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MessageV2' iv_abap_fieldname = 'MESSAGEV2' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 50 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MessageV3' iv_abap_fieldname = 'MESSAGEV3' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 50 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'MessageV4' iv_abap_fieldname = 'MESSAGEV4' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 50 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Parameter' iv_abap_fieldname = 'PARAMETER' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 32 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Row' iv_abap_fieldname = 'ROW' ). "#EC NOTEXT
lo_property->set_type_edm_int32( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Field' iv_abap_fieldname = 'FIELD' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 30 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'System' iv_abap_fieldname = 'SYSTEM' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 10 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'GUID' iv_abap_fieldname = 'GUID' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_guid( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'LogNumber' iv_abap_fieldname = 'LOGNUMBER' ). "#EC NOTEXT
lo_property->set_type_edm_guid( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'URL' iv_abap_fieldname = 'URL' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE_INT_MPC=>TS_BALANCETRANSFERDATAMONITOR' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'BalanceTransferDataMonitorSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_false ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_INTENTIONS.
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
*   ENTITY - Intentions
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'Intentions' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Intstatus' iv_abap_fieldname = 'INTSTATUS' ). "#EC NOTEXT
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
lo_property = lo_entity_type->create_property( iv_property_name = 'Intdesc' iv_abap_fieldname = 'INTDESC' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 30 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Bunit' iv_abap_fieldname = 'BUNIT' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 18 ). "#EC NOTEXT
lo_property->set_conversion_exit( 'AFIMC' ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Closebtnact' iv_abap_fieldname = 'CLOSEBTNACT' ). "#EC NOTEXT
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
lo_property = lo_entity_type->create_property( iv_property_name = 'Gjahr' iv_abap_fieldname = 'GJAHR' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 4 ). "#EC NOTEXT
lo_property->set_conversion_exit( 'GJAHR' ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IsActive' iv_abap_fieldname = 'IS_ACTIVE' ). "#EC NOTEXT
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
lo_property = lo_entity_type->create_property( iv_property_name = 'Intention' iv_abap_fieldname = 'INTENTION' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 30 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SeqnrFlb' iv_abap_fieldname = 'SEQNR_FLB' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '001' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 2 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PeriodTo' iv_abap_fieldname = 'PERIOD_TO' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 3 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IntnsnActFlg' iv_abap_fieldname = 'INTNSN_ACT_FLG' ). "#EC NOTEXT
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
lo_property = lo_entity_type->create_property( iv_property_name = 'CreatedBy' iv_abap_fieldname = 'CREATED_BY' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 12 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'CreatedOn' iv_abap_fieldname = 'CREATED_ON' ). "#EC NOTEXT
lo_property->set_type_edm_datetime( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ChangedBy' iv_abap_fieldname = 'CHANGED_BY' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_maxlength( iv_max_length = 12 ). "#EC NOTEXT
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'ChangedOn' iv_abap_fieldname = 'CHANGED_ON' ). "#EC NOTEXT
lo_property->set_type_edm_datetime( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_true ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name   = '/EY1/TS_FISCL_INTNT'
                                iv_bind_conversions = 'X' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'IntentionsSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_true ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_INTENTIONSMAPPING.
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
*   ENTITY - IntentionsMapping
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'IntentionsMapping' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Intention' iv_abap_fieldname = 'INTENTION' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'IntentionDescription' iv_abap_fieldname = 'INTENTIONDESCRIPTION' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PeriodTo' iv_abap_fieldname = 'PERIODTO' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE_INT_MPC=>TS_INTENTIONSMAPPING' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'IntentionsMappingSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_false ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_INTENTIONVALUES.
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
*   ENTITY - IntentionValues
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'IntentionValues' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'Gjahr' iv_abap_fieldname = 'GJAHR' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '002' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'SerialNumber' iv_abap_fieldname = 'SERIALNUMBER' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '005' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Intention' iv_abap_fieldname = 'INTENTION' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '003' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'Description' iv_abap_fieldname = 'DESCRIPTION' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '004' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'PeriodTo' iv_abap_fieldname = 'PERIODTO' ). "#EC NOTEXT
lo_property->set_label_from_text_element( iv_text_element_symbol = '006' iv_text_element_container = gc_incl_name ).  "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_true ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE_INT_MPC=>TS_INTENTIONVALUES' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'IntentionValuesSet' ). "#EC NOTEXT

lo_entity_set->set_creatable( abap_false ).
lo_entity_set->set_updatable( abap_false ).
lo_entity_set->set_deletable( abap_false ).

lo_entity_set->set_pageable( abap_false ).
lo_entity_set->set_addressable( abap_false ).
lo_entity_set->set_has_ftxt_search( abap_false ).
lo_entity_set->set_subscribable( abap_false ).
lo_entity_set->set_filter_required( abap_false ).
  endmethod.


  method DEFINE_LEDGER.
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
*   ENTITY - Ledger
***********************************************************************************************************************************

lo_entity_type = model->create_entity_type( iv_entity_type_name = 'Ledger' iv_def_entity_set = abap_false ). "#EC NOTEXT

***********************************************************************************************************************************
*Properties
***********************************************************************************************************************************

lo_property = lo_entity_type->create_property( iv_property_name = 'BUnit' iv_abap_fieldname = 'BUNIT' ). "#EC NOTEXT
lo_property->set_is_key( ).
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).
lo_property = lo_entity_type->create_property( iv_property_name = 'RLDNR' iv_abap_fieldname = 'RLDNR' ). "#EC NOTEXT
lo_property->set_type_edm_string( ).
lo_property->set_creatable( abap_false ).
lo_property->set_updatable( abap_false ).
lo_property->set_sortable( abap_false ).
lo_property->set_nullable( abap_false ).
lo_property->set_filterable( abap_false ).
lo_property->/iwbep/if_mgw_odata_annotatabl~create_annotation( 'sap' )->add(
      EXPORTING
        iv_key      = 'unicode'
        iv_value    = 'false' ).

lo_entity_type->bind_structure( iv_structure_name  = '/EY1/CL_SAV_MANAGE_INT_MPC=>TS_LEDGER' ). "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
lo_entity_set = lo_entity_type->create_entity_set( 'LedgerSet' ). "#EC NOTEXT

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


  CONSTANTS: lc_gen_date_time TYPE timestamp VALUE '20211109022729'.                  "#EC NOTEXT
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
    CONSTANTS: co_gen_date_time TYPE timestamp VALUE '20211109032729'.
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
    CONSTANTS: co_gen_timestamp TYPE timestamp VALUE '20211109032729'.
    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>|  &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="V2" >|  &
               | <sadl:dataSource type="CDS" name="/EY1/C_INTENTIONS_VH" binding="/EY1/C_INTENTIONS_VH" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNITHIER" binding="A_CNSLDTNUNITHIER" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNITLATESTLOCALCRCY" binding="A_CNSLDTNUNITLATESTLOCALCRCY" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNITT" binding="A_CNSLDTNUNITT" />|  &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNUNITVALUEHELP" binding="C_CNSLDTNUNITVALUEHELP" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_INTENTIONS" binding="/EY1/SAV_C_INTENTIONS" />|  &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_READINTENTVH" binding="/EY1/SAV_C_READINTENTVH" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNDIMENSION" binding="A_CNSLDTNDIMENSION" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNTRANSCURRENCYT" binding="A_CNSLDTNTRANSCURRENCYT" />|  &
               | <sadl:dataSource type="CDS" name="A_CNSLDTNUNIT" binding="A_CNSLDTNUNIT" />|  &
               |<sadl:resultSet>|  &
               |<sadl:structure name="xEY1xC_INTENTIONS_VHSet" dataSource="/EY1/C_INTENTIONS_VH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationUnitHier" dataSource="A_CNSLDTNUNITHIER" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="CnsldtnUnitLatestLocalCrcy" dataSource="A_CNSLDTNUNITLATESTLOCALCRCY" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationUnitText" dataSource="A_CNSLDTNUNITT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="C_CnsldtnUnitValueHelp" dataSource="C_CNSLDTNUNITVALUEHELP" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_Intentions" dataSource="/EY1/SAV_C_INTENTIONS" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="xEY1xSAV_C_ReadIntentVH" dataSource="/EY1/SAV_C_READINTENTVH" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationDimension" dataSource="A_CNSLDTNDIMENSION" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="TransactionCurrencyText" dataSource="A_CNSLDTNTRANSCURRENCYT" maxEditMode="RO" exposure="TRUE" >|  &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               |</sadl:structure>|  &
               |<sadl:structure name="ConsolidationUnit" dataSource="A_CNSLDTNUNIT" maxEditMode="RO" exposure="TRUE" >| .
      lv_sadl_xml = |{ lv_sadl_xml }| &
               | <sadl:query name="SADL_QUERY">|  &
               | </sadl:query>|  &
               | <sadl:association name="TO_CNSLDTNDIMENSION" binding="_CNSLDTNDIMENSION" target="ConsolidationDimension" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_CNSLDTNTRANSCURRENCYT" binding="_CNSLDTNTRANSCURRENCYT" target="TransactionCurrencyText" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CNSLDTNUNITHIER" binding="_CNSLDTNUNITHIER" target="ConsolidationUnitHier" cardinality="zeroToMany" />|  &
               | <sadl:association name="TO_CNSLDTNUNITLATESTLOCALCRCY" binding="_CNSLDTNUNITLATESTLOCALCRCY" target="CnsldtnUnitLatestLocalCrcy" cardinality="zeroToOne" />|  &
               | <sadl:association name="TO_CNSLDTNUNITT" binding="_CNSLDTNUNITT" target="ConsolidationUnitText" cardinality="zeroToMany" />|  &
               |</sadl:structure>|  &
               |</sadl:resultSet>|  &
               |</sadl:definition>| .

   ro_model_exposure = cl_sadl_gw_model_exposure=>get_exposure_xml( iv_uuid      = CONV #( '/EY1/SAV_MANAGE_INTENTIONS' )
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


clear ls_text_element.
ls_text_element-artifact_name          = 'SeqnrFlb'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'Intentions'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '001'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.


clear ls_text_element.
ls_text_element-artifact_name          = 'Gjahr'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'IntentionValues'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '002'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'SerialNumber'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'IntentionValues'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '005'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'Intention'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'IntentionValues'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '003'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'Description'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'IntentionValues'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '004'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
clear ls_text_element.
ls_text_element-artifact_name          = 'PeriodTo'.                 "#EC NOTEXT
ls_text_element-artifact_type          = 'PROP'.                                       "#EC NOTEXT
ls_text_element-parent_artifact_name   = 'IntentionValues'.                            "#EC NOTEXT
ls_text_element-parent_artifact_type   = 'ETYP'.                                       "#EC NOTEXT
ls_text_element-text_symbol            = '006'.              "#EC NOTEXT
APPEND ls_text_element TO rt_text_elements.
  endmethod.
ENDCLASS.

class /EY1/CL_SAV_TAX_RATES_DPC definition
  public
  inheriting from /IWBEP/CL_MGW_PUSH_ABS_DATA
  abstract
  create public .

public section.

  interfaces /IWBEP/IF_SB_DPC_COMM_SERVICES .
  interfaces /IWBEP/IF_SB_GEN_DPC_INJECTION .
  interfaces IF_SADL_GW_DPC_UTIL .

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~DELETE_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITY
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITYSET
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_IS_CONDITIONAL_IMPLEMENTED
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_IS_CONDI_IMPLE_FOR_ACTION
    redefinition .
  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~PATCH_ENTITY
    redefinition .
protected section.

  data mo_injection type ref to /IWBEP/IF_SB_GEN_DPC_INJECTION .

  methods Z_I_READINTENTVH_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_Z_I_READINTENTVHTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods Z_I_READINTENTVH_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_Z_I_READINTENTVHTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods Z_I_READINTENTVH_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_Z_I_READINTENTVHTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods Z_I_READINTENTVH_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods Z_I_READINTENTVH_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_Z_I_READINTENTVHTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XSAV_C_CTR_T_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_XEY1XSAV_C_CTR_TAX_RATESTYP
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XSAV_C_CTR_T_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_XEY1XSAV_C_CTR_TAX_RATESTYP
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XSAV_C_CTR_T_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_XEY1XSAV_C_CTR_TAX_RATESTYP
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XSAV_C_CTR_T_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XSAV_C_CTR_T_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_XEY1XSAV_C_CTR_TAX_RATESTYP
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XI_READINTEN_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_XEY1XI_READINTENTVHTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XI_READINTEN_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_XEY1XI_READINTENTVHTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XI_READINTEN_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_XEY1XI_READINTENTVHTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XI_READINTEN_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods XEY1XI_READINTEN_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_XEY1XI_READINTENTVHTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_LANGUAGE_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_LANGUAGETYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_LANGUAGE_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_I_LANGUAGETYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_LANGUAGE_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_LANGUAGETYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_LANGUAGE_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_LANGUAGE_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_LANGUAGETYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_DRAFTADMINISTR_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_DRAFTADMINISTRATIVEDATATY
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_DRAFTADMINISTR_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_I_DRAFTADMINISTRATIVEDATATY
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_DRAFTADMINISTR_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_DRAFTADMINISTRATIVEDATATY
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_DRAFTADMINISTR_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_DRAFTADMINISTR_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_DRAFTADMINISTRATIVEDATATY
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNUNITT_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_CNSLDTNUNITTTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNUNITT_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_I_CNSLDTNUNITTTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNUNITT_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_CNSLDTNUNITTTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNUNITT_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNUNITT_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_CNSLDTNUNITTTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNDIMENSI_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_CNSLDTNDIMENSIONTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNDIMENSI_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_I_CNSLDTNDIMENSIONTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNDIMENSI_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_CNSLDTNDIMENSIONTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNDIMENSI_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods I_CNSLDTNDIMENSI_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_I_CNSLDTNDIMENSIONTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods C_CNSLDTNUNITVAL_UPDATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_U optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_C_CNSLDTNUNITVALUEHELPTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods C_CNSLDTNUNITVAL_GET_ENTITYSET
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_FILTER_SELECT_OPTIONS type /IWBEP/T_MGW_SELECT_OPTION
      !IS_PAGING type /IWBEP/S_MGW_PAGING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IT_ORDER type /IWBEP/T_MGW_SORTING_ORDER
      !IV_FILTER_STRING type STRING
      !IV_SEARCH_STRING type STRING
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITYSET optional
    exporting
      !ET_ENTITYSET type /EY1/CL_SAV_TAX_RATES_MPC=>TT_C_CNSLDTNUNITVALUEHELPTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods C_CNSLDTNUNITVAL_GET_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_REQUEST_OBJECT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_C_CNSLDTNUNITVALUEHELPTYPE
      !ES_RESPONSE_CONTEXT type /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_ENTITY_CNTXT
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods C_CNSLDTNUNITVAL_DELETE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_D optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .
  methods C_CNSLDTNUNITVAL_CREATE_ENTITY
    importing
      !IV_ENTITY_NAME type STRING
      !IV_ENTITY_SET_NAME type STRING
      !IV_SOURCE_NAME type STRING
      !IT_KEY_TAB type /IWBEP/T_MGW_NAME_VALUE_PAIR
      !IO_TECH_REQUEST_CONTEXT type ref to /IWBEP/IF_MGW_REQ_ENTITY_C optional
      !IT_NAVIGATION_PATH type /IWBEP/T_MGW_NAVIGATION_PATH
      !IO_DATA_PROVIDER type ref to /IWBEP/IF_MGW_ENTRY_PROVIDER optional
    exporting
      !ER_ENTITY type /EY1/CL_SAV_TAX_RATES_MPC=>TS_C_CNSLDTNUNITVALUEHELPTYPE
    raising
      /IWBEP/CX_MGW_BUSI_EXCEPTION
      /IWBEP/CX_MGW_TECH_EXCEPTION .

  methods CHECK_SUBSCRIPTION_AUTHORITY
    redefinition .
private section.
ENDCLASS.



CLASS /EY1/CL_SAV_TAX_RATES_DPC IMPLEMENTATION.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_BEGIN.
    if_sadl_gw_dpc_util~get_dpc( )->begin_changeset( EXPORTING it_operation_info = it_operation_info
                                                     CHANGING cv_defer_mode      = cv_defer_mode ).
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CHANGESET_PROCESS.
    if_sadl_gw_dpc_util~get_dpc( )->process_changeset( EXPORTING it_changeset_request  = it_changeset_request
                                                       CHANGING  ct_changeset_response = ct_changeset_response ).
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_DEEP_ENTITY.
    CAST /iwbep/if_mgw_appl_srv_runtime( if_sadl_gw_dpc_util~get_dpc( ) )->create_deep_entity(
                   EXPORTING io_tech_request_context = io_tech_request_context
                             io_data_provider        = io_data_provider
                             io_expand               = io_expand
                   IMPORTING er_deep_entity          = er_deep_entity ).
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_CRT_ENTITY_BASE
*&* This class has been generated on 19.01.2021 11:22:29 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /EY1/CL_SAV_TAX_RATES_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA z_i_readintentvh_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_z_i_readintentvhtype.
 DATA xey1xi_readinten_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_xey1xi_readintentvhtype.
 DATA i_language_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_languagetype.
 DATA i_draftadministr_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_draftadministrativedataty.
 DATA xey1xsav_c_ctr_t_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_xey1xsav_c_ctr_tax_ratestyp.
 DATA i_cnsldtnunitt_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_cnsldtnunitttype.
 DATA i_cnsldtndimensi_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_cnsldtndimensiontype.
 DATA c_cnsldtnunitval_create_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_c_cnsldtnunitvaluehelptype.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  Z_I_ReadIntentVH
*-------------------------------------------------------------------------*
     WHEN 'Z_I_ReadIntentVH'.
*     Call the entity set generated method
    z_i_readintentvh_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = z_i_readintentvh_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = z_i_readintentvh_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xI_ReadIntentVH
*-------------------------------------------------------------------------*
     WHEN 'xEY1xI_ReadIntentVH'.
*     Call the entity set generated method
    xey1xi_readinten_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = xey1xi_readinten_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = xey1xi_readinten_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_Language
*-------------------------------------------------------------------------*
     WHEN 'I_Language'.
*     Call the entity set generated method
    i_language_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = i_language_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = i_language_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_DraftAdministrativeData
*-------------------------------------------------------------------------*
     WHEN 'I_DraftAdministrativeData'.
*     Call the entity set generated method
    i_draftadministr_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = i_draftadministr_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = i_draftadministr_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xSAV_C_CTR_Tax_Rates
*-------------------------------------------------------------------------*
     WHEN 'xEY1xSAV_C_CTR_Tax_Rates'.
*     Call the entity set generated method
    xey1xsav_c_ctr_t_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = xey1xsav_c_ctr_t_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = xey1xsav_c_ctr_t_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnUnitT
*-------------------------------------------------------------------------*
     WHEN 'I_CnsldtnUnitT'.
*     Call the entity set generated method
    i_cnsldtnunitt_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = i_cnsldtnunitt_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = i_cnsldtnunitt_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnDimension
*-------------------------------------------------------------------------*
     WHEN 'I_CnsldtnDimension'.
*     Call the entity set generated method
    i_cnsldtndimensi_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = i_cnsldtndimensi_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = i_cnsldtndimensi_create_entity
      CHANGING
        cr_data = er_entity
   ).

*-------------------------------------------------------------------------*
*             EntitySet -  C_CnsldtnUnitValueHelp
*-------------------------------------------------------------------------*
     WHEN 'C_CnsldtnUnitValueHelp'.
*     Call the entity set generated method
    c_cnsldtnunitval_create_entity(
         EXPORTING iv_entity_name     = iv_entity_name
                   iv_entity_set_name = iv_entity_set_name
                   iv_source_name     = iv_source_name
                   io_data_provider   = io_data_provider
                   it_key_tab         = it_key_tab
                   it_navigation_path = it_navigation_path
                   io_tech_request_context = io_tech_request_context
       	 IMPORTING er_entity          = c_cnsldtnunitval_create_entity
    ).
*     Send specific entity data to the caller interfaces
    copy_data_to_ref(
      EXPORTING
        is_data = c_cnsldtnunitval_create_entity
      CHANGING
        cr_data = er_entity
   ).

  when others.
    super->/iwbep/if_mgw_appl_srv_runtime~create_entity(
       EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         io_data_provider   = io_data_provider
         it_key_tab = it_key_tab
         it_navigation_path = it_navigation_path
      IMPORTING
        er_entity = er_entity
  ).
ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~DELETE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_DEL_ENTITY_BASE
*&* This class has been generated on 19.01.2021 11:22:29 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /EY1/CL_SAV_TAX_RATES_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  Z_I_ReadIntentVH
*-------------------------------------------------------------------------*
      when 'Z_I_ReadIntentVH'.
*     Call the entity set generated method
     z_i_readintentvh_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_Language
*-------------------------------------------------------------------------*
      when 'I_Language'.
*     Call the entity set generated method
     i_language_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_DraftAdministrativeData
*-------------------------------------------------------------------------*
      when 'I_DraftAdministrativeData'.
*     Call the entity set generated method
     i_draftadministr_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnUnitT
*-------------------------------------------------------------------------*
      when 'I_CnsldtnUnitT'.
*     Call the entity set generated method
     i_cnsldtnunitt_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnDimension
*-------------------------------------------------------------------------*
      when 'I_CnsldtnDimension'.
*     Call the entity set generated method
     i_cnsldtndimensi_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  C_CnsldtnUnitValueHelp
*-------------------------------------------------------------------------*
      when 'C_CnsldtnUnitValueHelp'.
*     Call the entity set generated method
     c_cnsldtnunitval_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xI_ReadIntentVH
*-------------------------------------------------------------------------*
      when 'xEY1xI_ReadIntentVH'.
*     Call the entity set generated method
     xey1xi_readinten_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xSAV_C_CTR_Tax_Rates
*-------------------------------------------------------------------------*
      when 'xEY1xSAV_C_CTR_Tax_Rates'.
*     Call the entity set generated method
     xey1xsav_c_ctr_t_delete_entity(
          EXPORTING iv_entity_name     = iv_entity_name
                    iv_entity_set_name = iv_entity_set_name
                    iv_source_name     = iv_source_name
                    it_key_tab         = it_key_tab
                    it_navigation_path = it_navigation_path
                    io_tech_request_context = io_tech_request_context
     ).

   when others.
     super->/iwbep/if_mgw_appl_srv_runtime~delete_entity(
        EXPORTING
          iv_entity_name = iv_entity_name
          iv_entity_set_name = iv_entity_set_name
          iv_source_name = iv_source_name
          it_key_tab = it_key_tab
          it_navigation_path = it_navigation_path
 ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~EXECUTE_ACTION.
    if_sadl_gw_dpc_util~get_dpc( )->execute_action( EXPORTING io_tech_request_context = io_tech_request_context
                                                    IMPORTING er_data                 = er_data ).
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_GETENTITY_BASE
*&* This class has been generated  on 19.01.2021 11:22:29 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /EY1/CL_SAV_TAX_RATES_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA xey1xi_readinten_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_xey1xi_readintentvhtype.
 DATA z_i_readintentvh_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_z_i_readintentvhtype.
 DATA i_language_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_languagetype.
 DATA xey1xsav_c_ctr_t_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_xey1xsav_c_ctr_tax_ratestyp.
 DATA i_draftadministr_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_draftadministrativedataty.
 DATA i_cnsldtnunitt_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_cnsldtnunitttype.
 DATA c_cnsldtnunitval_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_c_cnsldtnunitvaluehelptype.
 DATA i_cnsldtndimensi_get_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_cnsldtndimensiontype.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data.       "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xI_ReadIntentVH
*-------------------------------------------------------------------------*
      WHEN 'xEY1xI_ReadIntentVH'.
*     Call the entity set generated method
          xey1xi_readinten_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = xey1xi_readinten_get_entity
                         es_response_context = es_response_context
          ).

        IF xey1xi_readinten_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = xey1xi_readinten_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  Z_I_ReadIntentVH
*-------------------------------------------------------------------------*
      WHEN 'Z_I_ReadIntentVH'.
*     Call the entity set generated method
          z_i_readintentvh_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = z_i_readintentvh_get_entity
                         es_response_context = es_response_context
          ).

        IF z_i_readintentvh_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = z_i_readintentvh_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_Language
*-------------------------------------------------------------------------*
      WHEN 'I_Language'.
*     Call the entity set generated method
          i_language_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_language_get_entity
                         es_response_context = es_response_context
          ).

        IF i_language_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_language_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xSAV_C_CTR_Tax_Rates
*-------------------------------------------------------------------------*
      WHEN 'xEY1xSAV_C_CTR_Tax_Rates'.
*     Call the entity set generated method
          xey1xsav_c_ctr_t_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = xey1xsav_c_ctr_t_get_entity
                         es_response_context = es_response_context
          ).

        IF xey1xsav_c_ctr_t_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = xey1xsav_c_ctr_t_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_DraftAdministrativeData
*-------------------------------------------------------------------------*
      WHEN 'I_DraftAdministrativeData'.
*     Call the entity set generated method
          i_draftadministr_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_draftadministr_get_entity
                         es_response_context = es_response_context
          ).

        IF i_draftadministr_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_draftadministr_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnUnitT
*-------------------------------------------------------------------------*
      WHEN 'I_CnsldtnUnitT'.
*     Call the entity set generated method
          i_cnsldtnunitt_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_cnsldtnunitt_get_entity
                         es_response_context = es_response_context
          ).

        IF i_cnsldtnunitt_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_cnsldtnunitt_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  C_CnsldtnUnitValueHelp
*-------------------------------------------------------------------------*
      WHEN 'C_CnsldtnUnitValueHelp'.
*     Call the entity set generated method
          c_cnsldtnunitval_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = c_cnsldtnunitval_get_entity
                         es_response_context = es_response_context
          ).

        IF c_cnsldtnunitval_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = c_cnsldtnunitval_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnDimension
*-------------------------------------------------------------------------*
      WHEN 'I_CnsldtnDimension'.
*     Call the entity set generated method
          i_cnsldtndimensi_get_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_cnsldtndimensi_get_entity
                         es_response_context = es_response_context
          ).

        IF i_cnsldtndimensi_get_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_cnsldtndimensi_get_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.

      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~get_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_ENTITYSET.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TMP_ENTITYSET_BASE
*&* This class has been generated on 19.01.2021 11:22:29 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /EY1/CL_SAV_TAX_RATES_DPC_EXT
*&-----------------------------------------------------------------------------------------------*
 DATA xey1xi_readinten_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_xey1xi_readintentvhtype.
 DATA i_cnsldtndimensi_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_i_cnsldtndimensiontype.
 DATA z_i_readintentvh_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_z_i_readintentvhtype.
 DATA c_cnsldtnunitval_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_c_cnsldtnunitvaluehelptype.
 DATA i_cnsldtnunitt_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_i_cnsldtnunitttype.
 DATA i_language_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_i_languagetype.
 DATA i_draftadministr_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_i_draftadministrativedataty.
 DATA xey1xsav_c_ctr_t_get_entityset TYPE /ey1/cl_sav_tax_rates_mpc=>tt_xey1xsav_c_ctr_tax_ratestyp.
 DATA lv_entityset_name TYPE string.

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xI_ReadIntentVH
*-------------------------------------------------------------------------*
   WHEN 'xEY1xI_ReadIntentVH'.
*     Call the entity set generated method
      xey1xi_readinten_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = xey1xi_readinten_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = xey1xi_readinten_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnDimension
*-------------------------------------------------------------------------*
   WHEN 'I_CnsldtnDimension'.
*     Call the entity set generated method
      i_cnsldtndimensi_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = i_cnsldtndimensi_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = i_cnsldtndimensi_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  Z_I_ReadIntentVH
*-------------------------------------------------------------------------*
   WHEN 'Z_I_ReadIntentVH'.
*     Call the entity set generated method
      z_i_readintentvh_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = z_i_readintentvh_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = z_i_readintentvh_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  C_CnsldtnUnitValueHelp
*-------------------------------------------------------------------------*
   WHEN 'C_CnsldtnUnitValueHelp'.
*     Call the entity set generated method
      c_cnsldtnunitval_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = c_cnsldtnunitval_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = c_cnsldtnunitval_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnUnitT
*-------------------------------------------------------------------------*
   WHEN 'I_CnsldtnUnitT'.
*     Call the entity set generated method
      i_cnsldtnunitt_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = i_cnsldtnunitt_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = i_cnsldtnunitt_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_Language
*-------------------------------------------------------------------------*
   WHEN 'I_Language'.
*     Call the entity set generated method
      i_language_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = i_language_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = i_language_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  I_DraftAdministrativeData
*-------------------------------------------------------------------------*
   WHEN 'I_DraftAdministrativeData'.
*     Call the entity set generated method
      i_draftadministr_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = i_draftadministr_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = i_draftadministr_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xSAV_C_CTR_Tax_Rates
*-------------------------------------------------------------------------*
   WHEN 'xEY1xSAV_C_CTR_Tax_Rates'.
*     Call the entity set generated method
      xey1xsav_c_ctr_t_get_entityset(
        EXPORTING
         iv_entity_name = iv_entity_name
         iv_entity_set_name = iv_entity_set_name
         iv_source_name = iv_source_name
         it_filter_select_options = it_filter_select_options
         it_order = it_order
         is_paging = is_paging
         it_navigation_path = it_navigation_path
         it_key_tab = it_key_tab
         iv_filter_string = iv_filter_string
         iv_search_string = iv_search_string
         io_tech_request_context = io_tech_request_context
       IMPORTING
         et_entityset = xey1xsav_c_ctr_t_get_entityset
         es_response_context = es_response_context
       ).
*     Send specific entity data to the caller interface
      copy_data_to_ref(
        EXPORTING
          is_data = xey1xsav_c_ctr_t_get_entityset
        CHANGING
          cr_data = er_entityset
      ).

    WHEN OTHERS.
      super->/iwbep/if_mgw_appl_srv_runtime~get_entityset(
        EXPORTING
          iv_entity_name = iv_entity_name
          iv_entity_set_name = iv_entity_set_name
          iv_source_name = iv_source_name
          it_filter_select_options = it_filter_select_options
          it_order = it_order
          is_paging = is_paging
          it_navigation_path = it_navigation_path
          it_key_tab = it_key_tab
          iv_filter_string = iv_filter_string
          iv_search_string = iv_search_string
          io_tech_request_context = io_tech_request_context
       IMPORTING
         er_entityset = er_entityset ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITY.
   if_sadl_gw_dpc_util~get_dpc( )->get_expanded_entity( EXPORTING io_expand_node               = io_expand
                                                                  io_tech_request_context      = io_tech_request_context
                                                        IMPORTING er_entity                    = er_entity
                                                                  et_expanded_tech_clauses     = et_expanded_tech_clauses
                                                                  es_response_context          = es_response_context ).
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_EXPANDED_ENTITYSET.
   if_sadl_gw_dpc_util~get_dpc( )->get_expanded_entityset( EXPORTING io_expand_node               = io_expand
                                                                     io_tech_request_context      = io_tech_request_context
                                                           IMPORTING er_entityset                 = er_entityset
                                                                     et_expanded_tech_clauses     = et_expanded_tech_clauses
                                                                     es_response_context          = es_response_context ).
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_IS_CONDITIONAL_IMPLEMENTED.
    TRY.
        rv_conditional_active = if_sadl_gw_dpc_util~get_dpc( )->get_is_conditional_implemented(
                                               iv_operation_type  = iv_operation_type
                                               iv_entity_set_name = iv_entity_set_name ).
      CATCH /iwbep/cx_mgw_tech_exception /iwbep/cx_mgw_busi_exception.
             rv_conditional_active = super->/iwbep/if_mgw_appl_srv_runtime~get_is_conditional_implemented(
                                            iv_operation_type     = iv_operation_type
                                            iv_entity_set_name    = iv_entity_set_name ).
    ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~GET_IS_CONDI_IMPLE_FOR_ACTION.
    TRY.
       rv_conditional_active = if_sadl_gw_dpc_util~get_dpc( )->get_is_condi_imple_for_action( iv_action_name ).
      CATCH /iwbep/cx_mgw_tech_exception /iwbep/cx_mgw_busi_exception.
        rv_conditional_active = super->/iwbep/if_mgw_appl_srv_runtime~get_is_condi_imple_for_action( iv_action_name ).
    ENDTRY.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~PATCH_ENTITY.
    CASE io_tech_request_context->get_entity_set_name( ).
      WHEN 'xEY1xSAV_C_CTR_Tax_Rates'
      .
        CAST /iwbep/if_mgw_appl_srv_runtime( if_sadl_gw_dpc_util~get_dpc( ) )->patch_entity(
                       EXPORTING io_tech_request_context = io_tech_request_context
                                 io_data_provider        = io_data_provider
                       IMPORTING er_entity               = er_entity  ).
      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~patch_entity(
                       EXPORTING io_tech_request_context = io_tech_request_context
                                 io_data_provider        = io_data_provider
                                 iv_entity_name          = iv_entity_name
                                 iv_entity_set_name      = iv_entity_set_name
                                 iv_source_name          = iv_source_name
                                 it_key_tab              = it_key_tab
                                 it_navigation_path      = it_navigation_path
                       IMPORTING er_entity               = er_entity  ).
    ENDCASE.
  endmethod.


  method /IWBEP/IF_MGW_APPL_SRV_RUNTIME~UPDATE_ENTITY.
*&----------------------------------------------------------------------------------------------*
*&  Include           /IWBEP/DPC_TEMP_UPD_ENTITY_BASE
*&* This class has been generated on 19.01.2021 11:22:29 in client 100
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC provider subclass - /EY1/CL_SAV_TAX_RATES_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA i_draftadministr_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_draftadministrativedataty.
 DATA xey1xsav_c_ctr_t_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_xey1xsav_c_ctr_tax_ratestyp.
 DATA i_cnsldtnunitt_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_cnsldtnunitttype.
 DATA i_language_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_languagetype.
 DATA xey1xi_readinten_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_xey1xi_readintentvhtype.
 DATA i_cnsldtndimensi_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_i_cnsldtndimensiontype.
 DATA z_i_readintentvh_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_z_i_readintentvhtype.
 DATA c_cnsldtnunitval_update_entity TYPE /ey1/cl_sav_tax_rates_mpc=>ts_c_cnsldtnunitvaluehelptype.
 DATA lv_entityset_name TYPE string.
 DATA lr_entity TYPE REF TO data. "#EC NEEDED

lv_entityset_name = io_tech_request_context->get_entity_set_name( ).

CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  I_DraftAdministrativeData
*-------------------------------------------------------------------------*
      WHEN 'I_DraftAdministrativeData'.
*     Call the entity set generated method
          i_draftadministr_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_draftadministr_update_entity
          ).
       IF i_draftadministr_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_draftadministr_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xSAV_C_CTR_Tax_Rates
*-------------------------------------------------------------------------*
      WHEN 'xEY1xSAV_C_CTR_Tax_Rates'.
*     Call the entity set generated method
          xey1xsav_c_ctr_t_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = xey1xsav_c_ctr_t_update_entity
          ).
       IF xey1xsav_c_ctr_t_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = xey1xsav_c_ctr_t_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnUnitT
*-------------------------------------------------------------------------*
      WHEN 'I_CnsldtnUnitT'.
*     Call the entity set generated method
          i_cnsldtnunitt_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_cnsldtnunitt_update_entity
          ).
       IF i_cnsldtnunitt_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_cnsldtnunitt_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_Language
*-------------------------------------------------------------------------*
      WHEN 'I_Language'.
*     Call the entity set generated method
          i_language_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_language_update_entity
          ).
       IF i_language_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_language_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  xEY1xI_ReadIntentVH
*-------------------------------------------------------------------------*
      WHEN 'xEY1xI_ReadIntentVH'.
*     Call the entity set generated method
          xey1xi_readinten_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = xey1xi_readinten_update_entity
          ).
       IF xey1xi_readinten_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = xey1xi_readinten_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  I_CnsldtnDimension
*-------------------------------------------------------------------------*
      WHEN 'I_CnsldtnDimension'.
*     Call the entity set generated method
          i_cnsldtndimensi_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = i_cnsldtndimensi_update_entity
          ).
       IF i_cnsldtndimensi_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = i_cnsldtndimensi_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  Z_I_ReadIntentVH
*-------------------------------------------------------------------------*
      WHEN 'Z_I_ReadIntentVH'.
*     Call the entity set generated method
          z_i_readintentvh_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = z_i_readintentvh_update_entity
          ).
       IF z_i_readintentvh_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = z_i_readintentvh_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
*-------------------------------------------------------------------------*
*             EntitySet -  C_CnsldtnUnitValueHelp
*-------------------------------------------------------------------------*
      WHEN 'C_CnsldtnUnitValueHelp'.
*     Call the entity set generated method
          c_cnsldtnunitval_update_entity(
               EXPORTING iv_entity_name     = iv_entity_name
                         iv_entity_set_name = iv_entity_set_name
                         iv_source_name     = iv_source_name
                         io_data_provider   = io_data_provider
                         it_key_tab         = it_key_tab
                         it_navigation_path = it_navigation_path
                         io_tech_request_context = io_tech_request_context
             	 IMPORTING er_entity          = c_cnsldtnunitval_update_entity
          ).
       IF c_cnsldtnunitval_update_entity IS NOT INITIAL.
*     Send specific entity data to the caller interface
          copy_data_to_ref(
            EXPORTING
              is_data = c_cnsldtnunitval_update_entity
            CHANGING
              cr_data = er_entity
          ).
        ELSE.
*         In case of initial values - unbind the entity reference
          er_entity = lr_entity.
        ENDIF.
      WHEN OTHERS.
        super->/iwbep/if_mgw_appl_srv_runtime~update_entity(
           EXPORTING
             iv_entity_name = iv_entity_name
             iv_entity_set_name = iv_entity_set_name
             iv_source_name = iv_source_name
             io_data_provider   = io_data_provider
             it_key_tab = it_key_tab
             it_navigation_path = it_navigation_path
          IMPORTING
            er_entity = er_entity
    ).
 ENDCASE.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~COMMIT_WORK.
* Call RFC commit work functionality
DATA lt_message      TYPE bapiret2. "#EC NEEDED
DATA lv_message_text TYPE BAPI_MSG.
DATA lo_logger       TYPE REF TO /iwbep/cl_cos_logger.
DATA lv_subrc        TYPE syst-subrc.

lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

  IF iv_rfc_dest IS INITIAL OR iv_rfc_dest EQ 'NONE'.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
      wait   = abap_true
    IMPORTING
      return = lt_message.
  ELSE.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      DESTINATION iv_rfc_dest
    EXPORTING
      wait                  = abap_true
    IMPORTING
      return                = lt_message
    EXCEPTIONS
      communication_failure = 1000 MESSAGE lv_message_text
      system_failure        = 1001 MESSAGE lv_message_text
      OTHERS                = 1002.

  IF sy-subrc <> 0.
    lv_subrc = sy-subrc.
    /iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
        EXPORTING
          iv_subrc            = lv_subrc
          iv_exp_message_text = lv_message_text
          io_logger           = lo_logger ).
  ENDIF.
  ENDIF.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~GET_GENERATION_STRATEGY.
* Get generation strategy
  rv_generation_strategy = '1'.
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~LOG_MESSAGE.
* Log message in the application log
DATA lo_logger TYPE REF TO /iwbep/cl_cos_logger.
DATA lv_text TYPE /iwbep/sup_msg_longtext.

  MESSAGE ID iv_msg_id TYPE iv_msg_type NUMBER iv_msg_number
    WITH iv_msg_v1 iv_msg_v2 iv_msg_v3 iv_msg_v4 INTO lv_text.

  lo_logger = mo_context->get_logger( ).
  lo_logger->log_message(
    EXPORTING
     iv_msg_type   = iv_msg_type
     iv_msg_id     = iv_msg_id
     iv_msg_number = iv_msg_number
     iv_msg_text   = lv_text
     iv_msg_v1     = iv_msg_v1
     iv_msg_v2     = iv_msg_v2
     iv_msg_v3     = iv_msg_v3
     iv_msg_v4     = iv_msg_v4
     iv_agent      = 'DPC' ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~RFC_EXCEPTION_HANDLING.
* RFC call exception handling
DATA lo_logger  TYPE REF TO /iwbep/cl_cos_logger.

lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).

/iwbep/cl_sb_gen_dpc_rt_util=>rfc_exception_handling(
  EXPORTING
    iv_subrc            = iv_subrc
    iv_exp_message_text = iv_exp_message_text
    io_logger           = lo_logger ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~RFC_SAVE_LOG.
  DATA lo_logger  TYPE REF TO /iwbep/cl_cos_logger.
  DATA lo_message_container TYPE REF TO /iwbep/if_message_container.

  lo_logger = /iwbep/if_mgw_conv_srv_runtime~get_logger( ).
  lo_message_container = /iwbep/if_mgw_conv_srv_runtime~get_message_container( ).

  " Save the RFC call log in the application log
  /iwbep/cl_sb_gen_dpc_rt_util=>rfc_save_log(
    EXPORTING
      is_return            = is_return
      iv_entity_type       = iv_entity_type
      it_return            = it_return
      it_key_tab           = it_key_tab
      io_logger            = lo_logger
      io_message_container = lo_message_container ).
  endmethod.


  method /IWBEP/IF_SB_DPC_COMM_SERVICES~SET_INJECTION.
* Unit test injection
  IF io_unit IS BOUND.
    mo_injection = io_unit.
  ELSE.
    mo_injection = me.
  ENDIF.
  endmethod.


  method CHECK_SUBSCRIPTION_AUTHORITY.
  RAISE EXCEPTION TYPE /iwbep/cx_mgw_not_impl_exc
    EXPORTING
      textid = /iwbep/cx_mgw_not_impl_exc=>method_not_implemented
      method = 'CHECK_SUBSCRIPTION_AUTHORITY'.
  endmethod.


  method C_CNSLDTNUNITVAL_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method C_CNSLDTNUNITVAL_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method C_CNSLDTNUNITVAL_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method C_CNSLDTNUNITVAL_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method C_CNSLDTNUNITVAL_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method IF_SADL_GW_DPC_UTIL~GET_DPC.
    TYPES ty_/EY1/I_READINTENTVH_1 TYPE /ey1/i_readintentvh ##NEEDED. " reference for where-used list
    TYPES ty_/EY1/SAV_C_CTR_TAX_RATE_2 TYPE /ey1/sav_c_ctr_tax_rates ##NEEDED. " reference for where-used list
    TYPES ty_C_CNSLDTNUNITVALUEHELP_3 TYPE c_cnsldtnunitvaluehelp ##NEEDED. " reference for where-used list
    TYPES ty_I_CNSLDTNDIMENSION_4 TYPE i_cnsldtndimension ##NEEDED. " reference for where-used list
    TYPES ty_I_CNSLDTNDIMENSIONT_5 TYPE i_cnsldtndimensiont ##NEEDED. " reference for where-used list
    TYPES ty_I_CNSLDTNUNITT_6 TYPE i_cnsldtnunitt ##NEEDED. " reference for where-used list
    TYPES ty_I_DRAFTADMINISTRATIVEDA_7 TYPE i_draftadministrativedata ##NEEDED. " reference for where-used list
    TYPES ty_I_LANGUAGE_8 TYPE i_language ##NEEDED. " reference for where-used list
    TYPES ty_I_LANGUAGETEXT_9 TYPE i_languagetext ##NEEDED. " reference for where-used list
    TYPES ty_Z_I_READINTENTVH_10 TYPE z_i_readintentvh ##NEEDED. " reference for where-used list
    TYPES ty_/EY1/I_TAX_R_D_11 TYPE /ey1/i_tax_r_d ##NEEDED. " reference for where-used list

    DATA(lv_sadl_xml) =
               |<?xml version="1.0" encoding="utf-16"?>| &
               |<sadl:definition xmlns:sadl="http://sap.com/sap.nw.f.sadl" syntaxVersion="" >| &
               | <sadl:dataSource type="CDS" name="/EY1/I_READINTENTVH" binding="/EY1/I_READINTENTVH" />| &
               | <sadl:dataSource type="CDS" name="I_CNSLDTNUNITT" binding="I_CNSLDTNUNITT" />| &
               | <sadl:dataSource type="CDS" name="I_LANGUAGE" binding="I_LANGUAGE" />| &
               | <sadl:dataSource type="CDS" name="Z_I_READINTENTVH" binding="Z_I_READINTENTVH" />| &
               | <sadl:dataSource type="CDS" name="/EY1/SAV_C_CTR_TAX_RATES" binding="/EY1/SAV_C_CTR_TAX_RATES" />| &
               | <sadl:dataSource type="CDS" name="C_CNSLDTNUNITVALUEHELP" binding="C_CNSLDTNUNITVALUEHELP" />| &
               | <sadl:dataSource type="CDS" name="I_CNSLDTNDIMENSION" binding="I_CNSLDTNDIMENSION" />| &
               |<sadl:resultSet>| &
               |<sadl:structure name="xEY1xI_ReadIntentVH" dataSource="/EY1/I_READINTENTVH" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |<sadl:structure name="I_CnsldtnUnitT" dataSource="I_CNSLDTNUNITT" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               | <sadl:association name="TO_DIMENSION" binding="_DIMENSION" target="I_CnsldtnDimension" cardinality="zeroToOne" />| &
               | <sadl:association name="TO_LANGUAGE" binding="_LANGUAGE" target="I_Language" cardinality="zeroToOne" />| &
               |</sadl:structure>| &
               |<sadl:structure name="I_Language" dataSource="I_LANGUAGE" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |<sadl:structure name="Z_I_ReadIntentVH" dataSource="Z_I_READINTENTVH" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |<sadl:structure name="xEY1xSAV_C_CTR_Tax_Rates" dataSource="/EY1/SAV_C_CTR_TAX_RATES" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               | <sadl:association name="TO_CNSLDTNUNITTEXT" binding="_CNSLDTNUNITTEXT" target="I_CnsldtnUnitT" cardinality="one" />| &
               | <sadl:association name="TO_INTENTVH" binding="_INTENTVH" target="xEY1xI_ReadIntentVH" cardinality="one" />| &
               |</sadl:structure>| &
               |<sadl:structure name="C_CnsldtnUnitValueHelp" dataSource="C_CNSLDTNUNITVALUEHELP" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |<sadl:structure name="I_CnsldtnDimension" dataSource="I_CNSLDTNDIMENSION" maxEditMode="RO" exposure="TRUE" >| &
               | <sadl:query name="SADL_QUERY">| &
               | </sadl:query>| &
               |</sadl:structure>| &
               |</sadl:resultSet>| &
               |</sadl:definition>| .
    ro_dpc = cl_sadl_gw_dpc_factory=>create_for_sadl( iv_sadl_xml   = lv_sadl_xml
               iv_timestamp         = 20210119112227
               iv_uuid              = '/EY1/SAV_TAX_RATES'
               io_context           = me->mo_context ).
  endmethod.


  method I_CNSLDTNDIMENSI_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_CNSLDTNDIMENSI_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method I_CNSLDTNDIMENSI_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_CNSLDTNDIMENSI_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method I_CNSLDTNDIMENSI_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_CNSLDTNUNITT_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_CNSLDTNUNITT_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method I_CNSLDTNUNITT_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_CNSLDTNUNITT_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method I_CNSLDTNUNITT_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_DRAFTADMINISTR_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_DRAFTADMINISTR_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method I_DRAFTADMINISTR_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_DRAFTADMINISTR_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method I_DRAFTADMINISTR_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_LANGUAGE_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_LANGUAGE_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method I_LANGUAGE_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method I_LANGUAGE_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method I_LANGUAGE_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method XEY1XI_READINTEN_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method XEY1XI_READINTEN_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method XEY1XI_READINTEN_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method XEY1XI_READINTEN_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method XEY1XI_READINTEN_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method XEY1XSAV_C_CTR_T_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method XEY1XSAV_C_CTR_T_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method XEY1XSAV_C_CTR_T_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method XEY1XSAV_C_CTR_T_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method XEY1XSAV_C_CTR_T_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method Z_I_READINTENTVH_CREATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->create_entity( EXPORTING io_data_provider        = io_data_provider
                                                             io_tech_request_context = io_tech_request_context
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.


  method Z_I_READINTENTVH_DELETE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->delete_entity( io_tech_request_context ).
  endmethod.


  method Z_I_READINTENTVH_GET_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->get_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                IMPORTING es_data                 = er_entity ).
  endmethod.


  method Z_I_READINTENTVH_GET_ENTITYSET.
    if_sadl_gw_dpc_util~get_dpc( )->get_entityset( EXPORTING io_tech_request_context = io_tech_request_context
                                                   IMPORTING et_data                 = et_entityset
                                                             es_response_context     = es_response_context ).
  endmethod.


  method Z_I_READINTENTVH_UPDATE_ENTITY.
    if_sadl_gw_dpc_util~get_dpc( )->update_entity( EXPORTING io_tech_request_context = io_tech_request_context
                                                             io_data_provider        = io_data_provider
                                                   IMPORTING es_data                 = er_entity ).
  endmethod.
ENDCLASS.

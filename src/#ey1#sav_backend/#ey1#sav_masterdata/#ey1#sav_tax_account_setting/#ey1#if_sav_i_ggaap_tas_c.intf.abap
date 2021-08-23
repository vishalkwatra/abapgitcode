interface /EY1/IF_SAV_I_GGAAP_TAS_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 ACTIVATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B023FB0E9',
 CREATE_/EY1/SAV_I_GGAAP_TAS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F493B0E9',
 DELETE_/EY1/SAV_I_GGAAP_TAS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F49430E9',
 EDIT                           TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B023F90E9',
 LOCK_/EY1/SAV_I_GGAAP_TAS      TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F492F0E9',
 PREPARATION                    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B023FF0E9',
 SAVE_/EY1/SAV_I_GGAAP_TAS      TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F494B0E9',
 UNLOCK_/EY1/SAV_I_GGAAP_TAS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F49330E9',
 UPDATE_/EY1/SAV_I_GGAAP_TAS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F493F0E9',
 VALIDATE_/EY1/SAV_I_GGAAP_TAS  TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD49F49470E9',
 VALIDATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B023FD0E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
 CREATE_SAV_I_SGAAP_TAS         TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B0254D0E9',
 DELETE_SAV_I_SGAAP_TAS         TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B025550E9',
 PREPARATION                    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B0241D0E9',
 SAVE_SAV_I_SGAAP_TAS           TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B0255D0E9',
 UPDATE_SAV_I_SGAAP_TAS         TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B025510E9',
 VALIDATE_SAV_I_SGAAP_TAS       TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B025590E9',
 VALIDATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB9995DD6B0241B0E9',
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF /EY1/SAV_I_GGAAP_TAS,
        BEGIN OF EDIT,
 PRESERVE_CHANGES               TYPE STRING VALUE 'PRESERVE_CHANGES',
        END OF EDIT,
        BEGIN OF LOCK_/EY1/SAV_I_GGAAP_TAS,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF LOCK_/EY1/SAV_I_GGAAP_TAS,
        BEGIN OF PREPARATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF PREPARATION,
        BEGIN OF UNLOCK_/EY1/SAV_I_GGAAP_TAS,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF UNLOCK_/EY1/SAV_I_GGAAP_TAS,
        BEGIN OF VALIDATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF VALIDATION,
      END OF /EY1/SAV_I_GGAAP_TAS,
        BEGIN OF /EY1/SAV_I_SGAAP_TAS,
        BEGIN OF PREPARATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF PREPARATION,
        BEGIN OF VALIDATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF VALIDATION,
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 ACTIVE_ENTITY_KEY              TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB9995DD6B023F50E9',
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB9995DD6B023F70E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
 ACTIVE_ENTITY_KEY              TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB9995DD6B024130E9',
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB9995DD6B024150E9',
 PARENT_KEY                     TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB9995DD6B024170E9',
 ROOT_KEY                       TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB9995DD6B024190E9',
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD49F492D0E9',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD49F49290E9',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD49F49390E9',
 _SGAAP                         TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B025350E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD49F49510E9',
      END OF /EY1/SAV_I_GGAAP_TAS_LOCK,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD49F494F0E9',
      END OF /EY1/SAV_I_GGAAP_TAS_MESSAGE,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD49F49530E9',
      END OF /EY1/SAV_I_GGAAP_TAS_PROPERTY,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B025470E9',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B0254B0E9',
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B025610E9',
 TO_ROOT                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B025630E9',
      END OF /EY1/SAV_I_SGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B025650E9',
      END OF /EY1/SAV_I_SGAAP_TAS_MESSAGE,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB9995DD6B025670E9',
      END OF /EY1/SAV_I_SGAAP_TAS_PROPERTY,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
        BEGIN OF PROPERTY,
 ALL_NODE_PROPERTY              TYPE STRING VALUE 'ALL_NODE_PROPERTY',
 ALL_NODE_ATTRIBUTE_PROPERTY    TYPE STRING VALUE 'ALL_NODE_ATTRIBUTE_PROPERTY',
 ALL_ASSOCIATION_PROPERTY       TYPE STRING VALUE 'ALL_ASSOCIATION_PROPERTY',
 ALL_ASSOCIATION_ATTRIBUTE_PROP TYPE STRING VALUE 'ALL_ASSOCIATION_ATTRIBUTE_PROP',
 ALL_ACTION_PROPERTY            TYPE STRING VALUE 'ALL_ACTION_PROPERTY',
 ALL_ACTION_ATTRIBUTE_PROPERTY  TYPE STRING VALUE 'ALL_ACTION_ATTRIBUTE_PROPERTY',
 ALL_QUERY_PROPERTY             TYPE STRING VALUE 'ALL_QUERY_PROPERTY',
 ALL_QUERY_ATTRIBUTE_PROPERTY   TYPE STRING VALUE 'ALL_QUERY_ATTRIBUTE_PROPERTY',
 ALL_SUBTREE_PROPERTY           TYPE STRING VALUE 'ALL_SUBTREE_PROPERTY',
        END OF PROPERTY,
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '000D3A212B281EEB9995DD49F491F0E9' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE '/EY1/SAV_I_GGAAP_TAS' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024010E9',
 ADMINISTRATIVE_DATA            TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9B85B11B3D00146D',
 CENTRAL_ADMIN_DATA             TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024030E9',
 DRAFT_ACTION_CONTROL           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B0240F0E9',
 DRAFT_SYS_ADMIN_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B0240D0E9',
 DURABLE_LOCK_CLEANUP_CLEANUP   TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B0240B0E9',
 DURABLE_LOCK_CLEANUP_DELETE    TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024050E9',
 DURABLE_LOCK_CLEANUP_FAIL_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024090E9',
 DURABLE_LOCK_CLEANUP_SUCC_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024070E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B0241F0E9',
 ADMINISTRATIVE_DATA            TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9B85A7D3A6B1546D',
 DRAFT_ACTION_CONTROL           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024230E9',
 DRAFT_SYS_ADMIN_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9995DD6B024210E9',
 INITIALIZE_SGAAP               TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB9B9FAE3BF01D54AC',
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_DETERMINATION .
  constants:
    BEGIN OF SC_GROUP,
 /EY1/SAV_I_GGAAP_TAS           TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A212B281EEB99D74BEA7936F19C',
 DRAFT_CONSISTENCY              TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A212B281EEB9995DD49F49570E9',
    END OF SC_GROUP .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 /EY1/SAV_I_GGAAP_TAS           TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD49F49230E9',
 /EY1/SAV_I_GGAAP_TAS_LOCK      TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD49F492B0E9',
 /EY1/SAV_I_GGAAP_TAS_MESSAGE   TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD49F49270E9',
 /EY1/SAV_I_GGAAP_TAS_PROPERTY  TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD49F49370E9',
 /EY1/SAV_I_SGAAP_TAS           TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD49F495D0E9',
 /EY1/SAV_I_SGAAP_TAS_MESSAGE   TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD6B025450E9',
 /EY1/SAV_I_SGAAP_TAS_PROPERTY  TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB9995DD6B025490E9',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  CONSOLIDATIONGROUP             TYPE STRING VALUE 'CONSOLIDATIONGROUP',
  CONSOLIDATIONGROUPFOREDIT      TYPE STRING VALUE 'CONSOLIDATIONGROUPFOREDIT',
  CONSOLIDATIONGROUPMEDIUMTEXT   TYPE STRING VALUE 'CONSOLIDATIONGROUPMEDIUMTEXT',
  CLASSIFICATION                 TYPE STRING VALUE 'CLASSIFICATION',
  TAXRATECHANGE                  TYPE STRING VALUE 'TAXRATECHANGE',
  DTARECONGNITION                TYPE STRING VALUE 'DTARECONGNITION',
  DTINTRACOMPANYELIMINATION      TYPE STRING VALUE 'DTINTRACOMPANYELIMINATION',
  CREATEDBY                      TYPE STRING VALUE 'CREATEDBY',
  CREATEDON                      TYPE STRING VALUE 'CREATEDON',
  CHANGEDBY                      TYPE STRING VALUE 'CHANGEDBY',
  CHANGEDON                      TYPE STRING VALUE 'CHANGEDON',
  HASACTIVEENTITY                TYPE STRING VALUE 'HASACTIVEENTITY',
  DRAFTENTITYCREATIONDATETIME    TYPE STRING VALUE 'DRAFTENTITYCREATIONDATETIME',
  DRAFTENTITYLASTCHANGEDATETIME  TYPE STRING VALUE 'DRAFTENTITYLASTCHANGEDATETIME',
  DRAFTADMINISTRATIVEDATAUUID    TYPE STRING VALUE 'DRAFTADMINISTRATIVEDATAUUID',
  DRAFTENTITYCONSISTENCYSTATUS   TYPE STRING VALUE 'DRAFTENTITYCONSISTENCYSTATUS',
  DRAFTENTITYOPERATIONCODE       TYPE STRING VALUE 'DRAFTENTITYOPERATIONCODE',
  ISACTIVEENTITY                 TYPE STRING VALUE 'ISACTIVEENTITY',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  CONSOLIDATIONGROUP             TYPE STRING VALUE 'CONSOLIDATIONGROUP',
  CONSOLIDATIONUNIT              TYPE STRING VALUE 'CONSOLIDATIONUNIT',
  CONSOLIDATIONGROUPFOREDIT      TYPE STRING VALUE 'CONSOLIDATIONGROUPFOREDIT',
  CONSOLIDATIONUNITFOREDIT       TYPE STRING VALUE 'CONSOLIDATIONUNITFOREDIT',
  CLASSIFICATION                 TYPE STRING VALUE 'CLASSIFICATION',
  TAXRATECHANGE                  TYPE STRING VALUE 'TAXRATECHANGE',
  DTARECOGNITION                 TYPE STRING VALUE 'DTARECOGNITION',
  DTINTRACOMPANYELIMINATION      TYPE STRING VALUE 'DTINTRACOMPANYELIMINATION',
  CREATEDBY                      TYPE STRING VALUE 'CREATEDBY',
  CREATEDON                      TYPE STRING VALUE 'CREATEDON',
  CHANGEDBY                      TYPE STRING VALUE 'CHANGEDBY',
  CHANGEDON                      TYPE STRING VALUE 'CHANGEDON',
  HASACTIVEENTITY                TYPE STRING VALUE 'HASACTIVEENTITY',
  DRAFTENTITYCREATIONDATETIME    TYPE STRING VALUE 'DRAFTENTITYCREATIONDATETIME',
  DRAFTENTITYLASTCHANGEDATETIME  TYPE STRING VALUE 'DRAFTENTITYLASTCHANGEDATETIME',
  DRAFTADMINISTRATIVEDATAUUID    TYPE STRING VALUE 'DRAFTADMINISTRATIVEDATAUUID',
  DRAFTENTITYCONSISTENCYSTATUS   TYPE STRING VALUE 'DRAFTENTITYCONSISTENCYSTATUS',
  DRAFTENTITYOPERATIONCODE       TYPE STRING VALUE 'DRAFTENTITYOPERATIONCODE',
  ISACTIVEENTITY                 TYPE STRING VALUE 'ISACTIVEENTITY',
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000D3A212B281EEB9995DD49F49250E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
 /EY1/SAV_I_SGAAP_TAS           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000D3A212B281EEB9995DD6B025330E9',
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_NODE_CATEGORY .
  constants:
    BEGIN OF SC_STATUS_VARIABLE,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 DRAFT_CONSISTENCY_STATUS       TYPE /BOBF/STA_VAR_KEY VALUE '000D3A212B281EEB9995DD49F49550E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
    END OF SC_STATUS_VARIABLE .
  constants:
    BEGIN OF SC_VALIDATION,
      BEGIN OF /EY1/SAV_I_GGAAP_TAS,
 CHECK_GGAAP_MANDATORY          TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB99D74BEA7936919C',
 DURABLE_LOCK_CREATE_FOR_NEW    TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB9995DD6B024110E9',
      END OF /EY1/SAV_I_GGAAP_TAS,
      BEGIN OF /EY1/SAV_I_SGAAP_TAS,
 CHECK_SGAAP_MANDATORY          TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB99D8616ED25C51A1',
      END OF /EY1/SAV_I_SGAAP_TAS,
    END OF SC_VALIDATION .
endinterface.

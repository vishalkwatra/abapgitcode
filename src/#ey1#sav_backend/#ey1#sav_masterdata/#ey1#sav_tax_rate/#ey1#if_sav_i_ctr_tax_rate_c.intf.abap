interface /EY1/IF_SAV_I_CTR_TAX_RATE_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 ACTIVATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0BA49FC',
 CREATE_/EY1/SAV_I_CTR_TAX_RATE TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B7C9FC',
 DELETE_/EY1/SAV_I_CTR_TAX_RATE TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B849FC',
 EDIT                           TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0BA29FC',
 LOCK_/EY1/SAV_I_CTR_TAX_RATE   TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B709FC',
 PREPARATION                    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0BA89FC',
 SAVE_/EY1/SAV_I_CTR_TAX_RATE   TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B8C9FC',
 UNLOCK_/EY1/SAV_I_CTR_TAX_RATE TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B749FC',
 UPDATE_/EY1/SAV_I_CTR_TAX_RATE TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B809FC',
 VALIDATE_/EY1/SAV_I_CTR_TAX_RA TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0B889FC',
 VALIDATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E5721AA0BA69FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
        BEGIN OF EDIT,
 PRESERVE_CHANGES               TYPE STRING VALUE 'PRESERVE_CHANGES',
        END OF EDIT,
        BEGIN OF LOCK_/EY1/SAV_I_CTR_TAX_RATE,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF LOCK_/EY1/SAV_I_CTR_TAX_RATE,
        BEGIN OF PREPARATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF PREPARATION,
        BEGIN OF UNLOCK_/EY1/SAV_I_CTR_TAX_RATE,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF UNLOCK_/EY1/SAV_I_CTR_TAX_RATE,
        BEGIN OF VALIDATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF VALIDATION,
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 ACTIVE_ENTITY_KEY              TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E5721AA0B9E9FC',
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E5721AA0BA09FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E5721AA0B6E9FC',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E5721AA0B6A9FC',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E5721AA0B7A9FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E5721AA0B929FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE_LOCK,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE_MESSAG,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E5721AA0B909FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE_MESSAG,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE_PROPER,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E5721AA0B949FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE_PROPER,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
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
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '000D3A212B281EEB95E5721AA0B609FC' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE '/EY1/SAV_I_CTR_TAX_RATE' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BAA9FC',
 CENTRAL_ADMIN_DATA             TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BAC9FC',
 CHANGE_TAX_RATE_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB96AC8A6867FDAA27',
 DRAFT_ACTION_CONTROL           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BB89FC',
 DRAFT_SYS_ADMIN_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BB69FC',
 DURABLE_LOCK_CLEANUP_CLEANUP   TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BB49FC',
 DURABLE_LOCK_CLEANUP_DELETE    TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BAE9FC',
 DURABLE_LOCK_CLEANUP_FAIL_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BB29FC',
 DURABLE_LOCK_CLEANUP_SUCC_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E5721AA0BB09FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_DETERMINATION .
  constants:
    BEGIN OF SC_GROUP,
 /EY1/SAV_I_CTR_TAX_RATE        TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A212B281EEB96AC9889C2682A27',
 DRAFT_CONSISTENCY              TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A212B281EEB95E5721AA0B989FC',
    END OF SC_GROUP .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 /EY1/SAV_I_CTR_TAX_RATE        TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E5721AA0B649FC',
 /EY1/SAV_I_CTR_TAX_RATE_LOCK   TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E5721AA0B6C9FC',
 /EY1/SAV_I_CTR_TAX_RATE_MESSAG TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E5721AA0B689FC',
 /EY1/SAV_I_CTR_TAX_RATE_PROPER TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E5721AA0B789FC',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  RBUNIT                         TYPE STRING VALUE 'RBUNIT',
  GJAHR                          TYPE STRING VALUE 'GJAHR',
  INTENTION                      TYPE STRING VALUE 'INTENTION',
  RBUNITFOREDIT                  TYPE STRING VALUE 'RBUNITFOREDIT',
  GJAHRFOREDIT                   TYPE STRING VALUE 'GJAHRFOREDIT',
  INTENTIONFOREDIT               TYPE STRING VALUE 'INTENTIONFOREDIT',
  CURRENT_TAX_RATE               TYPE STRING VALUE 'CURRENT_TAX_RATE',
  CURRENT_TAX_RATEFOREDIT        TYPE STRING VALUE 'CURRENT_TAX_RATEFOREDIT',
  GAAP_OB_DT_RATE                TYPE STRING VALUE 'GAAP_OB_DT_RATE',
  GAAP_OB_DT_RATEFOREDIT         TYPE STRING VALUE 'GAAP_OB_DT_RATEFOREDIT',
  GAAP_CB_DT_RATE                TYPE STRING VALUE 'GAAP_CB_DT_RATE',
  GAAP_CB_DT_RATEFOREDIT         TYPE STRING VALUE 'GAAP_CB_DT_RATEFOREDIT',
  STAT_OB_DT_RATE                TYPE STRING VALUE 'STAT_OB_DT_RATE',
  STAT_OB_DT_RATEFOREDIT         TYPE STRING VALUE 'STAT_OB_DT_RATEFOREDIT',
  STAT_CB_DT_RATE                TYPE STRING VALUE 'STAT_CB_DT_RATE',
  STAT_CB_DT_RATEFOREDIT         TYPE STRING VALUE 'STAT_CB_DT_RATEFOREDIT',
  CREATED_BY                     TYPE STRING VALUE 'CREATED_BY',
  CREATED_ON                     TYPE STRING VALUE 'CREATED_ON',
  CHANGED_BY                     TYPE STRING VALUE 'CHANGED_BY',
  CHANGED_ON                     TYPE STRING VALUE 'CHANGED_ON',
  HASACTIVEENTITY                TYPE STRING VALUE 'HASACTIVEENTITY',
  DRAFTENTITYCREATIONDATETIME    TYPE STRING VALUE 'DRAFTENTITYCREATIONDATETIME',
  DRAFTENTITYLASTCHANGEDATETIME  TYPE STRING VALUE 'DRAFTENTITYLASTCHANGEDATETIME',
  DRAFTADMINISTRATIVEDATAUUID    TYPE STRING VALUE 'DRAFTADMINISTRATIVEDATAUUID',
  DRAFTENTITYCONSISTENCYSTATUS   TYPE STRING VALUE 'DRAFTENTITYCONSISTENCYSTATUS',
  DRAFTENTITYOPERATIONCODE       TYPE STRING VALUE 'DRAFTENTITYOPERATIONCODE',
  ISACTIVEENTITY                 TYPE STRING VALUE 'ISACTIVEENTITY',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000D3A212B281EEB95E5721AA0B669FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_NODE_CATEGORY .
  constants:
    BEGIN OF SC_STATUS_VARIABLE,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 DRAFT_CONSISTENCY_STATUS       TYPE /BOBF/STA_VAR_KEY VALUE '000D3A212B281EEB95E5721AA0B969FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_STATUS_VARIABLE .
  constants:
    BEGIN OF SC_VALIDATION,
      BEGIN OF /EY1/SAV_I_CTR_TAX_RATE,
 CHECK_MANADATORY               TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB96AC9889C267CA27',
 CHECK_PREVIOUS_YEAR            TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB96AC9E76F8830A28',
 DURABLE_LOCK_CREATE_FOR_NEW    TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB95E5721AA0BBA9FC',
      END OF /EY1/SAV_I_CTR_TAX_RATE,
    END OF SC_VALIDATION .
endinterface.

interface /EY1/IF_SAV_I_ACC_CLASS_C
  public .


  interfaces /BOBF/IF_LIB_CONSTANTS .

  constants:
    BEGIN OF SC_ACTION,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 ACTIVATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C57269FA',
 CREATE_/EY1/SAV_I_ACC_CLASS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51971860789FA',
 DELETE_/EY1/SAV_I_ACC_CLASS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51971860809FA',
 EDIT                           TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C57249FA',
 LOCK_/EY1/SAV_I_ACC_CLASS      TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E519718606C9FA',
 PREPARATION                    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C572A9FA',
 SAVE_/EY1/SAV_I_ACC_CLASS      TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51971860889FA',
 UNLOCK_/EY1/SAV_I_ACC_CLASS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51971860709FA',
 UPDATE_/EY1/SAV_I_ACC_CLASS    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E519718607C9FA',
 VALIDATE_/EY1/SAV_I_ACC_CLASS  TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51971860849FA',
 VALIDATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C57289FA',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
 CREATE_SAV_I_ACC_FS_ITEM       TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C58829FA',
 DELETE_SAV_I_ACC_FS_ITEM       TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C588A9FA',
 PREPARATION                    TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C57489FA',
 SAVE_SAV_I_ACC_FS_ITEM         TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C58929FA',
 UPDATE_SAV_I_ACC_FS_ITEM       TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C58869FA',
 VALIDATE_SAV_I_ACC_FS_ITEM     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C588E9FA',
 VALIDATION                     TYPE /BOBF/ACT_KEY VALUE '000D3A212B281EEB95E51998C57469FA',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_ACTION .
  constants:
    BEGIN OF SC_ACTION_ATTRIBUTE,
        BEGIN OF /EY1/SAV_I_ACC_CLASS,
        BEGIN OF EDIT,
 PRESERVE_CHANGES               TYPE STRING VALUE 'PRESERVE_CHANGES',
        END OF EDIT,
        BEGIN OF LOCK_/EY1/SAV_I_ACC_CLASS,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF LOCK_/EY1/SAV_I_ACC_CLASS,
        BEGIN OF PREPARATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF PREPARATION,
        BEGIN OF UNLOCK_/EY1/SAV_I_ACC_CLASS,
 GENERIC                        TYPE STRING VALUE 'GENERIC',
 EDIT_MODE                      TYPE STRING VALUE 'EDIT_MODE',
 ALL_NONE                       TYPE STRING VALUE 'ALL_NONE',
 SCOPE                          TYPE STRING VALUE 'SCOPE',
 FORCE_INVALIDATION             TYPE STRING VALUE 'FORCE_INVALIDATION',
 LOCK_PARAMETER_BUFFER          TYPE STRING VALUE 'LOCK_PARAMETER_BUFFER',
 LEGACY_DAC_KEY                 TYPE STRING VALUE 'LEGACY_DAC_KEY',
        END OF UNLOCK_/EY1/SAV_I_ACC_CLASS,
        BEGIN OF VALIDATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF VALIDATION,
      END OF /EY1/SAV_I_ACC_CLASS,
        BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
        BEGIN OF PREPARATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF PREPARATION,
        BEGIN OF VALIDATION,
 SIDEEFFECTSQUALIFIER           TYPE STRING VALUE 'SIDEEFFECTSQUALIFIER',
        END OF VALIDATION,
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_ACTION_ATTRIBUTE .
  constants:
    BEGIN OF SC_ALTERNATIVE_KEY,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 ACTIVE_ENTITY_KEY              TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E51998C57209FA',
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E51998C57229FA',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
 ACTIVE_ENTITY_KEY              TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E51998C573E9FA',
 DB_KEY                         TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E51998C57409FA',
 PARENT_KEY                     TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E51998C57429FA',
 ROOT_KEY                       TYPE /BOBF/OBM_ALTKEY_KEY VALUE '000D3A212B281EEB95E51998C57449FA',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_ALTERNATIVE_KEY .
  constants:
    BEGIN OF SC_ASSOCIATION,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 LOCK                           TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E519718606A9FA',
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51971860669FA',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51971860769FA',
 _FINSTATITEM                   TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C586A9FA',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_CLASS_LOCK,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E519718608E9FA',
      END OF /EY1/SAV_I_ACC_CLASS_LOCK,
      BEGIN OF /EY1/SAV_I_ACC_CLASS_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E519718608C9FA',
      END OF /EY1/SAV_I_ACC_CLASS_MESSAGE,
      BEGIN OF /EY1/SAV_I_ACC_CLASS_PROPERTY,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51971860909FA',
      END OF /EY1/SAV_I_ACC_CLASS_PROPERTY,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
 MESSAGE                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C587C9FA',
 PROPERTY                       TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C58809FA',
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C58969FA',
 TO_ROOT                        TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C58989FA',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM_MESSAGE,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C589A9FA',
      END OF /EY1/SAV_I_ACC_FS_ITEM_MESSAGE,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM_PROPERT,
 TO_PARENT                      TYPE /BOBF/OBM_ASSOC_KEY VALUE '000D3A212B281EEB95E51998C589C9FA',
      END OF /EY1/SAV_I_ACC_FS_ITEM_PROPERT,
    END OF SC_ASSOCIATION .
  constants:
    BEGIN OF SC_ASSOCIATION_ATTRIBUTE,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
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
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
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
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_ASSOCIATION_ATTRIBUTE .
  constants:
    SC_BO_KEY  TYPE /BOBF/OBM_BO_KEY VALUE '000D3A212B281EEB95E519718605C9FA' .
  constants:
    SC_BO_NAME TYPE /BOBF/OBM_NAME VALUE '/EY1/SAV_I_ACC_CLASS' .
  constants:
    BEGIN OF SC_DETERMINATION,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C572C9FA',
 CENTRAL_ADMIN_DATA             TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C572E9FA',
 DRAFT_ACTION_CONTROL           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C573A9FA',
 DRAFT_SYS_ADMIN_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C57389FA',
 DURABLE_LOCK_CLEANUP_CLEANUP   TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C57369FA',
 DURABLE_LOCK_CLEANUP_DELETE    TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C57309FA',
 DURABLE_LOCK_CLEANUP_FAIL_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C57349FA',
 DURABLE_LOCK_CLEANUP_SUCC_SAVE TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C57329FA',
 FC_CNC_FIELD                   TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB96AAE3C28AF4AA22',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
 ACTION_AND_FIELD_CONTROL       TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C574A9FA',
 DRAFT_ACTION_CONTROL           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C574E9FA',
 DRAFT_SYS_ADMIN_DATA           TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB95E51998C574C9FA',
 INITIALISE_FS_ITEM             TYPE /BOBF/DET_KEY VALUE '000D3A212B281EEB96ABAF0B39BDAA23',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_DETERMINATION .
  constants:
    BEGIN OF SC_GROUP,
 /EY1/SAV_I_ACC_CLASS           TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A212B281EEB96AB112204E74A22',
 DRAFT_CONSISTENCY              TYPE /BOBF/OBM_GROUP_KEY VALUE '000D3A212B281EEB95E51971860949FA',
    END OF SC_GROUP .
  constants:
    SC_MODEL_VERSION TYPE /BOBF/CONF_VERSION VALUE '00000' .
  constants:
    BEGIN OF SC_NODE,
 /EY1/SAV_I_ACC_CLASS           TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51971860609FA',
 /EY1/SAV_I_ACC_CLASS_LOCK      TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51971860689FA',
 /EY1/SAV_I_ACC_CLASS_MESSAGE   TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51971860649FA',
 /EY1/SAV_I_ACC_CLASS_PROPERTY  TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51971860749FA',
 /EY1/SAV_I_ACC_FS_ITEM         TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51998C570A9FA',
 /EY1/SAV_I_ACC_FS_ITEM_MESSAGE TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51998C587A9FA',
 /EY1/SAV_I_ACC_FS_ITEM_PROPERT TYPE /BOBF/OBM_NODE_KEY VALUE '000D3A212B281EEB95E51998C587E9FA',
    END OF SC_NODE .
  constants:
    BEGIN OF SC_NODE_ATTRIBUTE,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  ACCOUNTCLASSCODE               TYPE STRING VALUE 'ACCOUNTCLASSCODE',
  ACCOUNTCLASSCODEFOREDIT        TYPE STRING VALUE 'ACCOUNTCLASSCODEFOREDIT',
  ACCOUNTCLASSCODETEXT           TYPE STRING VALUE 'ACCOUNTCLASSCODETEXT',
  DEBITCREDITINDICATOR           TYPE STRING VALUE 'DEBITCREDITINDICATOR',
  CURRENTNONCURRENT              TYPE STRING VALUE 'CURRENTNONCURRENT',
  CURRENTNONCURRENTDOMTEXT       TYPE STRING VALUE 'CURRENTNONCURRENTDOMTEXT',
  BSEQPL                         TYPE STRING VALUE 'BSEQPL',
  BSEQPLDOMTEXT                  TYPE STRING VALUE 'BSEQPLDOMTEXT',
  TAXEFFECTED                    TYPE STRING VALUE 'TAXEFFECTED',
  PROFITBEFORETAX                TYPE STRING VALUE 'PROFITBEFORETAX',
  HASACTIVEENTITY                TYPE STRING VALUE 'HASACTIVEENTITY',
  DRAFTENTITYCREATIONDATETIME    TYPE STRING VALUE 'DRAFTENTITYCREATIONDATETIME',
  DRAFTENTITYLASTCHANGEDATETIME  TYPE STRING VALUE 'DRAFTENTITYLASTCHANGEDATETIME',
  DRAFTADMINISTRATIVEDATAUUID    TYPE STRING VALUE 'DRAFTADMINISTRATIVEDATAUUID',
  DRAFTENTITYCONSISTENCYSTATUS   TYPE STRING VALUE 'DRAFTENTITYCONSISTENCYSTATUS',
  DRAFTENTITYOPERATIONCODE       TYPE STRING VALUE 'DRAFTENTITYOPERATIONCODE',
  ISACTIVEENTITY                 TYPE STRING VALUE 'ISACTIVEENTITY',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
  NODE_DATA                      TYPE STRING VALUE 'NODE_DATA',
  ACCOUNTCLASSCODE               TYPE STRING VALUE 'ACCOUNTCLASSCODE',
  CONSOLIDATIONCHARTOFACCOUNTS   TYPE STRING VALUE 'CONSOLIDATIONCHARTOFACCOUNTS',
  FINANCIALSTATEMENTITEM         TYPE STRING VALUE 'FINANCIALSTATEMENTITEM',
  ACCOUNTCLASSCODEFOREDIT        TYPE STRING VALUE 'ACCOUNTCLASSCODEFOREDIT',
  CONSOLIDATIONCOAFOREDIT        TYPE STRING VALUE 'CONSOLIDATIONCOAFOREDIT',
  FINANCIALSTATEMENTITEMFOREDIT  TYPE STRING VALUE 'FINANCIALSTATEMENTITEMFOREDIT',
  HASACTIVEENTITY                TYPE STRING VALUE 'HASACTIVEENTITY',
  DRAFTENTITYCREATIONDATETIME    TYPE STRING VALUE 'DRAFTENTITYCREATIONDATETIME',
  DRAFTENTITYLASTCHANGEDATETIME  TYPE STRING VALUE 'DRAFTENTITYLASTCHANGEDATETIME',
  DRAFTADMINISTRATIVEDATAUUID    TYPE STRING VALUE 'DRAFTADMINISTRATIVEDATAUUID',
  DRAFTENTITYCONSISTENCYSTATUS   TYPE STRING VALUE 'DRAFTENTITYCONSISTENCYSTATUS',
  DRAFTENTITYOPERATIONCODE       TYPE STRING VALUE 'DRAFTENTITYOPERATIONCODE',
  ISACTIVEENTITY                 TYPE STRING VALUE 'ISACTIVEENTITY',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_NODE_ATTRIBUTE .
  constants:
    BEGIN OF SC_NODE_CATEGORY,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 ROOT                           TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000D3A212B281EEB95E51971860629FA',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
 /EY1/SAV_I_ACC_FS_ITEM         TYPE /BOBF/OBM_NODE_CAT_KEY VALUE '000D3A212B281EEB95E51998C58689FA',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_NODE_CATEGORY .
  constants:
    BEGIN OF SC_STATUS_VARIABLE,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 DRAFT_CONSISTENCY_STATUS       TYPE /BOBF/STA_VAR_KEY VALUE '000D3A212B281EEB95E51971860929FA',
      END OF /EY1/SAV_I_ACC_CLASS,
    END OF SC_STATUS_VARIABLE .
  constants:
    BEGIN OF SC_VALIDATION,
      BEGIN OF /EY1/SAV_I_ACC_CLASS,
 CHECK_MANDATORY                TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB96AB112204E6EA22',
 DURABLE_LOCK_CREATE_FOR_NEW    TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB95E51998C573C9FA',
      END OF /EY1/SAV_I_ACC_CLASS,
      BEGIN OF /EY1/SAV_I_ACC_FS_ITEM,
 CHECK_MANDATORY_FS             TYPE /BOBF/VAL_KEY VALUE '000D3A212B281EEB96ABC21461510A23',
      END OF /EY1/SAV_I_ACC_FS_ITEM,
    END OF SC_VALIDATION .
endinterface.

@AbapCatalog.sqlViewName: '/EY1/ACCNTCLASS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Interface View for Account Class'

@VDM.viewType: #TRANSACTIONAL

@ObjectModel: { compositionRoot:                true,
                modelCategory:                  #BUSINESS_OBJECT,
                transactionalProcessingEnabled: true,
                createEnabled:                 'EXTERNAL_CALCULATION',
                updateEnabled:                 'EXTERNAL_CALCULATION',
                deleteEnabled:                 'EXTERNAL_CALCULATION',
                semanticKey:                   'AccountClassCode',
                draftEnabled:                   true,
                writeDraftPersistence:          '/EY1/Acc_Class_D' }

define view /EY1/SAV_I_Acc_Class
  as select from /EY1/SAV_I_Accounts_Class
  association [0..*] to /EY1/SAV_I_Acc_FS_Item        as _FinStatItem         on  $projection.AccountClassCode = _FinStatItem.AccountClassCode

  association [1..1] to /EY1/SAV_I_Acc_Class_Text     as _AccClassCodeText    on  $projection.AccountClassCode = _AccClassCodeText.AccountClassCode
                                                                              and _AccClassCodeText.Language   = $session.system_language
  association [1..1] to /EY1/SAV_I_TransactionType_VH as _TransactionTypeText on  $projection.DebitCreditIndicator = _TransactionTypeText.DebitCreditIndicatorDomVal
  association [1..1] to /EY1/SAV_I_AccType_VH         as _AccountTypeText     on  $projection.CurrentNonCurrent = _AccountTypeText.CurrentNonCurrentDomKey
  association [1..1] to /EY1/SAV_I_FSType_VH          as _FSTypeText          on  $projection.BsEqPl = _FSTypeText.BsEqPlDomKey
{

      @ObjectModel.readOnly:true
  key /EY1/SAV_I_Accounts_Class.acc_class_code   as AccountClassCode,

      @ObjectModel:{ readOnly:         'EXTERNAL_CALCULATION',
                     editableFieldFor: 'AccountClassCode' }
      @ObjectModel.mandatory: true
      acc_class_code                             as AccountClassCodeForEdit,

      //@ObjectModel.readOnly:true
      _AccClassCodeText.AccountClassCodeText,

      @ObjectModel.mandatory: true
      /EY1/SAV_I_Accounts_Class.transaction_type as DebitCreditIndicator,

      @ObjectModel.mandatory: 'EXTERNAL_CALCULATION'
      @ObjectModel.readOnly:  'EXTERNAL_CALCULATION'
      @ObjectModel.enabled:   'EXTERNAL_CALCULATION'
      /EY1/SAV_I_Accounts_Class.cnc              as CurrentNonCurrent,

      //@ObjectModel.readOnly:true
      _AccountTypeText.CurrentNonCurrentDomText,

      //@ObjectModel:{ mandatory: 'EXTERNAL_CALCULATION' }
      @ObjectModel.mandatory: true
      /EY1/SAV_I_Accounts_Class.bl_eq_pl         as BsEqPl,

      _FSTypeText.BsEqPlDomText,

      /EY1/SAV_I_Accounts_Class.tax_effect       as TaxEffected,

      /EY1/SAV_I_Accounts_Class.profit           as ProfitBeforeTax,

      @ObjectModel: { association: { type: [#TO_COMPOSITION_CHILD] } }
      _FinStatItem,

      _AccClassCodeText,

      _TransactionTypeText,

      _AccountTypeText,

      _FSTypeText
}

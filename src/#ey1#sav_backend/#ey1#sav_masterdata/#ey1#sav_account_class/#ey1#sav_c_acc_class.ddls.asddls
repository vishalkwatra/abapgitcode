@AbapCatalog.sqlViewName: '/EY1/CACCNTCLASS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Consumption view for Accounts Class'
@VDM.viewType: #CONSUMPTION
@Search.searchable: true

@ObjectModel: { compositionRoot:                   true,
                transactionalProcessingDelegated:  true,
                semanticKey:                       ['AccountClassCode'],
                createEnabled:                     #('EXTERNAL_CALCULATION'),
                updateEnabled:                     #('EXTERNAL_CALCULATION'),
                deleteEnabled:                     #('EXTERNAL_CALCULATION'),
                draftEnabled:                      true }

@UI.headerInfo: { typeName:         'Accounts Class',
                  typeNamePlural:   'Accounts Classes',
                  title:            {value: 'AccountClassCodeForEdit' },
                  description:      {value: 'AccountClassCodeText'} }



define view /EY1/SAV_C_Acc_Class
  as select from /EY1/SAV_I_Acc_Class

  association [0..*] to /EY1/SAV_C_Acc_FS_Item        as _FinStatItem         on  $projection.AccountClassCode = _FinStatItem.AccountClassCode

  association [1..1] to /EY1/SAV_I_Acc_Class_Text     as _AccClassCodeText    on  $projection.AccountClassCode = _AccClassCodeText.AccountClassCode
                                                                              and _AccClassCodeText.Language   = $session.system_language
  association [1..1] to /EY1/SAV_I_TransactionType_VH as _TransactionTypeText on  $projection.DebitCreditIndicator = _TransactionTypeText.DebitCreditIndicatorDomVal
  association [1..1] to /EY1/SAV_I_AccType_VH         as _AccountTypeText     on  $projection.CurrentNonCurrent = _AccountTypeText.CurrentNonCurrentDomKey
  association [1..1] to /EY1/SAV_I_FSType_VH          as _FSTypeText          on  $projection.BsEqPl = _FSTypeText.BsEqPlDomKey
{
      @UI.facet:[ { id:              'AccountClassInfo',
                    type:            #COLLECTION,
                    position:        10,
                    label:           'Accounts Class' },

                  { type:            #FIELDGROUP_REFERENCE,
                    position:        10,
                    //label:         'Account Information',
                    targetQualifier: 'AccountInformation',
                    parentId:        'AccountClassInfo',
                    isSummary:       true,
                    isPartOfPreview: true },

                  { //id:             'FSItemData' ,
                    type:             #LINEITEM_REFERENCE ,
                    label:            'FS Items' ,
                    position:          20 ,
                    targetElement:    '_FinStatItem' } ]

      @ObjectModel.readOnly:true
      @UI.selectionField:   [{ position: 10 }]
      @UI.lineItem:         [{ position: 10 }]
      @ObjectModel.text.element: ['AccountClassCodeText']
      @Search:              { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
  key AccountClassCode,

      @UI.fieldGroup:            [{ qualifier: 'AccountInformation', position: 11,importance: #HIGH }]
      @ObjectModel:              { //readOnly:  false,
                                   enabled: true,
                                   mandatory: true }
      AccountClassCodeForEdit,

      //      @ObjectModel.readOnly: true
      //      @UI.hidden:            true
      @Search:               { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
      //Exposing field so it can be used as description in table
      //      _AccClassCodeText.AccountClassCodeText,

      @UI.fieldGroup: [{ qualifier: 'AccountInformation', position: 15,importance: #HIGH }]
      @ObjectModel:   { enabled: true,
                      mandatory: true }
      AccountClassCodeText,

      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 20 }]
      @UI.fieldGroup: [{ qualifier: 'AccountInformation', position: 20,importance: #HIGH}]
      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_AccType_VH',
                                                    element: 'CurrentNonCurrentDomKey' } }
      @ObjectModel.text.element: ['CurrentNonCurrentDomText']
      CurrentNonCurrent,

      @ObjectModel.readOnly:true
      @UI.hidden:           true
      //_CNCTypeVH.cnc_text,
      _AccountTypeText.CurrentNonCurrentDomText,

      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem:       [{ position: 30 }]
      @UI.fieldGroup:     [{ qualifier: 'AccountInformation', position: 30,importance: #HIGH }]

      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_FSType_VH',
                                                    element: 'BsEqPlDomKey' } }
      @ObjectModel.text.element: ['BsEqPlDomText']
      BsEqPl,

      @ObjectModel.readOnly:true
      @UI.hidden:           true
      _FSTypeText.BsEqPlDomText,


      @UI.lineItem:   [{ position: 40 }]
      @UI.fieldGroup: [{ qualifier: 'AccountInformation', position: 40,importance: #HIGH }]
      TaxEffected,

      @UI.lineItem:   [{ position: 50 }]
      @UI.fieldGroup: [{ qualifier: 'AccountInformation', position: 50,importance: #HIGH }]
      ProfitBeforeTax,

      @UI.selectionField:               [{ position: 60 }]
      @UI.lineItem:                     [{ position: 60 }]
      @UI.fieldGroup:                   [{ qualifier: 'AccountInformation', position: 60,importance: #HIGH }]
      @ObjectModel.text.element:        ['DebitCreditIndicatorDomText']
      @Consumption.valueHelpDefinition: { entity: { name:    '/EY1/SAV_I_TransactionType_VH',
                                                    element: 'DebitCreditIndicatorDomVal' } }
      @ObjectModel: { readOnly:  false,
                      enabled: true,
                      mandatory: true }
      DebitCreditIndicator,

      @ObjectModel.readOnly:true
      @UI.hidden: true
      //_SHTypeVH.sh_text,
      _TransactionTypeText.DebitCreditIndicatorDomText,

      @ObjectModel.association: { type: [#TO_COMPOSITION_CHILD] }
      _FinStatItem,

      _AccClassCodeText,

      //_SHTypeVH,
      _TransactionTypeText,

      //_CNCTypeVH,
      _AccountTypeText,

      _FSTypeText
}

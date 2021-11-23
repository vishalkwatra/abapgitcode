sap.ui.define(["./BaseController","sap/ui/model/json/JSONModel","../model/formatter","sap/ui/model/Filter","sap/ui/model/FilterOperator","sap/m/MessageToast","sap/m/MessageBox","sap/ui/core/ListItem"],function(e,t,n,i,o,r,a,s){"use strict";return e.exten+
d("ey.sap.fin.cs.deferredtaxrollfwd.controller.MainReport",{formatter:n,onInit:function(){this.oRouter=this.getOwnerComponent().getRouter();this.oRouter.getRoute("mainreport").attachMatched(this._onRouteMatched,this);this._fetchGlobalParameters();this._f+
etchAdjustmentReasons();this.getView().setModel(new t({results:[{key:"RGAAP",text:this.getI18nText("sBtnTextReportingGAAP")},{key:"SGAAP",text:this.getI18nText("sBtnTextStatutoryReporting")}]}),"modelReportingType")},_onRouteMatched:function(){this.getBu+
syDialog().close();this.oGlobalSmartTable=this.getView().byId("idTRFMainRepSmartTable");this.bTriggerDTRFService=true;this.oGlobalSmartTable.getTable().setFixedColumnCount(3)},_fetchGlobalParameters:function(){var e=this;var n={Default:true};var i=this.g+
etOwnerComponent().getModel();let o=new t;this.setModel(o,"viewConfigDataModel");i.callFunction("/GlobalParameter",{method:"GET",urlParameters:n,success:function(t){e.getView().getModel("viewConfigDataModel").setData({globalParameters:t});let n=e.getView+
().byId("idTRFMainRepSmartFilterBar");if(!n.getCurrentVariantId()){e._setFilterBarParameters(t)}},error:function(t){a.error(e.getI18nText("errorReadingGlobalParameters"))}})},_setFilterBarParameters:function(e){let t=this.getView(),i=t.byId("idCurrency")+
;if(e.ConsolidationUnit){t.byId("idConsUnit").setSelectedKey(e.ConsolidationUnit);i.setVisible(true);this._fetchCurrencyData(true);this.fetchReconLedgerData()}if(e.FiscalYear){let n=new Date("06/06/".concat(e.FiscalYear.toString()));t.byId("idFiscalYearF+
ilter").setDateValue(n)}if(e.Intention){t.byId("idIntentionComboBox").setSelectedKey(e.Intention)}var o=[e.ConsolidationUnit,e.FiscalYear];this._fetchIntentionStatus(o);if(e.PeriodFrom){t.byId("idPeriodFromInput").setValue(n.convertStringToInt(e.PeriodFr+
om))}if(e.PeriodTo){t.byId("idPeriodToInput").setValue(n.convertStringToInt(e.PeriodTo))}if(e.LocalCurrencyType&&e.LocalCurrency){i.setSelectedKey(e.LocalCurrency)}else{i.setSelectedKey(e.GroupCurrency)}if(e.ConsolidationUnit&&e.FiscalYear&&e.Intention){+
this._fetchValidTaxRates({ConsolidationUnit:e.ConsolidationUnit,PeriodTo:e.PeriodTo,FiscalYear:e.FiscalYear})}},_fetchAdjustmentReasons:function(){let e=this.getOwnerComponent().getModel();let t="/xEY1xSAV_C_Recon_Adj_Reason";let n=this;e.read(t,{method:+
"GET",success:function(e,t){var i=n.getModel("viewConfigDataModel");i.getData().adjustmentReason=e.results;i.refresh()},error:function(e){if(parseInt(e.statusCode,[10])!==404){r.show(n.getI18nText("adjReasonServiceCallError"))}}})},getI18nText:function(e+
){return this.getResourceBundle().getText(e)},_fetchCurrencyData:function(e){var n=this.getView(),r=n.byId("idConsUnit").getSelectedKey(),a=new i("ConsolidationUnit",o.EQ,r),s=this.getModel(),l=this,d=n.byId("idCurrType"),u=n.byId("idCurrency");d.setVisi+
ble(true);u.setBusy(true);s.read("/xEY1xSAV_C_CurrLocalGroupVH",{method:"GET",filters:[a],success:function(n,i){u.setBusy(false);l.setModel(new t(n),"currLocalGroupVHModel");if(!e&&n.results.length>0){u.setSelectedKey(n.results[0].Currency)}},error:funct+
ion(e){u.setBusy(false)}})},_fetchIntentionStatus:function(e){let n=this.getModel();let r=e[0],s=e[1],l="/xEY1xSAV_C_IntentionsStatus(p_bunit='"+r+"')/Set",d=new i("Gjahr",o.EQ,s),u=this,g=u.getView(),c=g.byId("idIntentionComboBox");this.getBusyDialog().+
open();n.read(l,{method:"GET",sorters:[new sap.ui.model.Sorter("SerialNumber")],filters:[d],success:function(e,n){u.getBusyDialog().close();if(e.results.length===0){c.setSelectedKey("");c.setEnabled(false);a.error(u.getI18nText("IntentionNotYetOpen")+s);+
return}c.setEnabled(true);let i=u.getView().getModel("viewConfigDataModel").getData().globalParameters;c.setSelectedKey(i.Intention);c.setSelectedKey("");for(let t=0;t<e.results.length;t++){if(e.results[t].isSelected==="X"){c.setSelectedKey(e.results[t].+
Intention)}}if(c.getSelectedKey()===""){for(let t=0;t<e.results.length;t++){if(e.results[t].status==="Open"){c.setSelectedKey(e.results[t].Intention)}}}let o=new t(e);u.getView().setModel(o,"intentionVHModel");u._managePeriodFieldsEditability(false)},err+
or:function(e){u.getBusyDialog().close();a.error(u.getI18nText("errorFetchingIntentionStatus"))}})},_managePeriodFieldsEditability:function(e){let t=this.getView(),i=t.byId("idIntentionComboBox");if(!e){i.setSelectedKey(i.getSelectedKey())}let o=i.getSel+
ectedItem(),r=o.getBindingContext("intentionVHModel").getObject();let a=t.byId("idPeriodToInput"),s=n.convertStringToInt(r.TaxIntention);if(s!==n.convertStringToInt(0)){this._manageIntentionStatus(r);a.setEditable(false);a.setValue(n.convertStringToInt(r+
.PeriodTo))}else{this._managePerodicIntentionStatus(r.PeriodTo);a.setEditable(true);a.setValue(n.convertStringToInt(r.CurrOpenPeriod))}},_manageIntentionStatus:function(e){let t=this;if(e.status===this.getI18nText("YetToOpen")){t.getBusyDialog().close();+
a.error(this.getModel("i18n").getResourceBundle().getText("ThisIntentionNotYetOpen",[e.IntentDescription,e.Gjahr]));return}else{return}},_managePerodicIntentionStatus:function(e){let t=this.getView().byId("idIntentionComboBox").getSelectedItem().getBindi+
ngContext("intentionVHModel").getObject(),n=parseInt(t.CurrOpenPeriod,[10]);if(e>n){this.getBusyDialog().close();a.error(this.getModel("i18n").getResourceBundle().getText("errorPeriodnotopen",[e,n]));return}else{return}},_createJournalEntriesFilterData:f+
unction(e){let t=e.getSource().getBindingContext();if(!t.getProperty("GLAccount")){return}let i=this.getModel("viewConfigDataModel").getData(),o=this.getView().byId("idFiscalYearFilter"),r=o.getDateValue().getFullYear(),a=parseInt(this.getView().byId("id+
PeriodFromInput").getValue(),[10]),s=parseInt(this.getView().byId("idPeriodToInput").getValue(),[10]),l=this.getView().byId("idConsUnit"),d=this.getView().byId("idCurrency"),u=this.getView().byId("idIntentionComboBox").getSelectedItem().getBindingContext+
("intentionVHModel").getObject(),g=n.convertStringToInt(u.PeriodTo)===0?"":n.convertStringToInt(u.TaxIntention),c=t.getProperty("GLAccount").padStart(10,"0"),h=[],f=false;let I=[],y=this.getView().byId("idTRFMainRepSegmentedBtn").getSelectedKey();if(y===+
"RGAAP"){I=[i.reconData.g2s,i.reconData.s2t]}else{I=[i.reconData.s2t]}let T=e.getSource().getCustomData();for(let e of T){let t=e.getValue();let n=e.getKey();if(n==="mappedAdjReason"){for(let e=0;e<i.adjustmentReason.length;e++){if(i.adjustmentReason[e].+
AdjustmentReason===t){h.push(i.adjustmentReason[e].TransType);break}}continue}if(n==="mappedIsOpeningBalanceEntry"){f=true}}let b=e.getSource().getBindingInfo("text").parts,C=b[b.map(e=>e.path.indexOf("MainCurrency")!==0).indexOf(true)].path;let p=this.s+
erviceDataProperty.property;p=p[p.map(e=>e.name).indexOf(C)];let m=p.extensions;m=m[m.map(e=>e.name).indexOf("label")];return{ConsolidationChartOfAccounts:i.globalParameters.ConsolidationChartofAccounts,FiscalYear:r,PeriodFrom:a,PeriodTo:s,ConsolidatioUn+
it:l.getSelectedKey(),ConsolidationLedger:I,FinancialTransactionType:h,Value:t.getProperty(C),Currency:t.getProperty("MainCurrency"),GLAccount:c,ConsolidationVersion:"",SelectedIntention:g,ConsolidationGroup:"",PeriodMode:"PER",RefConsolidationDocumentTy+
pe:"W",selectedCurrency:d.getSelectedKey(),SectionName:m.value,GLAccountDesc:t.getProperty("GLAccountMdmText"),bIsOpeningBalanceEntry:f}},_fetchValidTaxRates:function(e){e=e?e:{};let t=this,n=this.getView(),o=n.byId("idConsUnit").getSelectedKey(),s=n.byI+
d("idIntentionComboBox").getSelectedItem(),l=n.byId("idFiscalYearFilter").getDateValue(),d=this.getModel();if(!s){return}let u=e.ConsolidationUnit?e.ConsolidationUnit:o,g=e.PeriodTo?e.PeriodTo:s.getBindingContext("intentionVHModel").getObject().PeriodTo,+
c=e.FiscalYear?e.FiscalYear:l.getFullYear();if(!u||!g||!c){return}let h="/xEY1xSAV_C_Fetch_Tax_Rates(p_toperiod='"+g+"',p_ryear='"+c+"')/Set";d.read(h,{method:"GET",filters:[new i("ConsolidationUnit","EQ",u)],success:function(e){t.bTriggerDTRFService=tru+
e;if(e.results.length<1){a.error(t.getI18nText("errorTaxRatesNotMaintained"));t.bTriggerDTRFService=false}},error:function(e){r.show(t.getI18nText("warningFetchingTaxRates"));t.bTriggerDTRFService=false}})},onBeforeRebindTable:function(e){if(!this.bTrigg+
erDTRFService){let e="/xEY1xSAV_C_DeferredTaxRollFrwd(p_rbunit='GB02',p_toperiod='12',p_ryear='2999',p_taxintention='')/Results";this.oGlobalSmartTable.setTableBindingPath(e);a.error(this.getI18nText("errorTaxRatesNotMaintained"));return}let t=this.getVi+
ew(),n=t.getModel("viewConfigDataModel").getData();if(!n.globalParameters||!n.globalParameters.ConsolidationChartofAccounts||!n.globalParameters.ConsolidationGroup){a.error(this.getI18nText("errorMaintainGlobalParameter"));return}let r=t.byId("idConsUnit+
"),s=r.getSelectedKey(),l=t.byId("idCurrency"),d=l.getSelectedKey(),u=t.byId("idFiscalYearFilter"),g=u.getDateValue().getFullYear(),c=t.byId("idPeriodToInput"),h=parseInt(c.getValue(),[10]),f,I,y;if(t.byId("idIntentionComboBox").getEnabled()===false){a.e+
rror(this.getI18nText("IntentionNotYetOpen")+g);this.oGlobalSmartTable.setTableBindingPath("");return}let T=t.byId("idIntentionComboBox").getSelectedItem().getBindingContext("intentionVHModel"),b=T.getObject(),C=parseInt(b.CurrOpenPeriod,[10]);if(b.statu+
s===this.getI18nText("YetToOpen")){this.getBusyDialog().close();a.error(this.getModel("i18n").getResourceBundle().getText("ThisIntentionNotYetOpen",[b.IntentDescription,b.Gjahr]));this.oGlobalSmartTable.setTableBindingPath("");return}if(h>C){this.getBusy+
Dialog().close();a.error(this.getModel("i18n").getResourceBundle().getText("errorPeriodnotopen",[h,C]));this.oGlobalSmartTable.setTableBindingPath("");return}let p=parseInt(b.TaxIntention,[10]),m=p>12?p:b.TaxIntention,S=this.getView().byId("idTRFMainRepS+
egmentedBtn").getSelectedKey();f=new i({filters:[new i("ConsolidationUnit",o.EQ,s),new i("ConsolidationChartofAccounts",o.EQ,n.globalParameters.ConsolidationChartofAccounts),new i("MainCurrency",o.EQ,d),new i("ReportingType",o.EQ,S)],and:true});y=f;if(e.+
getParameter("bindingParams").filters.length>0){I=new i({filters:e.getParameter("bindingParams").filters});y=new i({filters:[f,I],and:true})}let x="/xEY1xSAV_C_DeferredTaxRollFrwd(p_rbunit='"+s+"',p_toperiod='"+h+"',p_ryear='"+g+"',p_taxintention='"+m+"'+
)/Results";this.oGlobalSmartTable.setTableBindingPath(x);let V=e.getParameter("bindingParams");V.filters=[y]},onBeforeVariantSaveFilterBar:function(e){let t=this.getView(),n=t.byId("idTRFMainRepSmartFilterBar"),i=t.byId("idConsUnit"),o=t.byId("idFiscalYe+
arFilter"),r=t.byId("idIntentionComboBox"),a=t.byId("idCurrency"),s=t.byId("idPeriodToInput");n.setFilterData({_CUSTOM:{ConsolidationUnit:i.getSelectedKey(),FiscalYear:o.getValue(),Intention:r.getSelectedKey(),CurrType:a.getSelectedKey(),PeriodTo:s.getVa+
lue(),VariantID:n.getCurrentVariantId()}})},onAfterVariantLoadFilterBar:function(e){var t=this.getView();var i=t.byId("idTRFMainRepSmartFilterBar");var o=t.byId("idConsUnit");var r=t.byId("idFiscalYearFilter");let a=t.byId("idIntentionComboBox");var s=t.+
byId("idCurrency");let l=this.getView().byId("idPeriodToInput");var d=i.getFilterData()["_CUSTOM"];o.setSelectedKey(d.ConsolidationUnit);r.setValue(d.FiscalYear);a.setSelectedKey(d.Intention);s.setSelectedKey(d.CurrType);l.setValue(n.convertStringToInt(d+
.PeriodTo));if(d.ConsolidationUnit){this.fetchReconLedgerData()}if(d.CurrType){s.setVisible(true);this._fetchCurrencyData(true)}if(d.ConsolidationUnit&&d.FiscalYear&&d.Intention){this._fetchValidTaxRates({ConsolidationUnit:d.ConsolidationUnit,PeriodTo:d.+
PeriodTo,FiscalYear:d.FiscalYear})}},onSearchButtonPressed:function(e){let t=this.getModel().getServiceMetadata().dataServices.schema[0].entityType;this.serviceDataProperty=t.find(e=>e.name==="xEY1xSAV_C_DeferredTaxRollFrwdResults")},onSearch:function(e)+
{if(e.getParameters().refreshButtonPressed){this.onRefresh()}else{var t=[];var n=e.getParameter("query");if(n&&n.length>0){t=[new i("GLAccount",o.Contains,n)]}this._applySearch(t)}},onDataReceivedSmartTable:function(e){this.getBusyDialog().open();this.oG+
lobalSmartTable.getTable().setVisibleRowCount(10);var t=window.setInterval(function(){this.onAdjustTableCol();window.clearInterval(t)}.bind(this),1e3)},onAdjustTableCol:function(){let e=this.oGlobalSmartTable;var t=e.getTable();var n=t.getColumns();for(v+
ar i=n.length-1;i>=0;i--){t.autoResizeColumn(i)}this.getBusyDialog().close()},onChangeDatePickerFilter:function(e){let t=e.getSource(),n=this.getModel("viewConfigDataModel").getData(),i=this.getView().byId("idConsUnit").getProperty("selectedKey");if(e.ge+
tParameter("valid")){t.setValueState("None");let e=t.getDateValue().getFullYear(),n=[i,e];this._fetchIntentionStatus(n)}else{t.setValueState("Error")}if(e.getSource().getValue()){this._fetchValidTaxRates()}},onConsUnitChange:function(e){this._fetchCurren+
cyData(false);this.fetchReconLedgerData();let t=e.getSource().getSelectedKey(),n=[t,this.getView().byId("idFiscalYearFilter").getDateValue().getFullYear()];this._fetchIntentionStatus(n);if(e.getSource().getValue()){this._fetchValidTaxRates()}},onChangeIn+
tentionComboBox:function(e){let t=this.getView(),n=t.byId("idIntentionComboBox"),i=n.getSelectedItem();if(!i){n.setSelectedItem("");return}this._managePeriodFieldsEditability(true);if(e.getSource().getValue()){this._fetchValidTaxRates()}},fetchReconLedge+
rData:function(){let e=this.getModel();let t=e.createKey("/xEY1xSAV_C_Recon_Ledger",{bunit:this.byId("idConsUnit").getSelectedKey()});let n=this;e.read(t,{method:"GET",success:function(e,t){var i=n.getModel("viewConfigDataModel");i.getData().reconData=e;+
i.refresh()},error:function(e){if(parseInt(e.statusCode,[10])!==404){r.show(n.getI18nText("reconServiceCallError"))}}})},onLiveChangePeriodTo:function(){let e=this.getView().byId("idPeriodToInput");let t=parseInt(this.getView().byId("idPeriodFromInput").+
getValue(),[10]);let n=parseInt(e.getValue(),[10]);e.setValueState("None");if(n<t){e.setValueState("Error");e.setValueStateText(this.getI18nText("periodToLessThanPeriodFromErrorMsg"));return}else if(n>"012"){e.setValueState("Error");e.setValueStateText(t+
his.getI18nText("periodToGreaterThanLastPeriod"));return}else{this._managePerodicIntentionStatus(n)}},onPressColumnMenuOpenGLAccount:function(e){let t=e.getParameter("menu").getPopup();t.attachOpened(function(e){let t=e.getSource().getContent().getAggreg+
ation("items");let n=t.map(e=>e.getId().toString().indexOf("menu-freeze")!==-1).indexOf(true);t[n].setEnabled(false)})},onPressTRFEntryDetails:function(e){var n=this._createJournalEntriesFilterData(e);if(!n){return}var i=new t(n);this.getOwnerComponent()+
.setModel(i,"JournalEntryData");this.oRouter.navTo("JournalEntries")},onChangeButtonReportingType:function(e){let t=this.getView().byId("idTRFMainRepSmartFilterBar");if(t.validateMandatoryFields()){t.fireSearch()}}})});                                    
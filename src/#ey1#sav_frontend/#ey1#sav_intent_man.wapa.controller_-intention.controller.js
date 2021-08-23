sap.ui.define(["./BaseController","sap/ui/model/json/JSONModel","sap/m/MessageToast","sap/m/MessageBox","sap/ui/model/Filter","sap/ui/model/FilterOperator","sap/ui/core/routing/History","sap/ui/generic/app/navigation/service/NavigationHandler"],function(+
e,t,n,i,o,s,r,l){"use strict";let a=sap.ui.getCore();return e.extend("ey.sap.fin.cs.intentionmanagement.controller.intention",{onInit:function(){let e=this.getView();this.oRouter=this.getOwnerComponent().getRouter();this.oRouter.getRoute("Targetintention+
").attachMatched(this._onRouteMatched,this);this.bAllEntriesValidated=true;let n=new t;this.setModel(n,"oRowModel");let i=new t;this.setModel(i,"oModelEditItentn")},_onRouteMatched:function(e){this._getAuthData()},_setOriginalIntentionData:function(e){le+
t n=jQuery.extend(true,[],e.results);n.map(e=>delete e.__metadata);this.getView().setModel(new t(n),"modelOriginalIntentionData")},_getOriginalIntentionData:function(){return this.getView().getModel("modelOriginalIntentionData")},_getAuthData:function(){+
let e=this,n=this.getOwnerComponent().getModel();this.getBusyDialog().open();n.read("/AUTHSet",{method:"GET",success:function(n){e.getBusyDialog().close();e.getView().setModel(new t(n.results[0]),"authModel");console.log(n)},error:function(t){e.getBusyDi+
alog().close();i.error(e.getI18nText("errorFetchingAuthData"))}})},_fetchIntentionsData:function(){let e=this.getView(),n=this.getOwnerComponent().getModel(),r=e.byId("idIntentionsTable"),l=e.byId("idAddIntentBtn"),a=this,d,g=e.byId("idConsUnit").getSele+
ctedKey(),I=[new o("Bunit",s.EQ,g)];if(e.byId("idSmartFilterBar").getFilters().length>0){d=e.byId("idSmartFilterBar").getFilters()[0].aFilters}else{d=[]}let u=new o({filters:[...I,...d],and:true});this.getBusyDialog().open();l.setEnabled(true);n.read("/I+
ntentionsSet",{filters:[u],method:"GET",success:function(e){a.getBusyDialog().close();console.log(e);e.results.map(e=>e.bCreated=false);r.setModel(new t(e),"intentionsTableModel");r.getModel("intentionsTableModel").setDefaultBindingMode("TwoWay");a.getVi+
ew().byId("idHeadText").setText(a.getResourceBundle().getText("intentionsTableTitle",[e.results.length]));a._setOriginalIntentionData(e)},error:function(e){a.getBusyDialog().close();i.error(a.getI18nText("IntentionGetServiceCallError"))}})},_disableClose+
dFI:function(e){let t=this.getView(),n=t.byId("idIntentionsTable");n.getItems().forEach(function(e){let t=e.getBindingContext("intentionsTableModel").getObject(),n=t.IntnsnActFlg,i=e.$().find(".sapMRb"),o=sap.ui.getCore().byId(i.attr("id"));if(n){o.setEn+
abled(false);o.setEditable(false)}else{o.setEnabled(true);o.setEditable(true)}})},_fetchIntentionEditCB:function(e,t,i){let r=this.getModel(),l="/IntentionValuesSet",a=this,d=this.getView(),g=new o({filters:[new o("Gjahr",s.EQ,e),new o("Intention",s.EQ,t+
),new o("PeriodTo",s.EQ,i)],and:true});this.getBusyDialog().open();r.read(l,{method:"GET",filters:[g],success:function(e,t){a.getBusyDialog().close();a.getModel("oModelEditItentn").setData([]);a.getModel("oModelEditItentn").setData(e.results)},error:func+
tion(e){a.getBusyDialog().close();n.show(a.getI18nText("errorFetchingIntentions"))}})},_setScreenToDisplayMode:function(){let e=this.getView();this._fetchIntentionsData();e.byId("idOverflowToolbar").setVisible(false);e.byId("idAddIntentBtn").setEnabled(t+
rue)},_getValidDataMsg:function(e){let t="";for(let n=0;n<e.length;n++){if(e[n]<10){if(n===e.length-1){t=t+" 00"+e[n]}else{t=t+" 00"+e[n]+","}}else{if(n===e.length-1){t=t+" 0"+e[n]}else{t=t+" 0"+e[n]+","}}}return t},getI18nText:function(e){return this.ge+
tResourceBundle().getText(e)},onConsUnitChange:function(){let e=this.getView().byId("idSmartFilterBar"),t=e.validateMandatoryFields();if(t){e.fireSearch()}},onPressEditToggleBtn:function(e){let t=this.getView(),n=this;if(!this._oEditIntentionFragment){th+
is._oEditIntentionFragment=sap.ui.xmlfragment("editIntention","ey.sap.fin.cs.intentionmanagement.fragment.editIntentionPopup",this);t.addDependent(this._oEditIntentionFragment)}this._oEditIntentionFragment.open();if(e.getSource().getTooltip()==="Edit Int+
ention"){a.byId("editIntention--idOkBtn").setText(n.getI18nText("updateIntentBtnText"));a.byId("editIntention--idTitleDialg").setText(n.getI18nText("editIntentionsDialogTitle"))}else{a.byId("editIntention--idOkBtn").setText(n.getI18nText("addIntentBtnTex+
t"));a.byId("editIntention--idTitleDialg").setText(n.getI18nText("addIntentionsDialogTitle"))}t.byId("idOverflowToolbar").setVisible(true)},onChangeIntentionEdit:function(e){let t=a.byId("editIntention--IdPerTo"),n=a.byId("editIntention--errorMsgStripId"+
);n.setVisible(false);a.byId("editIntention--idDialog").setContentHeight("190px");t.setValueState("None");if(e.getSource().getSelectedItem()){e.getSource().setValueState("None");let n=e.getSource().getSelectedItem().getBindingContext("oModelEditItentn").+
getObject();if(e.getSource().getSelectedKey()==="01"){t.setValue("");t.setEditable(true)}else{t.setValue(n.PeriodTo);t.setEditable(false)}}else{e.getSource().setValueState("Error");t.setValue("");t.setEditable(false)}},onChangePeriodTo:function(e){let t=+
parseInt(e.getSource().getValue(),[10]),n=this.getModel("oRowModel").getData().validate,i=a.byId("editIntention--errorMsgStripId"),o=this,s=this._getValidDataMsg(n);if(n.indexOf(t)>-1){i.setVisible(false);a.byId("editIntention--idDialog").setContentHeigh+
t("190px");e.getSource().setValueState("None")}else{i.setVisible(true);i.setText(o.getI18nText("errorMsgPeriodTo")+s);a.byId("editIntention--idDialog").setContentHeight("250px");e.getSource().setValueState("Error")}},onChangeYear:function(e){let t=this.g+
etView(),n=this.getView().byId("idIntentionsTable").getModel("intentionsTableModel").getData().results,i=this;t.byId("idOverflowToolbar").setVisible(true);if(!e.getSource().getValue()){e.getSource().setValueState("Error");return}let o=n.filter(t=>t.Gjahr+
===e.getSource().getValue());if(o.length>0){e.getSource().setValueState("Error");e.getSource().setValueStateText(i.getI18nText("errorMsgInvalidYear"))}else{e.getSource().setValueState("None");e.getSource().setValueStateText("")}},onPressCloseDialog:funct+
ion(){let e=this.getView();this._oEditIntentionFragment.close();e.byId("idIntentionsTable").removeSelections();e.byId("idEditToggleBtn").setEnabled(false);this._oEditIntentionFragment.destroy();this._oEditIntentionFragment=undefined},onPressSaveBtnIntent+
ion:function(){let e=this.getView(),t=e.byId("idIntentionsTable").getModel("intentionsTableModel"),n=e.getModel("oModelEditItentn").getData(),i=this.getModel("oRowModel").getData().validate,o=a.byId("editIntention--cbIntenId"),s=o.getSelectedKey(),r=a.by+
Id("editIntention--IdPerTo"),l=r.getValue(),d=a.byId("editIntention--IdFisYr"),g=d.getValue(),I=a.byId("editIntention--errorMsgStripId"),u=this._getValidDataMsg(i),h=this;if(!g){d.setValueState("Error")}else if(!s){o.setValueState("Error")}else if(!l){r.+
setValueState("Error");I.setVisible(true);I.setText(h.getI18nText("errorMsgPeriodTo")+u);a.byId("editIntention--idDialog").setContentHeight("250px")}if(d.getValueState()==="Error"||o.getValueState()==="Error"||r.getValueState()==="Error"){this.bAllEntrie+
sValidated=false;return}this.bAllEntriesValidated=true;e.byId("idIntentionsTable").removeSelections();e.byId("idEditToggleBtn").setEnabled(false);let c=this.getModel("oRowModel").getData(),b=parseInt(c.PeriodTo,[10]),f=n.filter(e=>e.SerialNumber===c.Seqn+
rFlb);if(b<10){b="00"+b}else{b="0"+b}if(c.sPath){t.setProperty(c.sPath+"/SeqnrFlb",c.SeqnrFlb);t.setProperty(c.sPath+"/PeriodTo",b);t.setProperty(c.sPath+"/Intention",f[0].Intention);t.setProperty(c.sPath+"/Intdesc",f[0].Description)}else{let e=t.getData+
().results;c.PeriodTo=b;c.Intention=f[0].Intention;c.Intdesc=f[0].Description;e.push(c)}t.refresh();this._oEditIntentionFragment.close();this._oEditIntentionFragment.destroy();this._oEditIntentionFragment=undefined},onPressAddIntetion:function(e){let t=t+
his.getView().byId("idConsUnit"),n={Bunit:t.getSelectedKey(),Gjahr:"",Intention:"",Intdesc:"",CreatedBy:"",CreatedOn:"",ChangedBy:"",ChangedOn:"",PeriodTo:"",IntnsnActFlg:false,IsActive:false,Closebtnact:false,SeqnrFlb:"",editYr:true,editPer:false,sPath:+
"",bCreated:true},i=[],o=[{SerialNumber:"01",Intention:"PER",Description:"Periodic",PeriodTo:"000"},{SerialNumber:"02",Intention:"Q1",Description:"Q1 Close",PeriodTo:"003"}];i.push(1);i.push(2);n.validate=i;this.getModel("oRowModel").setData(n);this.getM+
odel("oModelEditItentn").setData([]);this.getModel("oModelEditItentn").setData(o);this.onPressEditToggleBtn(e)},onSearchButtonPressed:function(){this._fetchIntentionsData()},onItemSelected:function(e){let t=this.getView(),n=this,i=t.byId("idEditToggleBtn+
"),o=e.getSource().getSelectedItem().getBindingContext("intentionsTableModel").getPath(),s=o.split("/"),r=parseInt(s[2],[10]),l=e.getSource().getSelectedItem().getBindingContext("intentionsTableModel").getObject(),a,d,g=[],I={};if(l.IsActive){t.byId("idI+
ntentionsTable").removeSelections();i.setEnabled(false);return}if(l.Closebtnact){t.byId("idCloseIntentBtn").setVisible(true)}else{t.byId("idCloseIntentBtn").setVisible(false)}if(l.SeqnrFlb=="01"){d=true}else{d=false}if(l.bCreated){i.setEnabled(false);ret+
urn}else{i.setEnabled(true)}let u=this._getOriginalIntentionData().getData()[r],h=parseInt(u.SeqnrFlb,[10]);I.Gjahr=u.Gjahr;I.Intention=u.Intention;I.PeriodTo=l.PeriodTo;I.SeqnrFlb=l.SeqnrFlb;I.editPer=d;I.sPath=o;I.editYr=false;this.getModel("oRowModel"+
).setData(I);if(u.SeqnrFlb==="02"||u.SeqnrFlb==="03"||u.SeqnrFlb==="04"){g.push(parseInt(u.PeriodTo,[10])+1);g.push(parseInt(u.PeriodTo,[10])+2)}else if(u.SeqnrFlb==="01"){if(u.PeriodTo==="001"){g.push(1);g.push(2)}else if(u.PeriodTo==="002"){g.push(2)}e+
lse if(u.PeriodTo==="004"){g.push(4);g.push(5)}else if(u.PeriodTo==="005"){g.push(5)}else if(u.PeriodTo==="007"){g.push(7);g.push(8)}else if(u.PeriodTo==="008"){g.push(8)}else if(u.PeriodTo==="010"){g.push(10);g.push(11)}else if(u.PeriodTo==="011"){g.pus+
h(11)}}I.validate=g;this._fetchIntentionEditCB(I.Gjahr,I.Intention,I.PeriodTo)},onPressSaveIntention:function(){if(!this.bAllEntriesValidated){i.error(this.getI18nText("errorMsgInvalidTableData"));return}let e=this.getOwnerComponent(),t=e.getModel(),o=th+
is,s=this.getView().byId("idIntentionsTable").getModel("intentionsTableModel").getData().results,r=jQuery.extend(true,[],this._getOriginalIntentionData().getData());r.map(e=>{delete e.bCreated;return e});s.map(e=>{delete e.bCreated;delete e.editPer;delet+
e e.editYr;delete e.sPath;delete e.validate;return e});t.setUseBatch(true);t.setChangeGroups({"/SAV_MANAGE_INTENTIONS_SRV":{groupId:"groupIdSaveIntention",changeSetId:"ID",single:false}});t.setDeferredGroups(t.getDeferredGroups().concat(["groupIdSaveInte+
ntion"]));if(s.length>r.length){let e=s.filter(e=>r.filter(t=>parseInt(t.Gjahr,[10])===parseInt(e.Gjahr,[10])&&t.Bunit===e.Bunit&&(t.Intention!==e.Intention||t.IntnsnActFlg!==e.IntnsnActFlg||parseInt(t.PeriodTo,[10])!==parseInt(e.PeriodTo,[10])||parseInt+
(t.SeqnrFlb,[10])!==parseInt(e.SeqnrFlb,[10]))).length>0);let n=s.filter(e=>r.filter(t=>parseInt(t.Gjahr,[10])===parseInt(e.Gjahr,[10])&&t.Bunit===e.Bunit).length===0);if(e.length>0){for(var l=0;l<e.length;l++){let n="/IntentionsSet(Gjahr='"+e[l].Gjahr+"+
',Bunit='"+e[l].Bunit+"')";delete e[l].ChangedBy;delete e[l].ChangedOn;delete e[l].CreatedBy;delete e[l].CreatedOn;t.update(n,e[l],{groupId:"groupIdSaveIntention"})}}if(n.length>0){for(var a=0;a<n.length;a++){delete n[a].ChangedBy;delete n[a].ChangedOn;d+
elete n[a].CreatedBy;delete n[a].CreatedOn;t.create("/IntentionsSet",n[a],{groupId:"groupIdSaveIntention"})}}}else if(s.length===r.length){for(var l=0;l<s.length;l++){for(var d=0;d<r.length;d++){if(s[l].Gjahr===r[d].Gjahr&&(s[l].IntnsnActFlg!==r[d].Intns+
nActFlg||s[l].Intention!==r[d].Intention||s[l].PeriodTo!==r[d].PeriodTo||s[l].SeqnrFlb!==r[d].SeqnrFlb)){t.update("/IntentionsSet(Gjahr='"+s[l].Gjahr+"',Bunit='"+s[l].Bunit+"')",s[l],{groupId:"groupIdSaveIntention"})}}}}else{return}t.submitChanges({group+
Id:"groupIdSaveIntention",success:function(e,t){let i;if(!e.__batchResponses){o._setScreenToDisplayMode();return}i=e.__batchResponses[0].__changeResponses;if(!i||i.length<=0){o._setScreenToDisplayMode();return}o._setScreenToDisplayMode();let s=JSON.parse+
(i.find(e=>e.headers["sap-message"]).headers["sap-message"]);if(s&&s.severity.toUpperCase()==="SUCCESS"){n.show(o.getI18nText("genericMsgBatchSuccess"));o._setScreenToDisplayMode()}else if(s&&s.message){n.show(o.getI18nText("genericMsgBatchError"))}},err+
or:function(e){o._setScreenToDisplayMode()}})},onPressCancelIntention:function(e){let t=this.getView(),n=this,i=t.byId("idIntentionsTable");i.getModel("intentionsTableModel").setData({results:jQuery.extend(true,[],this._getOriginalIntentionData().getData+
())});t.byId("idIntentionsTable").removeSelections();t.byId("idOverflowToolbar").setVisible(false);t.byId("idAddIntentBtn").setEnabled(true)},onPressCloseFY:function(e){let t=this.getView(),n=t.byId("idIntentionsTable").getSelectedItem().getBindingContex+
t("intentionsTableModel").getObject();t.byId("idOverflowToolbar").setVisible(true);n.IntnsnActFlg=true}})});                                                                                                                                                   
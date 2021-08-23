sap.ui.define(["./BaseController","sap/ui/model/json/JSONModel","sap/ui/core/mvc/Controller","sap/ui/model/Filter","sap/ui/model/FilterOperator","sap/m/MessageBox","sap/m/MessageToast","../model/formatter"],function(e,t,n,o,i,r,s,a){"use strict";return e+
.extend("ey.sap.fin.cs.temporaryrollfwd.controller.JournalEntries",{formatter:a,onInit:function(){this._oSmartTable=this.getView().byId("idJournalEntriesTable");this.oRouter=this.getOwnerComponent().getRouter();this.oRouter.getRoute("JournalEntries").att+
achMatched(this._onRouteMatched,this)},_onRouteMatched:function(){let e=this.getModel("JournalEntryData"),n=sap.ui.getCore().getModel("viewCnlVersionModel").getData().ConsolidationVersion.results,o=[],i=e.getProperty("/ConsolidationLedger"),r=e.getData()+
.ReportingType,s=this,a=[];if(i.length>1){for(let e=0;e<i.length;e++){for(let t=0;t<n.length;t++){if(n[t].ConsolidationLedger===i[e]){a.push(n[t])}}}}else{a=n.filter(e=>e.ConsolidationLedger===i[0])}let l=[],g=[];if(r==="RGAAP"){for(let e=0;e<a.length;e++
+){if(a[e].ConsolidationLedger===i[0]){l.push(a[e])}if(a[e].ConsolidationLedger===i[1]){g.push(a[e])}}o.push(l[0]);o.push(g[0])}else{o=[a[0]]}s.getOwnerComponent().setModel(new t(o),"ledgerVersionModel");s.bIsMessageBoxOpen=false;s.bTableRefresh=false;if+
(e&&e.getData()){s._oSmartTable.rebindTable()}else{let e=s.getRouter();s.getBusyDialog().open();e.navTo("mainreport",{},true)}},_onAdjustJECol:function(){var e=this.getView().byId("idJournalEntriesTable").getTable();var t=e.getColumns();for(var n=t.lengt+
h-1;n>=0;n--){e.autoResizeColumn(n)}this.getBusyDialog().close()},_findTableSumRow:function(){let e=this.getView().byId("idJournalEntriesTable");let t=e.getTable();let n=t.getRows();let o=t.getVisibleRowCount();if(!n[o-1]||!n[o-1].getBindingContext()){fo+
r(let e=0;e<n.length+1;e++){if(!n[e].getBindingContext()){return e-1}}}return o-1},_findTableSumRowData:function(e){let t=this.getView().byId("idJournalEntriesTable").getTable();let n;if(t.getRows()[e]&&t.getRows()[e].getBindingContext()){let o=t.getRows+
()[e].getBindingContext().sPath;n=t.getModel().getProperty(o)}return n},_compareSyncedValues:function(e,t){let n=this.getModel("JournalEntryData").getData();let o=this.getView().byId("idJEValueHeader");if(e&&e.LocalCurrency!==n.selectedCurrency&&!e.Amoun+
tInLocalCurrency||e&&e.GroupCurrency!==n.selectedCurrency&&!e.AmountInGroupCurrency){s.show(this.getResourceBundle().getText("errorCurrencyColumnNotSelected"));return}if(e&&n.selectedCurrency===e.LocalCurrency&&parseInt(n.Value,[10])!==parseInt(e.AmountI+
nLocalCurrency,[10])||e&&n.selectedCurrency===e.GroupCurrency&&parseInt(n.Value,[10])!==parseInt(e.AmountInGroupCurrency,[10])){o.setState("Warning");if(!this.bIsMessageBoxOpen){this._initializeWarningMessageBox(t)}}else{o.setState("Success")}},_initiali+
zeWarningMessageBox:function(e){this.bIsMessageBoxOpen=true;let t=this;r.warning(this.getResourceBundle().getText("errorMsgSumValueDiffTableSync"),{actions:[r.Action.OK],onClose:function(e){t.bIsMessageBoxOpen=false}})},onBeforeRebindJournalEntries:funct+
ion(e){this.getView().byId("idJETaxIntentionDesc").setVisible(true);let t=this.getView().getModel("JournalEntryData"),n=e.getParameter("bindingParams").filters,r;let s=i.EQ;if(t.getProperty("/bIsOpeningBalanceEntry")){s=i.LT}let a=[new o("ConsolidationGr+
oup",i.EQ,t.getProperty("/ConsolidationGroup")),new o("GLAccount",i.EQ,t.getProperty("/GLAccount")),new o("PeriodMode",i.EQ,t.getProperty("/PeriodMode")),new o("FiscalPeriod",i.BT,t.getProperty("/PeriodFrom"),t.getProperty("/PeriodTo")),new o("FiscalYear+
",s,t.getProperty("/FiscalYear")),new o("RefConsolidationDocumentType",i.EQ,t.getProperty("/RefConsolidationDocumentType")),new o("CompanyCode",i.EQ,t.getProperty("/ConsolidatioUnit"))];if(t.getProperty("/SelectedIntention")){a.push(new o("TaxIntention",+
i.LE,t.getProperty("/SelectedIntention")))}else{a.push(new o("TaxIntention",i.EQ,""))}if(n.length>0){a=[...a,...n]}let l=new o({filters:a,and:true});let g=[];let d=this.getOwnerComponent().getModel("reconLedgerModel").getData(),u=this.getOwnerComponent()+
.getModel("ledgerVersionModel").getData(),c,p,f;for(var h=0;h<u.length;h++){if(d.s2t===u[h].ConsolidationLedger){c=u[h].ConsolidationVersion}if(d.g2s===u[h].ConsolidationLedger){p=u[h].ConsolidationVersion}}f=new o({filters:[new o("ConsolidationLedger",i+
.EQ,d.s2t),new o("LedgerGroup",i.NE,"G2S"),new o("ConsolidationVersion",i.EQ,c)],and:true});if(t.getProperty("/ReportingType")==="RGAAP"){let e=new o({filters:[new o("ConsolidationLedger",i.EQ,d.g2s),new o("ConsolidationVersion",i.EQ,p)],and:true});g=new+
 o({filters:[e,f]})}else{g=new o({filters:[f]})}r=[l,g];let C=t.getProperty("/FinancialTransactionType"),y=[],w=[];if(C.length>0){for(let e=0;e<C.length;e++){w.push(new o("FinancialTransactionType",i.EQ,C[e]))}y=new o({filters:w});r=new o({filters:[l,g,y+
],and:true})}var m=encodeURIComponent("datetime'2018-12-31T00:00:00'");var b="/xEY1xSAV_C_CnsldtnJrnlEntry(P_ConsolidationUnitHierarchy='$',P_ConsolidationPrftCtrHier='$',P_ConsolidationSegmentHier='$',P_KeyDate="+m+")/Results";this.getView().byId("idJou+
rnalEntriesTable").setTableBindingPath(b);var T=e.getParameter("bindingParams");T.filters=[r]},onPressConsDoc:function(e){let t=e.getSource().getBindingContext(),n=t.getProperty("RefConsolidationDocumentNumber"),o=t.getProperty("CompanyCode"),i=o;while(i+
.length<4){i="0"+i}var r=this.getView().getModel("JournalEntryData").getProperty("/FiscalYear");var s={AccountingDocument:n,CompanyCode:i,FiscalYear:r};this.performCrossAppNavigation("AccountingDocument","manage",true,s)},onJEntriesDataReceived:function(+
e){this.getBusyDialog().open();let t=this.getView(),n=t.byId("idJETaxIntentionDesc"),o=t.byId("idJETaxIntention");var i=window.setInterval(function(e){this._onAdjustJECol();this._compareSyncedValues(this._findTableSumRowData(this._findTableSumRow()),this+
.bTableRefresh);if(o.getGrouped()){n.setVisible(true)}else{n.setVisible(false)}window.clearInterval(i)}.bind(this),1e3)},onPressJEDataSync:function(e){this.bTableRefresh=true;this._oSmartTable.rebindTable()}})});                                           
sap.ui.define(["sap/ui/core/mvc/Controller","sap/ui/core/UIComponent","sap/m/library"],function(e,t,r){"use strict";var n=r.URLHelper;return e.extend("ey.sap.fin.cs.DtrfHierarchyReport.controller.BaseController",{getRouter:function(){return t.getRouterFo+
r(this)},getModel:function(e){return this.getView().getModel(e)},setModel:function(e,t){return this.getView().setModel(e,t)},getResourceBundle:function(){return this.getOwnerComponent().getModel("i18n").getResourceBundle()},getBusyDialog:function(){var e+
=this.getView().getParent();var t=this.getOwnerComponent();if(!t._oBusyDialog){t._oBusyDialog=sap.ui.xmlfragment("hierarchyBusyDialog","ey.sap.fin.cs.hierarchyReportDTRF.fragment.BusyDialog",this);e.addDependent(t._oBusyDialog)}return t._oBusyDialog},onS+
hareEmailPress:function(){var e=this.getModel("objectView")||this.getModel("worklistView");n.triggerEmail(null,e.getProperty("/shareSendEmailSubject"),e.getProperty("/shareSendEmailMessage"))},addHistoryEntry:function(){var e=[];return function(t,r){if(r+
){e=[]}var n=e.some(function(e){return e.intent===t.intent});if(!n){e.push(t);this.getOwnerComponent().getService("ShellUIService").then(function(t){t.setHierarchy(e)})}}}()})});                                                                             
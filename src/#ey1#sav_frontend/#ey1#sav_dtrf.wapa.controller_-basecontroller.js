sap.ui.define(["sap/ui/core/mvc/Controller","sap/ui/core/UIComponent","sap/m/library","sap/m/MessageToast"],function(e,t,r,n){"use strict";var i=r.URLHelper;var o=null;return e.extend("ey.sap.fin.cs.deferredtaxrollfwd.controller.BaseController",{getRoute+
r:function(){return t.getRouterFor(this)},getModel:function(e){return this.getView().getModel(e)},setModel:function(e,t){return this.getView().setModel(e,t)},getResourceBundle:function(){return this.getOwnerComponent().getModel("i18n").getResourceBundle(+
)},setFilterBar:function(e){o=e},getFilterBar:function(){return o},getBusyDialog:function(){var e=this.getView().getParent();var t=this.getOwnerComponent();if(!t._oBusyDialog){t._oBusyDialog=sap.ui.xmlfragment("trfBusyDialog","ey.sap.fin.cs.deferredtaxro+
llfwd.fragment.BusyDialog",this);e.addDependent(t._oBusyDialog)}return t._oBusyDialog},performCrossAppNavigation:function(e,t,r,i){var o=sap.ushell.Container.getService("CrossApplicationNavigation");var a=this;var s=e+"-"+t;i=i||{};o.isIntentSupported([s+
]).done(function(e){}).fail(function(e){n.show(a.getResourceBundle().getText("invalidIntentNavigation"))});var l=o&&o.hrefForExternal({target:{semanticObject:e,action:t},params:i})||"";var u=window.location.href.split("#")[0]+l;sap.m.URLHelper.redirect(u+
,r)},onShareEmailPress:function(){var e=this.getModel("objectView")||this.getModel("worklistView");i.triggerEmail(null,e.getProperty("/shareSendEmailSubject"),e.getProperty("/shareSendEmailMessage"))},addHistoryEntry:function(){var e=[];return function(t+
,r){if(r){e=[]}var n=e.some(function(e){return e.intent===t.intent});if(!n){e.push(t);this.getOwnerComponent().getService("ShellUIService").then(function(t){t.setHierarchy(e)})}}}()})});                                                                     
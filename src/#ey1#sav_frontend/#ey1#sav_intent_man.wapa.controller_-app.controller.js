sap.ui.define(["./BaseController","sap/ui/model/json/JSONModel"],function(e,t){"use strict";return e.extend("ey.sap.fin.cs.intentionmanagement.controller.App",{onInit:function(){var e,n,a=this.getView().getBusyIndicatorDelay();e=new t({busy:true,delay:0}+
);this.setModel(e,"appView");n=function(){e.setProperty("/busy",false);e.setProperty("/delay",a)};this.getOwnerComponent().getModel().metadataLoaded().then(n);this.getOwnerComponent().getModel().attachMetadataFailed(n);this.getView().addStyleClass(this.g+
etOwnerComponent().getContentDensityClass())}})});                                                                                                                                                                                                             
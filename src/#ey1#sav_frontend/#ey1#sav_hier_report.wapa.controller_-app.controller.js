sap.ui.define(["./BaseController","sap/ui/model/json/JSONModel"],function(e,t){"use strict";return e.extend("ey.sap.fin.cs.hierarchyReport.controller.App",{onInit:function(){var e,n,o=this.getView().getBusyIndicatorDelay();e=new t({busy:true,delay:0});th+
is.setModel(e,"appView");n=function(){e.setProperty("/busy",false);e.setProperty("/delay",o)};this.getOwnerComponent().getModel().metadataLoaded().then(n);this.getOwnerComponent().getModel().attachMetadataFailed(n);this.getView().addStyleClass(this.getOw+
nerComponent().getContentDensityClass())}})});                                                                                                                                                                                                                 
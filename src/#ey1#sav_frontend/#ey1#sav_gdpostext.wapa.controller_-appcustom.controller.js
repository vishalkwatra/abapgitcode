sap.ui.define(["fin/gl/documentpost/controller/BaseController","sap/ui/model/json/JSONModel"],function(e,t){"use strict";return sap.ui.controller("fin.gl.documentpost.FIN_GLDOCPOSTExtension.controller.AppCustom",{onInit:function(){var e,n,o=this.getView(+
).getBusyIndicatorDelay();e=new t({busy:true,delay:0});this.setModel(e,"appView");n=function(){e.setProperty("/busy",false);e.setProperty("/delay",o)};this.getOwnerComponent().getModel().metadataLoaded().then(n,n);this.getView().addStyleClass(this.getOwn+
erComponent().getContentDensityClass())}})});                                                                                                                                                                                                                  
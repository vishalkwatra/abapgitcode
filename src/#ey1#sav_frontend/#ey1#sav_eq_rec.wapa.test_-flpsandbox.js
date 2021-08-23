sap.ui.define(["sap/base/util/ObjectPath","sap/ushell/services/Container"],function(i){"use strict";i.set(["sap-ushell-config"],{defaultRenderer:"fiori2",bootstrapPlugins:{RuntimeAuthoringPlugin:{component:"sap.ushell.plugins.rta",config:{validateAppVers+
ion:false}},PersonalizePlugin:{component:"sap.ushell.plugins.rta-personalize",config:{validateAppVersion:false}}},renderers:{fiori2:{componentData:{config:{enableSearch:false,rootIntent:"Shell-home"}}}},services:{LaunchPage:{adapter:{config:{groups:[{til+
es:[{tileType:"sap.ushell.ui.tile.StaticTile",properties:{title:"Equity Reconciliation",targetURL:"#EquityReconciliation-display"}}]}]}}},ClientSideTargetResolution:{adapter:{config:{inbounds:{"EquityReconciliation-display":{semanticObject:"EquityReconci+
liation",action:"display",title:"Equity Reconciliation",signature:{parameters:{}},resolutionResult:{applicationType:"SAPUI5",additionalInformation:"SAPUI5.Component=ey.sap.fin.cs.equityreconciliation",url:sap.ui.require.toUrl("ey/sap/fin/cs/equityreconci+
liation")}}}}}},NavTargetResolution:{config:{enableClientSideTargetResolution:true}}}});var e={init:function(){if(!this._oBootstrapFinished){this._oBootstrapFinished=sap.ushell.bootstrap("local");this._oBootstrapFinished.then(function(){sap.ushell.Contai+
ner.createRenderer().placeAt("content")})}return this._oBootstrapFinished}};return e});                                                                                                                                                                        
sap.ui.define(["sap/base/util/ObjectPath","sap/ushell/services/Container"],function(e){"use strict";e.set(["sap-ushell-config"],{defaultRenderer:"fiori2",bootstrapPlugins:{RuntimeAuthoringPlugin:{component:"sap.ushell.plugins.rta",config:{validateAppVers+
ion:false}},PersonalizePlugin:{component:"sap.ushell.plugins.rta-personalize",config:{validateAppVersion:false}}},renderers:{fiori2:{componentData:{config:{enableSearch:false,rootIntent:"Shell-home"}}}},services:{LaunchPage:{adapter:{config:{groups:[{til+
es:[{tileType:"sap.ushell.ui.tile.StaticTile",properties:{title:"Hierarchy Report DTRF",targetURL:"#HierarchyAnalysisDtrf-display"}}]}]}}},ClientSideTargetResolution:{adapter:{config:{inbounds:{"HierarchyAnalysisDtrf-display":{semanticObject:"HierarchyAn+
alysisDtrf",action:"display",title:"Hierarchy Report DTRF",signature:{parameters:{}},resolutionResult:{applicationType:"SAPUI5",additionalInformation:"SAPUI5.Component=ey.sap.fin.cs.hierarchyReportDTRF",url:sap.ui.require.toUrl("ey/sap/fin/cs/hierarchyRe+
portDTRF")}}}}}},NavTargetResolution:{config:{enableClientSideTargetResolution:true}}}});var i={init:function(){if(!this._oBootstrapFinished){this._oBootstrapFinished=sap.ushell.bootstrap("local");this._oBootstrapFinished.then(function(){sap.ushell.Conta+
iner.createRenderer().placeAt("content")})}return this._oBootstrapFinished}};return i});                                                                                                                                                                       
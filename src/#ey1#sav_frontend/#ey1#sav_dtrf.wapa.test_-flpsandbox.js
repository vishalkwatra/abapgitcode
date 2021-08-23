sap.ui.define(["sap/base/util/ObjectPath","sap/ushell/services/Container"],function(e){"use strict";e.set(["sap-ushell-config"],{defaultRenderer:"fiori2",bootstrapPlugins:{RuntimeAuthoringPlugin:{component:"sap.ushell.plugins.rta",config:{validateAppVers+
ion:false}},PersonalizePlugin:{component:"sap.ushell.plugins.rta-personalize",config:{validateAppVersion:false}}},renderers:{fiori2:{componentData:{config:{enableSearch:false,rootIntent:"Shell-home"}}}},services:{LaunchPage:{adapter:{config:{groups:[{til+
es:[{tileType:"sap.ushell.ui.tile.StaticTile",properties:{title:"Deferred Tax Roll Forward",targetURL:"#DeferredTaxRollForward-display"}}]}]}}},ClientSideTargetResolution:{adapter:{config:{inbounds:{"DeferredTaxRollForward-display":{semanticObject:"Defer+
redTaxRollForward",action:"display",description:"Deferred Tax Roll Forward",title:"Deferred Tax Roll Forward",signature:{parameters:{}},resolutionResult:{applicationType:"SAPUI5",additionalInformation:"SAPUI5.Component=ey.sap.fin.cs.deferredtaxrollfwd",u+
rl:sap.ui.require.toUrl("ey/sap/fin/cs/deferredtaxrollfwd")}}}}}},NavTargetResolution:{config:{enableClientSideTargetResolution:true}}}});var t={init:function(){if(!this._oBootstrapFinished){this._oBootstrapFinished=sap.ushell.bootstrap("local");this._oB+
ootstrapFinished.then(function(){sap.ushell.Container.createRenderer().placeAt("content")})}return this._oBootstrapFinished}};return t});                                                                                                                      
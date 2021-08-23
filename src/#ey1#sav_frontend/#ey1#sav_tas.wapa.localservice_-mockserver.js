sap.ui.define(["sap/ui/core/util/MockServer","sap/base/Log","sap/base/util/UriParameters","sap/ui/util/XMLHelper"],function(e,t,r,a){"use strict";var i,n="ey/sap/fin/cs/taxaccountsetting/",s=n+"localService/mockdata";return{init:function(){var o=new r(wi+
ndow.location.href),u=sap.ui.require.toUrl(s),p=sap.ui.require.toUrl(n+"manifest"+".json"),c="xEY1xSAV_C_GGAAP_TAS",l=o.get("errorType"),f=l==="badRequest"?400:500,d=jQuery.sap.syncGetJSON(p).data,g=d["sap.app"].dataSources,m=g.mainService,x=sap.ui.requi+
re.toUrl(n+m.settings.localUri.replace(".xml","")+".xml"),h=/.*\/$/.test(m.uri)?m.uri:m.uri+"/",v=m.settings.annotations;i=new e({rootUri:h});e.config({autoRespond:true,autoRespondAfter:o.get("serverDelay")||1e3});i.simulate(x,{sMockdataBaseUrl:u,bGenera+
teMissingMockData:true});var S=i.getRequests(),U=function(e,t,r){r.response=function(r){r.respond(e,{"Content-Type":"text/plain;charset=utf-8"},t)}};if(o.get("metadataError")){S.forEach(function(e){if(e.path.toString().indexOf("$metadata")>-1){U(500,"met+
adata Error",e)}})}if(l){S.forEach(function(e){if(e.path.toString().indexOf(c)>-1){U(f,l,e)}})}i.start();t.info("Running the app with mock data");if(v&&v.length>0){v.forEach(function(t){var r=g[t],i=r.uri,s=sap.ui.require.toUrl(n+r.settings.localUri.repl+
ace(".xml","")+".xml");new e({rootUri:i,requests:[{method:"GET",path:new RegExp("([?#].*)?"),response:function(e){sap.ui.require("jquery.sap.xml");var t=jQuery.sap.sjax({url:s,dataType:"xml"}).data;e.respondXML(200,{},a.serialize(t));return true}}]}).sta+
rt()})}},getMockServer:function(){return i}}});                                                                                                                                                                                                                
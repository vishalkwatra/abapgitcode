sap.ui.define(["sap/ui/test/Opa5","sap/ui/test/actions/Press","sap/ui/test/actions/EnterText","sap/ui/test/matchers/AggregationFilled","sap/ui/test/matchers/AggregationEmpty","sap/ui/test/matchers/Ancestor","./Common","./shareOptions"],function(e,t,i,s,r+
,n,a,o){"use strict";var c="Worklist",h="table",u="searchField",l="*#-Q@@||";function d(e){return{id:h,matchers:function(t){return t.getItems()[e.position]},actions:e.actions,success:e.success,errorMessage:"Table with ID "+h+" does not contain an item at+
 position '"+e.position+"'"}}e.createPageObjects({onTheWorklistPage:{baseClass:a,viewName:c,actions:Object.assign({iPressTableItemAtPosition:function(e){return this.waitFor(d({position:e,actions:new t}))},iRememberTableItemAtPosition:function(e){return t+
his.waitFor(d({position:e,success:function(e){var t=e.getBindingContext();this.getContext().currentItem={bindingPath:t.getPath(),id:t.getProperty("p_ryear"),name:t.getProperty("p_specialperiod")}}}))},iPressOnMoreData:function(){return this.waitFor({id:h+
,actions:new t,errorMessage:"The table with ID "+h+" does not have a button to show more items"})},iSearchForTheFirstObject:function(){return this.waitFor({id:h,success:function(e){return this.waitFor({controlType:"sap.m.ObjectIdentifier",matchers:new n(+
e),success:function(e){var t=e[0].getTitle();return this.iSearchForValue(t)},errorMessage:"Did not find entries for table with ID "+h})},errorMessage:"Did not find table with ID "+h})},iSearchForValue:function(e){return this.waitFor({id:u,actions:[new i(+
{text:e}),new t],errorMessage:"Did not find the search field with ID "+u})},iClearTheSearch:function(){return this.waitFor({id:u,actions:new t({idSuffix:"reset"}),errorMessage:"Did not find the search field with ID "+u})},iSearchForSomethingWithNoResults+
:function(){return this.iSearchForValue(l)}},o.createActions(c)),assertions:Object.assign({iShouldSeeTheTable:function(){return this.waitFor({id:h,success:function(t){e.assert.ok(t,"Found the object Table")},errorMessage:"Did not find table with ID "+h})+
},theTableShowsOnlyObjectsWithTheSearchStringInTheirTitle:function(){return this.waitFor({id:u,success:function(t){var i=t.getValue();return this.waitFor({id:h,success:function(t){return this.waitFor({controlType:"sap.m.ObjectIdentifier",matchers:new n(t+
),success:function(t){e.assert.ok(t.every(function(e){return e.getTitle().indexOf(i)>-1}),"All table entries match the search term")},errorMessage:"Did not find entries for table with ID "+h})},errorMessage:"Did not find table with ID "+h})},errorMessage+
:"Did not find search field with ID "+u})},theTableHasEntries:function(){return this.waitFor({id:h,matchers:new s({name:"items"}),success:function(){e.assert.ok(true,"The table with ID "+h+" has entries")},errorMessage:"The table with ID "+h+" had no ent+
ries"})},theTableShouldHaveAllEntries:function(){return this.waitFor({id:h,success:function(t){return this.waitFor({controlType:"sap.m.ColumnListItem",matchers:new n(t),success:function(i){var s=this.getEntitySet("xEY1xSAV_C_PR_CYTE_Mvmnt");var r=Math.mi+
n(t.getGrowingThreshold(),s.length);e.assert.strictEqual(i.length,r,"The growing Table has "+r+" items")}})},errorMessage:"Did not find table with ID "+h})},theTitleShouldDisplayTheTotalAmountOfItems:function(){return this.waitFor({id:h,success:function(+
t){var i=t.getBinding("items").getLength();return this.waitFor({id:"tableHeader",matchers:new n(t),success:function(s){var r=t.getModel("i18n").getResourceBundle().getText("worklistTableTitleCount",[i]);e.assert.strictEqual(s.getText(),r,"The table has a+
 title containing the number "+i)},errorMessage:"The table header does not container the number of items "+i})},errorMessage:"Did not find table with ID "+h})},iShouldSeeTheNoDataTextForNoSearchResults:function(){return this.waitFor({id:h,matchers:new r(+
{name:"items"}),success:function(t){e.assert.strictEqual(t.getNoDataText(),t.getModel("i18n").getProperty("worklistNoDataWithSearchText"),"The table with ID "+h+" should show the no data text for search")},errorMessage:"Did not find table with ID "+h})}}+
,o.createAssertions(c))}})});                                                                                                                                                                                                                                  
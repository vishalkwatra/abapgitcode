sap.ui.define(["ey/sap/fin/cs/deferredtaxrollfwd/model/formatter"],function(t){"use strict";QUnit.module("Number unit");function n(n,i,u){var e=t.numberUnit(i);n.strictEqual(e,u,"The rounding was correct")}QUnit.test("Should round down a 3 digit number",+
function(t){n.call(this,t,"3.123","3.12")});QUnit.test("Should round up a 3 digit number",function(t){n.call(this,t,"3.128","3.13")});QUnit.test("Should round a negative number",function(t){n.call(this,t,"-3","-3.00")});QUnit.test("Should round an empty +
string",function(t){n.call(this,t,"","")});QUnit.test("Should round a zero",function(t){n.call(this,t,"0","0.00")})});                                                                                                                                         
sap.ui.define(["sap/ui/core/format/NumberFormat"],function(r){"use strict";return{convertStringToInt:function(r){if(!r){return""}let t=parseInt(r,[10]);return t!==0?t:""},removeLeadingZero:function(r){if(!r){return"0"}return parseInt(r,[10])},formatAmoun+
t:function(r){if(parseFloat(r,[10])===0){return""}let t=sap.ui.core.format.NumberFormat.getCurrencyInstance({minIntegerDigits:1,minFractionDigits:2,maxFractionDigits:2,roundingMode:"CEILING",groupingEnabled:true,groupingSeparator:",",decimalSeparator:"."+
});return t.format(r)},formatRate:function(r){if(parseInt(r,[10])===0){return""}return r+"%"}}});                                                                                                                                                              
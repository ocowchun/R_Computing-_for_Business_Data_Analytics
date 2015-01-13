var _ = require('underscore');
var line = " V24 68 V11 12 V18 1024 V8 6 V10 68 V21 3 V22 1059 class=1";
var lines = [" V17 23709 V9 340 V8 5 V19 5 V11 3 V18 300 V20 2714 V21 3 V22 35 V24 23 class=1",
	" V17 23804 V9 108 V8 5 V19 5 V11 3 V18 320 V20 2726 V21 3 V22 803 V24 229 class=1",
	" V17 23804 V9 329 V8 5 V19 5 V11 16 V18 320 V20 2726 V21 3 V22 803 V24 229 class=1",
	" V17 23804 V9 258 V8 5 V19 5 V11 16 V18 320 V20 2726 V21 3 V22 803 V24 229 class=1",
	" V17 23755 V8 2 V9 395 V19 19 V11 1 V18 320 V20 2724 V21 0 V22 35 V24 253 class=1",
	" V17 23646 V9 45 V8 5 V19 5 V11 3 V18 300 V20 2709 V21 3 V22 39 V24 23 class=1"
];


function oo(line) {
	line = line.replace('class=1', '');
	// if (age==1&&student==1&&income==1){
	var conditions = line.split('V');
	conditions = conditions.slice(1, conditions.length - 1);
	// console.log(conditions)
	var str = _.map(conditions, function(c) {
		var g = c.split(' ');
		return "dd$V" + g[0] + "==" + g[1];
	});
	str = "if(" + str.join("&&") + "){\nreturn (1)\n}\n";
	// console.log(str);
	return str;
}

var a = _.map(lines, oo);

a = a.join('else ');
console.log(a)

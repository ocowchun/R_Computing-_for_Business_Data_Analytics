var model = require('./train400k');
var _ = require('underscore');
var readline = require('readline');
var fs = require('fs');
var stream = require('stream');
var split = require('split');
var through = require('through');

var trainFile = '/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/test400k.csv';

// a=model.predict([1,1,1,1,1,1,1]);
// console.log(a)
var readData = function(cb) {
	// var fileName = fileName;
	var instream = fs.createReadStream(trainFile);
	var tags = [];
	var lineCount = 0;

	var lines = [];

	var currentLines = 0;
	var errors = [];

	var tr = through(function(line) {

		var lineStr = line.toString();
		var line = lineStr.split(',');
		line = cleanLine(line);
		lines.push(line);
		currentLines++;
		// currentTarget = sampleIndex.shift();
		if (currentLines % 4000 === 0) {
			var currentP = currentLines / 4000;
			console.log(currentP + "%");
		}



		lineCount++;
	}, function() {
		lines.pop(); //最後一行為空白
		console.log("load data complete");
		console.log(lines.length);
		cb(lines);
	});

	instream.pipe(split())
		.pipe(tr);

}

function cleanLine(line) {
	// test1
	// return [line[7], line[9], line[10], line[17], line[20], line[21], line[1]];

	// attr.name=c("v8","v10","v11","v18","v21","v22")
	// return [line[7], line[9], line[10], line[17], line[20], line[21], line[1]];

	// test2
	// return [line[3], line[4], line[7], line[9], line[10], line[14], line[15], line[16], line[17], line[18], line[19], line[1]];

	// test4
	// return [line[3], line[19], line[1]];

	// test5
	// hour: format is YYMMDDHH, so 14091123 means 23:00 on Sept. 11, 2014 UTC.

	if (line.length > 1) {
		var t = line[2];
		// console.log(t)

		// var year = t.slice(0, 2);
		var month = t.slice(2, 4);
		var day = t.slice(4, 6);
		var hh = t.slice(6, 8);
		return [month, day, hh, line[3], line[4], line[7], line[9], line[10],
			line[14], line[15], line[16], line[17], line[18], line[19], line[1]
		];
	} else {
		return "";
	}

}

// [ '3e814130', '7801e8d9', '07d7df22', '320', '0', '39', '0' ]
readData(function(lines) {
	// console.log(lines[0]);
	// _.map(lines)
	// 
	validation(lines, model.predict);

});

// var l = ['3e814130', '7801e8d9', '07d7df22', '320', '0', '39', '0'];
// var a = model.predict(l);

// console.log(a);



function validation(data, predict) {
	var roc = new Set();

	_.each(data, function(item) {
		if (predict(item)) {
			if (_.last(item) === '1') {
				roc.add("TP", 1);
			} else {
				roc.add("FP", 1);
			}
		} else {
			if (_.last(item) === '0') {
				roc.add("TN", 1);
			} else {
				roc.add("FN", 1);
			}

		}
	});
	roc.debug();
	var precision = roc.get('TP') / (roc.get('TP') + roc.get('FP'));
	var reacll = roc.get('TP') / (roc.get('TP') + roc.get('FN'));
	var accuracy = (roc.get('TP') + roc.get('TN')) / (roc.get('TP') + roc.get('FN') + roc.get('TN') + roc.get('FP'));
	console.log("precision:" + precision);
	console.log("reacll:" + reacll);
	console.log("accuracy:" + accuracy);
}

function Set() {
	var dic = {};
	this.add = function(key, val) {
		if (dic[key]) {
			dic[key] += 1;
		} else {
			dic[key] = 1;
		}
	}

	this.get = function(key) {
		return dic[key];
	}

	this.debug = function() {
		console.log(dic);
	}
}
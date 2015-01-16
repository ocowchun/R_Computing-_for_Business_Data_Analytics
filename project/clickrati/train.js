var id3 = require('./lib/id3');
var nb = require('./lib/nb');
var _ = require('underscore');
var readline = require('readline');
var fs = require('fs');
var stream = require('stream');
var split = require('split');
var through = require('through');


var trainFile = '/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/train400k.csv';

var sample = function(cb) {
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

sample(function(lines) {
	console.log(lines[0])
		// var predict = id3.train(lines);
	var predict = nb.train(lines);

	// console.log(predict)
	// var fileName = '/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/project/clickrati/train400k.js';
	// writeFile(fileName, predict);
	// 	a=predict(lines[0]);
	// console.log(a)
});

function cleanLine(line) {
	// attr.name=c("v8","v10","v11","v18","v21","v22")
	// 7,9,10,17,20,21
	// return [line[7], line[9], line[10], line[17], line[20], line[21], line[1]];

	// data=cbind(v4,v5,v8,v10,v11,v15,v16,v17,v18,v19,v20)
	// 3,4,7,9,10,14,15,16,17,18,19
	// return [line[3], line[4], line[7], line[9], line[10], line[14], line[15], line[16], line[17], line[18], line[19], line[1]*1];

	// return [line[3],line[19], line[1]*1];


	// data=cbind(v3,v4,v5,v8,v10,v11,v17,v21,v22)
	// 2,3,4,7,9,10,16,20,21
	// return [line[2], line[3], line[4], line[7], line[9], line[10], line[16], line[20], line[21], line[1]];

	// test5
	// hour: format is YYMMDDHH, so 14091123 means 23:00 on Sept. 11, 2014 UTC.

	// if (line.length > 1) {
	// 	var t = line[2];
	// 	// console.log(t)

	// 	// var year = t.slice(0, 2);
	// 	var month = t.slice(2, 4);
	// 	var day = t.slice(4, 6);
	// 	var hh = t.slice(6, 8);
	// 	return [month, day, hh, line[3], line[4], line[7], line[9], line[10],
	// 		line[14], line[15], line[16], line[17], line[18], line[19], line[1]*1
	// 	];
	// } else {
	// 	return "";
	// }
	
	
	// test6
	// hour: format is YYMMDDHH, so 14091123 means 23:00 on Sept. 11, 2014 UTC.
	if (line.length > 1) {
		var t = line[2];
		var month = t.slice(2, 4);
		var day = t.slice(4, 6);
		var hh = t.slice(6, 8);
		return [month, day, hh, line[3], line[4], line[7], line[9], line[10],
			line[14], line[15], line[16], line[17], line[18], line[19],line[20],line[21], line[1]*1
		];
	} else {
		return "";
	}

}


function writeFile(fileName, result) {
	fs.writeFile(fileName, result, function(err) {
		if (err) {
			console.log("ERROR:")
			console.log(err);
		} else {
			console.log("The file was saved!");
		}
	});
}

// var age = [1, 1, 2, 3, 3, 3, 2, 1, 1, 3, 1, 2, 2, 3],
// 	income = [3, 3, 3, 2, 1, 1, 1, 2, 1, 2, 2, 2, 3, 2],
// 	student = [0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0],
// 	credit = [0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1],
// 	buy = [0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0];

// function transform(attr, klass) {
// 	var result = [];
// 	for (var i = 0, max = klass.length; i < max; i++) {
// 		var item = [];
// 		for (var j = 0, maxj = attr.length; j < maxj; j++) {
// 			item.push(attr[j][i]);
// 		}
// 		item.push(klass[i]);
// 		result.push(item);
// 	}
// 	return result;
// }

// // a=[]
// // a.push(1)
// // a.push(2)
// // a.push(3)
// var data = transform([age, income, student, credit], buy);

// id3.train(data)
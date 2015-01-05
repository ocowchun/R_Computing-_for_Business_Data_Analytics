var _ = require('underscore');
// var textUtil = require('../lib/util/text');
var _ = require('underscore')
var fs = require('fs');
var readline = require('readline');
var stream = require('stream');
var split = require('split');
var through = require('through');


var fileName = "/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/train";

var sample = function(cb) {
	// var fileName = fileName;
	var instream = fs.createReadStream(fileName);
	var tags = [];
	var lineCount = 0;

	var lines = [];
	var fuckNum = 40428960;
	var sampleIndex = getSampleIndex(40000, fuckNum);

	var currentLines = 0;
	var errors = [];
	// console.log(sampleIndex.length);
	// var currentTarget = sampleIndex.shift();
	var tr = through(function(line) {
		if (_.indexOf(sampleIndex, lineCount, true) != -1) {
			// if (true) {
			// if (lineCount === currentTarget) {
			line = line.toString();

			if (valideData(line)) {
				lines.push(line);

			} else {
				errors.push({
					lineCount: lineCount,
					line: line
				});
			}
			currentLines++;
			// currentTarget = sampleIndex.shift();
			if (currentLines % 4000 === 0) {
				var currentP = currentLines / 4000;
				// console.log(lines.length);
				console.log(currentP + "%");
				append(lines);
				lines = [];
			}

		}

		lineCount++;
	}, function() {
		console.log("done");
		if (errors.length > 0) {
			console.log("errors");
			console.log(errors);
		}
		// cb(lines);
	});

	instream.pipe(split())
		.pipe(tr);

}

function append(lines) {
	// lines.con
	var result = lines.join("\n")+"\n";
	var fileName = "/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/train.4k.csv";
	fs.appendFile(fileName, result, function(err) {
		if (err) throw err;
		console.log('The "data to append" was appended to file!');
	});



	// fs.writeFile(fileName, result, function(err) {
	// 	if (err) {
	// 		console.log("ERROR:")
	// 		console.log(err);
	// 	} else {
	// 		console.log("The file was saved!");
	// 	}
	// });

}

function getSampleIndex(size, max) {
	var store = [];
	for (var i = 0; i < max; i++) {
		store.push(i);
	}
	console.log("hello");
	var result = _.shuffle(store).slice(0, size);

	console.log("sample done");
	var sortIds = _.sortBy(result, function(num) {
		return num;
	});
	return sortIds;
}


function valideData(line) {
	return line.split(',').length === 24
}

sample(function(lines) {
	writeLines(lines);
	// console.log(lines.length);
});


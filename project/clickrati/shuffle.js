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
	var fuckNum=40428960;
	var sampleIndex = getSampleIndex(10000, fuckNum);

	var tr = through(function(line) {
		// if (lineCount  10) {
		if (_.contains(sampleIndex, lineCount)) {
			line = line.toString();
			lines.push(line);
		}
		lineCount++;
	}, function() {
		cb(lines);
	});
	instream.pipe(split())
		.pipe(tr);

}

function getSampleIndex(size, max) {
	var result = [],
		i = 0;

	while (i < size) {
		var candidate = _.random(0, max);
		if (!_.contains(result, candidate)) {
			result.push(candidate);
			i++
		}
	}
	return result;
}

// console.log(getSampleIndex(10000,40428960));

// console.log(_.random(0, 1))

sample(function(lines) {
	writeLines(lines);
	// console.log(lines.length);
});

// var a = ["hello", "bar"];
// console.log(a.join("\n"))


var writeLines = function(lines) {
	// lines.con
	var result = lines.join("\n");
	var fileName = "/Users/ocowchun/Dropbox/nccu/R_Computing _for_Business_Data_Analytics/temp/test.csv";
	fs.writeFile(fileName, result, function(err) {
		if (err) {
			console.log(err);
		} else {
			console.log("The file was saved!");
		}
	});
}
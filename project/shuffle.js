var _ = require('underscore');
var textUtil = require('../lib/util/text');
var _ = require('underscore')
var fs = require('fs');
var readline = require('readline');
var stream = require('stream');
var split = require('split');
var through = require('through');



// var csvFileName = "../academia.stackexchange.com/Posts.xml";
var csvFileName = "/Users/ocowchun/projects/nodejs/cluster/datas/stackexchange/android.stackexchange/Posts.xml";
var TagcsvFileName = "/Users/ocowchun/projects/nodejs/cluster/datas/stackexchange/android.stackexchange/Tags.xml";



var fileContent = "";
exports.excute = function(updateQuestions, fileName, only_tag) {
	fileName = fileName || csvFileName;
	var instream = fs.createReadStream(fileName);
	only_tag = only_tag || true;
	var outstream = new stream;
	var rl = readline.createInterface(instream, outstream);
	var lineCount = 0;
	var questions = [];

	rl.on('line', function(line) {

		if (lineCount > 2 && lineCount < 500) {
			var question = textUtil.parse(line);
			var words = textUtil.bagOfWords(question.body);
			var titleWords = textUtil.bagOfWords(question.title);
			var count = textUtil.wordCount(words);
			var titlWordCount = textUtil.wordCount(titleWords);
			question.wordCounts = count;
			question.titleWordCounts = titlWordCount;
			if (only_tag) {
				if (question.tags.length > 0) {
					questions.push(question);

				}
			} else {
				questions.push(question);

			}
		}
		lineCount++;
		// console.log(lineCount);
	});
	rl.on('close', function() {
		console.log("questions length: " + questions.length);
		console.log("updateQuestions start")
		updateQuestions(questions);

	});
	rl.close();
};

exports.getQuestions = function(cb,max, filter) {
	var fileName = csvFileName;
	var instream = fs.createReadStream(fileName);
	var questions = [];
	var lineCount = 0;
	
	max=max||1000
	filter = filter || function() {
		return true;
	}


	var tr = through(function(line) {
		line = line.toString();
		if (lineCount > 1 && lineCount<max) {
			var question = textUtil.parse(line);
			var words = textUtil.bagOfWords(question.body);
			var titleWords = textUtil.bagOfWords(question.title);
			var count = textUtil.wordCount(words);
			var titlWordCount = textUtil.wordCount(titleWords);
			question.wordCounts = count;
			question.titleWordCounts = titlWordCount;
			if (question.tags.length > 0) {
				if (filter(question)) {
					questions.push(question);
				}
			}

		}
		lineCount++;
	}, function() {
		cb(questions);
	});
	instream.pipe(split())
	.pipe(tr);

}


// exports.getQuestions(function(questions) {
// 	console.log(questions);
// }, function(question) {
// 	return _.contains(question.tags, "applications");
// });

exports.getTags = function(cb) {
	var fileName = TagcsvFileName;
	var instream = fs.createReadStream(fileName);
	var tags = [];
	var lineCount = 0;

	var tr = through(function(line) {
		line = line.toString();
		if (lineCount > 1) {
			var tag = textUtil.parseTag(line);
			if (!_.isNaN(tag.count) && _.isNumber(tag.count)) {
				tags.push(tag);
			}
		}
		lineCount++;
	}, function() {
		cb(tags);
	});
	instream.pipe(split())
	.pipe(tr);

}

function updateQuestions(questions) {
	console.log(questions[0]);
}

// exports.getQuestions(function(qs) {
// 	console.log(qs.length);
// });
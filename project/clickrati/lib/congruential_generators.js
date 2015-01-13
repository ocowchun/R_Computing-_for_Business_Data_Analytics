// var a, b, m, x0
var _ = require('underscore');

function random(a, b, m, xn) {
	var x = (a * xn + b) % m;
	return x;
}

function randomSeq(size, max) {
	var m = 10579203001,
		a = 3312341 + max,
		b = 7 + max,
		x = 2 + max;
	var result = [];
	// for (var i = 0; i < size; i++) {
	var current = 0;
	while (current < size) {
		// x = random(a, b, m, x);
		x = random2(max);
		if (!_.contains(result, x)) {
			// if (!_.indexOf(result, x, true) != -1) {
			result.push(x);
			// var result = _.sortBy(result, function(num) {
			// 	return num;
			// });
			current++;
		} else {
			console.log("current:", current)
			console.log(x)
		}
	}

	return result;
}

function random2(max) {
	// Math.round(Math.random() * max) + 1
	// for (var i = 0; i < size; i++) {

	// }
	return Math.floor(Math.random() * max) + 1;
}

function random3(x) {
	var prime = 4294967291;
	// if ()
}


function randomSeq2(size, max) {
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


// var a = randomSeq2(400000, 40428960);
var a = randomSeq2(10, 60);
a=[];
console.log(a);
console.log(a.shift())

// console.log([1,2,3,4,5].slice(0,3))
// console.log(a.length)
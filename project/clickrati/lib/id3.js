var _ = require('underscore');

var age = [1, 1, 2, 3, 3, 3, 2, 1, 1, 3, 1, 2, 2, 3],
	income = [3, 3, 3, 3, 2, 1, 1, 1, 2, 1, 2, 2, 2, 3, 2],
	student = [0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0],
	credit = [0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1],
	buy = [0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0];

function transform(attr, klass) {
	var result = [];
	for (var i = 0, max = klass.length; i < max; i++) {
		var item = [];
		for (var j = 0, maxj = attr.length; j < maxj; j++) {
			item.push(attr[j][i]);
		}
		item.push(klass[i]);
		result.push(item);
	}
	return result;
}

// a=[]
// a.push(1)
// a.push(2)
// a.push(3)
var data = transform([age, income, student, credit], buy);
// data.push([2, 3, 0, 0, 1])

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



/**
 * entropy越小越好
 * @param  {array} attr  資料集
 * @param  {array} idx 資料第i個屬性
 * @return {[type]}       entropy
 */
var entropy = function(data, idx) {
	if (_.isNaN(data[0][idx])) {
		return (100);
	} else {
		var attrSet = _.unique(_.map(data, function(d) {
			return d[idx];
		}));
		var dic = new Set();

		for (var i = 0, max = data.length; i < max; i++) {
			var val = data[i][idx];
			var k = _.last(data[i]);
			dic.add("val" + val, 1);
			dic.add("val" + val + "k" + k, 1);
		}
		var result = _.reduce(attrSet, function(memo, val) {
			var p = dic.get('val' + val + "k1") || 0;
			var n = dic.get('val' + val + "k0") || 0;
			return g = memo + (dic.get('val' + val) / data.length) * ig(p, n);
		}, 0);
		return result;
	}
};



var ig = function(p, n) {
	// return 1;
	deno = p + n
	if (p == 0 || n == 0) {
		return (0)
	} else {
		return (-(p / deno) * log2(p / deno) - (n / deno) * log2(n / deno))
	}
}

var log2 = function(val) {
	return Math.log(val) / Math.log(2)
}

/**
 *select attr[idx]=val,留下指定屬性之外的屬性,
 * @param  {[type]} idx   指定屬性的idx
 * @param  {[type]} val   屬性值
 * @param  {[type]} data  [description]
 * @return {[type]}       [description]
 */
var seprate = function(idx, val, data) {
	var newData = _.filter(data, function(item) {
		return item[idx] === val;
	});

	newData = _.map(newData, function(item) {
		return _.clone(item)
	});

	return _.map(newData, function(item) {
		item[idx] = NaN;
		return item;
	});
}

var tree = function(data, guide) {
	var minIndex = 0,
		currentEntropy = 2;
	// var AttrDic = ["age", "income", "student", "credit"];
	var result = [];
	guide = guide || [];
	// 最後一個屬性為class
	for (var i = 0, max = data[i].length - 1; i < max; i++) {
		var e = entropy(data, i)
		if (e < currentEntropy) {
			currentEntropy = e;
			minIndex = i;
		}
	}
	var attrSet = _.unique(_.map(data, function(d) {
		return d[minIndex];
	}));

	for (var i = 0, max = attrSet.length; i < max; i++) {
		var val = attrSet[i];
		dataSet = seprate(minIndex, val, data);
		// var attrStr = AttrDic[minIndex]
		guide1 = guide.concat([minIndex, val]);
		if (isFinish(dataSet)) {
			// console.log(dataSet)
			var mean = _.reduce(dataSet, function(memo, item) {
				return memo + _.last(item) * 1;
			}, 0);
			mean = mean / (dataSet.length);
			console.log('mean:')
			console.log(mean)
			var predictKlass = Math.round(mean + 0.2);
			if (predictKlass == 1 && dataSet.length > 5) {
				// 只顯示會買的
				result.push(guide1);
			}
		} else {
			var dataSetKlass = _.map(dataSet, function(item) {
				return _.last(item);
			});
			result = result.concat(tree(dataSet, guide1));
		}
	}
	return result;

}

function isFinish(data) {

	if (data.length > 0) {
		var item = data[0];
		return _.every(item.slice(0, item.length - 1), _.isNaN);
	} else {
		return true;
	}
}


var a = tree(data);
var isTrue = function(b) {
		return !!b
	}
	// a=_.every([true, false],isTrue)
	// console.log(a);
module.exports.train = function(data) {
	var guides = tree(data);
	return learn(guides);
};

function learn(guides) {
	// data[6]==803&&data[2]==2347f47a&&data[3]==4ce2e9fc&&data[1]==50e219e0&&data[4]==320&&data[5]==3
	var str = _.map(guides, function(guide) {

		return "if (" + rCondition(guide) + "){\nreturn 1;\n}\n";
	});

	var body = str.join("else ") + "else {\nreturn 0;\n}";

	var fn = "function predict(data) {\n" + body + "}\n module.exports.predict = predict;";
	return fn;
};

// meta programming
function learn1(guides) {
	var fs = _.map(guides, function(guide) {
		rCondition(guide)
		return condition(guide);
	});

	// console.log(fs);
	return function(data) {
		var reuslt = _.map(fs, function(f) {
			return f(data);
		});

		return _.any(reuslt, isTrue)
	};
};


function condition(guide) {
	var fs = [],
		str = "";
	for (var i = 0, max = guide.length / 2; i < max; i++) {
		var attr = guide[i * 2],
			val = guide[i * 2 + 1];
		var f = (function(attr, val) {
			return function(data) {
				return data[attr] === val;
			}
		})(attr, val);
		fs.push(f);
	}

	return function(data) {
		var result = _.map(fs, function(f) {
			return f(data);
		});
		return _.every(result, isTrue)
	};
}

function HumanCondition(guide) {
	var AttrDic = ["age", "income", "student", "credit"];
	str = ""
	for (var i = 0, max = guide.length / 2; i < max; i++) {
		var attr = AttrDic[guide[i * 2]],
			val = guide[i * 2 + 1];
		str += attr + val + " ";
	}
	console.log(str);
}

function rCondition(guide) {
	var AttrDic = ["age", "income", "student", "credit"];
	str = []
	var compiled = _.template("data[<%= attr %>]=='<%= val %>'");

	for (var i = 0, max = guide.length / 2; i < max; i++) {
		var attr = guide[i * 2],
			val = guide[i * 2 + 1];
		// str += attr + val + " ";
		str.push(compiled({
			attr: attr,
			val: val
		}));
	}

	return str.join("&&");
}

// predict = learn(a);
// var gg = predict(data[2])


function validation(data, predict) {
	var roc = new Set();

	_.each(data, function(item) {
		if (predict(item)) {
			if (_.last(item) == 1) {
				roc.add("TP", 1);
			} else {
				roc.add("FP", 1);
			}
		} else {
			if (_.last(item) == 0) {
				roc.add("TN", 1);
			} else {
				roc.add("FN", 1);
			}

		}
	});
	roc.debug();
}


// var f = condition([0, 1, 2, 1, 1, 1, 3, 0]);
// var c = f(data[0]);
// console.log(data[0])
// console.log(c)


// a = [1, 1, 1, 1]
// b = [1, 1, 1, 1]
// c = [1, 1, 1, 1]
// d = [a, b, c]
// f = _.filter(d, function(item) {
// 	return item[0] === 1
// });
// f
// f[0][1] = 2
// console.log(f)
// console.log(a)



// var e = entropy(age, buy);
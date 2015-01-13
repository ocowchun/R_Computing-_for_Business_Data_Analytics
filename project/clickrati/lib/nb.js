var _ = require('underscore');
var Set = require('./util/set');
// fetch data
// load eac


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



function NB() {
  this.store = new Set();
  this.attrs = [];
  this.debug = this.store.debug;
}

NB.prototype.add = function(attr, val, klass) {
  var key = this.getKey(attr, val, klass);
  var attrKey = this.getAttrKey(attr, klass);
  var classKey = this.getClassKey(attr);
  this.store.add(key, 1);
  this.store.add(attrKey, 1);
  this.store.add(classKey, 1);
  var attrs = this.attrs[attr] || [];
  attrs.push(val);
  attrs = _.uniq(attrs);
  this.attrs[attr] = attrs;
};

NB.prototype.get = function(attr, val, klass) {
  var key = this.getKey(attr, val, klass);
  return this.store.get(key) || 1;
};

NB.prototype.getAttr = function(attr, klass) {
  var key = this.getAttrKey(attr, klass);
  return this.store.get(key) || 0;
};

NB.prototype.getClass = function(klass) {
  var key = this.getClassKey(klass);
  return this.store.get(key) || 0;
};


NB.prototype.getKey = function(attr, val, klass) {
  var key = "attr:" + attr + "_val:" + val + "_c:" + klass;
  return key;
};

NB.prototype.getAttrKey = function(attr, klass) {
  var key = "attr:" + attr + "_c:" + klass;
  return key;
};

NB.prototype.getClassKey = function(klass) {
  var key = "c:" + klass;
  return key;
};


NB.prototype.loadOneRow = function(data) {
  var c = _.last(data);
  var max = data.length - 1; //扣掉class
  for (var i = 0; i < max; i++) {
    this.add(i, data[i], c);
  }
}

/**
 * train data
 * @param  {array} data train's data
 */
NB.prototype.train = function(data) {
  var that = this;
  var i = 0;
  var max = data.length;
  var percent = Math.floor(max / 100);
  _.each(data, function(row) {
    that.loadOneRow(row);
    i++;
    if (i % percent == 0) {
      console.log(i / percent + "%");
    }

  });
};

/**
 * given data,predict the bayes probability to be klass k
 * @param  {array} data
 * @param  {number} klass
 * @return {number} probability in log
 */
NB.prototype.predictk = function(data, klass) {
  var result = Math.log(this.getClass(klass));
  var max = data.length;
  for (var i = 0; i < max; i++) {
    var v = this.get(i, data[i], klass) + 1;
    var denomiter = this.getAttr(i, klass) + this.attrs[i].length;
    result += Math.log(v / denomiter);
  }
  return result;
};


NB.prototype.predict = function(data) {
  p = [];
  for (var i = 0; i < 2; i++) {
    p.push(this.predictk(data, i));
  }
  if (p[0] > p[1]) {
    return 0;
  } else {
    return 1;
  }
};


var data = transform([age, income, student, credit], buy);
var nb=new NB()
nb.train(data);

module.exports.train = function(data) {
  var nb = new NB();
  nb.train(data);
  var predict = function(data) {
    return nb.predict(data);
  }
  validation(data, predict);

  return predict;
}

// nb
// P(C|D)=P(D|C)*P(C)/P(D)



// validation(data, predict);

function validation(data, predict) {
  var roc = new Set();
  roc.add("FP", 0);
  _.each(data, function(item) {
    var d = item.slice(0, item.length - 1);
    if (predict(d)) {
      if (_.last(item) === 1) {
        roc.add("TP", 1);
      } else {
        roc.add("FP", 1);
      }
    } else {
      if (_.last(item) === 0) {
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
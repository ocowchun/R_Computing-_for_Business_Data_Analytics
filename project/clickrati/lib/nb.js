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


function Store() {
  this.stores = {};
  this.attrStore = new Set();
  this.classStore = [];
}

Store.prototype.add = function(attr, val, klass) {
  var key = 'attr' + attr;
  var key2 = 'val:' + val + "_klass:" + klass;
  if (!this.stores[key]) {
    this.stores[key] = new Set();
  }
  this.stores[key].add(key2, 1);
};

Store.prototype.get = function(attr, val, klass) {
  var key = 'attr' + attr;
  var key2 = 'val:' + val + "_klass:" + klass;
  return this.stores[key].get(key2) || 0;
};


Store.prototype.addAttr = function(attr, klass) {
  var key = "attr:" + attr + "_c:" + klass;
  this.attrStore.add(key, 1);
};

Store.prototype.getAttr = function(attr, klass) {
  var key = "attr:" + attr + "_c:" + klass;
  return this.attrStore.get(key) || 0;
};

Store.prototype.addClass = function(klass) {
  var current = this.classStore[klass] || 0;
  this.classStore[klass] = current + 1;
};

Store.prototype.getClass = function(klass) {
  return this.classStore[klass];
};

function NB() {
  this.store = new Store();
  this.attrs = [];
  this.debug = this.store.debug;
}

NB.prototype.add = function(attr, val, klass) {
  this.store.add(attr, val, klass);
  this.store.addAttr(attr, klass);

  var attrs = this.attrs[attr] || [];
  if (!_.include(attrs, val)) {
    attrs.push(val);
    this.attrs[attr] = attrs;
  }

  // var attrs = this.attrs[attr] || [];
  // attrs.push(val);
  // attrs = _.uniq(attrs);
  // this.attrs[attr] = attrs;
};

NB.prototype.addClass = function(klass) {
  this.store.addClass(klass);
};

//attr,val有多少筆資料屬於klass
NB.prototype.get = function(attr, val, klass) {
  return this.store.get(attr, val, klass);
};

//attr有多少筆資料屬於klass
NB.prototype.getAttr = function(attr, klass) {
  return this.store.getAttr(attr, klass);
};

// 多少筆資料屬於klass
NB.prototype.getClass = function(klass) {
  return this.store.getClass(klass);
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
  this.addClass(c);
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

module.exports.train = function(data) {
  var nb = new NB();
  nb.train(data);
  var predict = function(data) {
    return nb.predict(data);
  }
  validation(data, predict);

  return predict;
}

// test
var data = transform([age, income, student, credit], buy);
var nb = new NB()
nb.train(data)
module.exports.train(data)
  // var d = data[1].slice(0, data[1].length - 1);
  // nb.predict(d)

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
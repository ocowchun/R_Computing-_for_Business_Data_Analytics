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

module.exports=Set
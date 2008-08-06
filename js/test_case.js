testJS.testCase = function(name, action) {
  this.name = name;
  this.action = action;
  this.errorMessage = false;
  this.__passed = true;
}

Object.extend(testJS.testCase.prototype, {
  run: function(log) {
    try { this.action.apply(this); }
    catch(e) { this.errorMessage = e.toString(); }
    Ruby.TestJS.Result.add(this);
    return this;
  },
  
  passed: function() {
    return this.__passed && !this.errored();
  },
  
  failed: function() {
    return !this.__passed && !this.errored();
  },
  
  errored: function() {
    return this.errorMessage ? true : false;
  },
  
  resultBin: function() {
    if (this.errored()) { return 'errored'; }
    if (this.passed()) { return 'passed'; }
    if (this.failed()) { return 'failed'; }
  }
});
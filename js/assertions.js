testJS.Assertions = {
  assert: function(cond, msg) {
    if (!cond) {
      msg = msg || "false is not true";
      this.failureReports.push(msg);
    }
  },
  
  assertEqual: function(expected, actual, msg) {
    this.assert((expected == actual), (msg || "expected " + expected + ", actual: " + actual));
  }
}

Object.extend(testJS.testCase.prototype, testJS.Assertions);
testJS.Assertions = {
  assert: function(cond) {
    if (!cond) { this.__passed = false; }
  }
}

Object.extend(testJS.testCase.prototype, testJS.Assertions);
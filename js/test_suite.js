testJS.testSuite = function(tests) {
  this.setup(tests);
}

Object.extend(testJS.testSuite.prototype, {
  setup: function(tests) {
    this.tests = new Array;
    this.passed = new Array;
    this.failed = new Array;
    this.errored = new Array;
    for (name in tests) {
      this.tests.push(new testJS.testCase(name, tests[name]));
    }
  },
  
  run: function() {
    for (name in this.tests) {
      var test = this.tests[name];
      test.run();
      this[test.resultBin()].push(name);
    }
    return this.report();
  },
  
  report: function() {
    var results = {
      Passed: this.passed.length,
      Failed: this.failed.length
    }
    
    return results;
  }
});
testJS.testSuite = function(tests) {
  this.setup(tests);
}

Object.extend(testJS.testSuite.prototype, {
  setup: function(tests) {
    this.meta = { };
    this.tests = new Array;
    this.passed = new Array;
    this.failed = new Array;
    this.errored = new Array;
    for (name in tests) {
      if (meta = (name.match(/(setup|teardown)/) || [])[0]) { this.meta[meta] = tests[name]; }
      else { this.addTest(name, tests[name]) }
    }
  },
  
  addTest: function(name, test) {
    this.tests.push(new testJS.testCase(name, test));
  },
  
  run: function() {
    for (name in this.tests) {
      var test = this.tests[name];
      this.runMeta('setup', test);
      test.run();
      this.runMeta('teardown', test);
      this[test.resultBin()].push(name);
    }
    return this.report();
  },
  
  runMeta: function(name, test) {
    if (typeof(this.meta[name]) != undefined) {
      var handler = this.meta[name].bind(test);
      handler.call();
    }
  },
  
  report: function() {
    var results = {
      Passed: this.passed.length,
      Failed: this.failed.length,
      Errored: this.errored.length
    }
    
    return results;
  }
});
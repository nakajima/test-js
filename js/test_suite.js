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
      else { this.tests.push(new testJS.testCase(name, tests[name])); }
    }
  },
  
  run: function() {
    for (name in this.tests) {
      var test = this.tests[name];
      this.runMeta('setup');
      test.run();
      this.runMeta('teardown');
      this[test.resultBin()].push(name);
    }
    return this.report();
  },
  
  runMeta: function(name) {
    if (typeof(this.meta[name]) != undefined) { this.meta[name].call(); }
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
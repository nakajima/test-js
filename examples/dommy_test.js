new testJS.testSuite({
  'should have document': function() {
    this.assert(typeof(document) != undefined)
  },
  
  'should get element text': function() {
    this.assertEqual('Hello, World!', $('#test-element').text());
  },
  
  'should update element text': function() {
    $('#test-element').text("changed!");
    this.assertEqual('changed!', $('#test-element').text());
  },
  
  'should get all p tags': function() {
    this.assertEqual(4, $('p').size());
  }
}).run();
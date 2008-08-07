var Person = function(name) {
  this.name = name;
}

Object.extend(Person.prototype, {
  awesome: function() { return true; },
  greet: function(friend) { return "Hello " + friend + '!'; },
  changeName: function(newName) { this.name = newName; }
});

new testJS.testSuite({
  setup: function() { this.person = new Person('Pat'); },
  
  'should be awesome': function() {
    this.assert(this.person.awesome());
  },
  
  'should greet': function() {
    this.assertEqual('Hello Jim!', this.person.greet('Jim'));
  },
  
  'should change name': function() {
    this.assertEqual('Pat', this.person.name);
    this.person.changeName('Douglas');
    this.assertEqual('Douglas', this.person.name);
  },
  
  'should assert true and pass': function() {
    this.assert(true);
  },
  
  'should assert !false and pass': function() {
    this.assert(!false)
  }
  
}).run();
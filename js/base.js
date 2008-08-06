Object.extend = function(receiver, features) {
  for (key in features) { receiver[key] = features[key]; }
};

Object.extend(Function.prototype, {
  bind: function(object) {
    var __method = this;
    var __object = arguments[1];
    return function() {
      return __method.apply(__object);
    }
  }
});

var undefined = 'undefined';

var testJS = { };
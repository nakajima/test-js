unless defined?(TEST_JS_ROOT)
  TEST_JS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  $:.unshift TEST_JS_ROOT
  $:.unshift File.join(TEST_JS_ROOT, 'lib')
end

require 'test_js'
require 'spec'

def setup_runtime
  runtime = Johnson::Runtime.new
  runtime.evaluate("Johnson.require('js/base.js');")
  runtime.evaluate("Johnson.require('js/test_case.js');")
  runtime.evaluate("Johnson.require('js/test_suite.js');")
  runtime.evaluate("Johnson.require('js/assertions.js');")
  runtime.evaluate("Ruby.require('lib/test_js')")
  runtime
end

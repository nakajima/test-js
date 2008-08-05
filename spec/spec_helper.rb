unless defined?(TEST_JS_ROOT)
  TEST_JS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  $:.push(TEST_JS_ROOT)
end

require 'rubygems'
require 'johnson'
require 'spec'

def setup_runtime
  runtime = Johnson::Runtime.new
  runtime.evaluate("Johnson.require('js/base.js');")
  runtime.evaluate("Johnson.require('js/test_case.js');")
  runtime.evaluate("Johnson.require('js/test_suite.js');")
  runtime.evaluate("Johnson.require('js/assertions.js');")
  runtime
end

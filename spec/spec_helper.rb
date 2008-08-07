unless defined?(TEST_JS_ROOT)
  TEST_JS_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  $:.unshift TEST_JS_ROOT
  $:.unshift File.join(TEST_JS_ROOT, 'lib')
end

require 'test_js'
require 'spec'

def setup_runtime
  TestJS::Evaluator.new
end

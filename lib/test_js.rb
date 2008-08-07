$:.unshift File.join(File.dirname(__FILE__), 'test_js')

TEST_JS_ROOT = File.join(File.dirname(__FILE__), '..') unless defined?(TEST_JS_ROOT)

%w(rubygems johnson colored benchmark).each { |lib| require lib }

require 'core_ext'
require 'output'
require 'test'
require 'result'
require 'evaluator'
require 'runner'

module TestJS

end
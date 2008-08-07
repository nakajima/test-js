module TestJS
  class Evaluator
    def initialize(dom=false)
      @runtime = Johnson::Runtime.new
      setup_dom if dom
      eval_file(File.join(TEST_JS_ROOT,'js/base.js'))
      eval_file(File.join(TEST_JS_ROOT,'js/jquery.js')) if dom
      eval_file(File.join(TEST_JS_ROOT,'js/test_case.js'))
      eval_file(File.join(TEST_JS_ROOT,'js/assertions.js'))
      eval_file(File.join(TEST_JS_ROOT,'js/test_suite.js'))
    end
    
    def <<(js)
      @runtime.evaluate(js)
    end
    
    alias_method :evaluate, :<<
    
    def eval_file(path)
      self << File.read(path)
    end
    
    private
    
    def setup_dom
      @runtime.evaluate("Johnson.require('johnson/browser.js')")
      may_thread do
        @runtime.evaluate <<-JS
        window.location = "file://#{File.expand_path(File.join(TEST_JS_ROOT, 'js'))}/index.html";
        JS
      end
    end
     
    def may_thread(&block)
      block.call
      (Thread.list - [Thread.main]).each { |t| t.join }
    end
  end
end
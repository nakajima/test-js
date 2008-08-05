require File.join(File.dirname(__FILE__), 'spec_helper')

describe "testJS.testSuite" do
  before(:each) do
    @runtime = setup_runtime
    @ts = @runtime.evaluate <<-JS
      new testJS.testSuite({
        'test #1': function() { this.assert(true); },
        'test #2': function() { this.assert(false); },
        'test #3': function() { throw('whoops'); }
      });
    JS
  end
  
  it "should have tests" do
    @ts.should have(3).tests
  end
  
  it "should have result bins" do
    @ts.passed.length.should == 0
    @ts.failed.length.should == 0
    @ts.errored.length.should == 0
  end
end
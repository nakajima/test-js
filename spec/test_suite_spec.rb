require File.join(File.dirname(__FILE__), 'spec_helper')

describe "testJS.testSuite" do
  before(:each) do
    $stdout.stub!(:print)
    $stdout.stub!(:flush)
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
  
  describe "setup()" do
    it "should run setup before each test" do
      setup = stub('setup')
      setup.should_receive(:apply).exactly(3).times
      @ts.meta.setup = setup
      @ts.run
    end
  end
  
  describe "teardown()" do
    it "should run teardown after each test" do
      teardown = stub('teardown')
      teardown.should_receive(:apply).exactly(3).times
      @ts.meta.teardown = teardown
      @ts.run
    end
  end
  
  describe "run()" do
    it "should run tests" do
      @ts.run
      [:passed, :failed, :errored].each do |status|
        @ts.send(status).length.should == 1
      end
    end
  end
end
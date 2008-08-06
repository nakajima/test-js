require File.join(File.dirname(__FILE__), 'spec_helper')

describe "testJS.testCase" do
  before(:each) do
    $stdout.stub!(:print)
    $stdout.stub!(:flush)
    @runtime = setup_runtime
    @tc = @runtime.evaluate("new testJS.testCase('a name', function() { });")
  end
  
  describe "naming" do
    it "should return name" do
      @tc.name.should == 'a name'
    end
  end
  
  describe "statuses" do
    it "should know if passed" do
      @tc.__passed = true
      @tc.passed.should be_true
      @tc.failed.should be_false
      @tc.errored.should be_false
    end
    
    it "should know if failed" do
      @tc.__passed = false
      @tc.passed.should be_false
      @tc.failed.should be_true
      @tc.errored.should be_false
    end
    
    it "should know if errored" do
      @tc.errorMessage = 'Whoops!'
      @tc.passed.should be_false
      @tc.failed.should be_false
      @tc.errored.should be_true
    end
    
    it "should return passed result bin" do
      @tc.__passed = true
      @tc.resultBin.should == 'passed'
    end
    
    it "should return failed result bin" do
      @tc.__passed = false
      @tc.resultBin.should == 'failed'
    end
    
    it "should return errored result bin" do
      @tc.errorMessage = 'oops'
      @tc.resultBin.should == 'errored'
    end
  end
  
  describe "run()" do
    before(:each) do
      @passed = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(true); });")
      @failed = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(false); });")
      @errored = @runtime.evaluate("new testJS.testCase('test', function() { throw('whoops'); });")
    end
    
    it "should return self" do
      @tc.run.should == @tc
    end
    
    it "should pass when asserting true" do
      @passed.run
      @passed.passed.should be_true
    end

    it "should fail when asserting true" do
      @failed.run
      @failed.passed.should be_false
    end
    
    it "should handle errors" do
      lambda { @errored.run }.should_not raise_error
    end
    
    describe "printing results" do
      it "should print passing result" do
        TestJS.should_receive(:log).with('.'.green)
        @runtime.evaluate("tc = new testJS.testCase('test', function() { this.assert(true); });")
        @runtime.evaluate("tc.run()")
      end

      it "should print failing result" do
        TestJS.should_receive(:log).with('F'.red)
        @runtime.evaluate("tc = new testJS.testCase('test', function() { this.assert(false); });")
        @runtime.evaluate("tc.run()")
      end

      it "should print errored result" do
        TestJS.should_receive(:log).with('E'.yellow)
        @runtime.evaluate("tc = new testJS.testCase('test', function() { throw('whoops'); });")
        @runtime.evaluate("tc.run()")
      end
    end
  end
end
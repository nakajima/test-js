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
      @tc.passed.should be_true
      @tc.failed.should be_false
      @tc.errored.should be_false
    end
    
    it "should know if failed" do
      @tc.failureReports.push :fail
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
      @tc.resultBin.should == 'passed'
    end
    
    it "should return failed result bin" do
      @tc.failureReports.push :fail
      @tc.resultBin.should == 'failed'
    end
    
    it "should return errored result bin" do
      @tc.errorMessage = 'oops'
      @tc.resultBin.should == 'errored'
    end
  end
  
  describe "run()" do
    before(:each) do
      @passing = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(true); });")
      @failing = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(false); });")
      @errored = @runtime.evaluate("new testJS.testCase('test', function() { throw('whoops'); });")
    end
    
    it "should return self" do
      @tc.run.should == @tc
    end
    
    it "should pass when asserting true" do
      @passing.run
      @passing.passed.should be_true
    end

    it "should fail when asserting true" do
      @failing.run
      @failing.passed.should be_false
      @failing.failureReports.length.should == 1
    end
    
    it "should handle errors" do
      lambda { @errored.run }.should_not raise_error
    end
    
    describe "printing results" do
      it "should print passing result" do
        $stdout.should_receive(:print).with('.'.green)
        @passing.run
      end

      it "should print failing result" do
        $stdout.should_receive(:print).with('F'.red)
        @failing.run
      end

      it "should print errored result" do
        $stdout.should_receive(:print).with('E'.yellow)
        @errored.run
      end
    end
  end
end
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "testJS.testCase" do
  before(:each) do
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
    it "should return self" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(true); });")
      tc.run.should == tc
    end
    
    it "should pass when asserting true" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(true); });")
      tc.run
      tc.passed.should be_true
    end

    it "should fail when asserting true" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(false); });")
      tc.run
      tc.passed.should be_false
    end
    
    it "should handle errors" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { throw('whoops'); });")
      lambda { tc.run }.should_not raise_error
    end
  end
end
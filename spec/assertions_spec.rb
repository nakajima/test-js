require File.join(File.dirname(__FILE__), 'spec_helper')

describe "assertions" do
  before(:each) do
    $stdout.stub!(:print)
    $stdout.stub!(:flush)
    @runtime = setup_runtime
  end
  
  describe "assert()" do
    it "should pass when true" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(true); });")
      tc.run
      tc.passed.should be_true
    end
    
    it "should fail when false" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assert(false); });")
      tc.run
      tc.passed.should be_false
    end
  end
  
  describe "assertEqual" do
    it "should pass when equal" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assertEqual(3, 3); });")
      tc.run
      tc.passed.should be_true
      tc.failed.should be_false
    end
    
    it "should fail with not equal" do
      tc = @runtime.evaluate("new testJS.testCase('test', function() { this.assertEqual(3, 4); });")
      tc.run
      tc.passed.should be_false
      tc.failed.should be_true
    end
  end
end
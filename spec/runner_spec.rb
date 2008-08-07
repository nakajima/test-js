require File.join(File.dirname(__FILE__), 'spec_helper')

describe TestJS::Runner do
  before(:each) do
    $stdout.stub!(:puts)
    $stdout.stub!(:print)
    @runner = TestJS::Runner.new(File.join(TEST_JS_ROOT, 'examples', 'person_test.js'), :defer => true)
  end
  
  it "should have an evaluator" do
    @runner.instance_variable_get("@evaluator").class.should == TestJS::Evaluator
  end
end